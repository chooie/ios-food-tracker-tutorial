//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Charlie Hebert on 1/10/17.
//  Copyright © 2017 Charlie Hebert. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

  //MARK: Properties
  private var ratingButtons = [UIButton]()
  var rating = 0 {
    didSet {
      updateButtonSelectionStates()
    }
  }
  @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
    didSet {
      setupButtons()
    }
  }
  @IBInspectable var starCount: Int = 5 {
    didSet {
      setupButtons()
    }
  }

  //MARK: Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButtons()
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)
    setupButtons()
  }

  //MARK: Button Action
  func ratingButtonTapped(button: UIButton) {
    guard let index = ratingButtons.index(of: button) else {
      fatalError("The button, \(button), is not in the ratingButtons array: " +
        "\(ratingButtons)")
    }

    // Calculate the rating of the selected button
    let selectedRating = index + 1

    if selectedRating == rating {
      // If the selected star represents the current rating, reset the rating
      // to 0.
      rating = 0
    } else {
      // Otherwise set the rating to the selected star
      rating = selectedRating
    }
  }

  //MARK: Private methods
  private func setupButtons() {
    clearExistingButtons()
    let buttonImages: [String: UIImage] = loadStarImages()
    updateButtonSelectionStates()
    drawStarButtons(buttonImages: buttonImages)
  }

  private func clearExistingButtons() {
    for button in ratingButtons {
      removeArrangedSubview(button)
      button.removeFromSuperview()
    }
    ratingButtons.removeAll()
  }

  private func loadStarImages() -> [String: UIImage] {
    let bundle = Bundle(for: type(of: self))
    let filledStar = UIImage(
      named: "filledStar",
      in: bundle,
      compatibleWith: self.traitCollection
    )
    let emptyStar = UIImage(
      named:"emptyStar",
      in: bundle,
      compatibleWith: self.traitCollection
    )
    let highlightedStar = UIImage(
      named:"highlightedStar",
      in: bundle,
      compatibleWith: self.traitCollection
    )
    return [
      "filledStar": filledStar!,
      "emptyStar": emptyStar!,
      "highlightedStar": highlightedStar!
    ]
  }

  private func drawStarButtons(buttonImages: [String: UIImage]) {
    func setButtonConstraints(_ button: UIButton) {
      button.translatesAutoresizingMaskIntoConstraints = false
      button.heightAnchor.constraint(equalToConstant: starSize.height)
        .isActive = true
      button.widthAnchor.constraint(equalToConstant: starSize.width)
        .isActive = true
    }

    func addButtonToStack(_ button: UIButton) {
      addArrangedSubview(button)
    }

    func setButtonImagesForDifferentStates(button: UIButton,
                                           buttonImages: [String: UIImage]) {
      button.setImage(buttonImages["emptyStar"], for: UIControlState.normal)
      button.setImage(buttonImages["filledStar"], for: UIControlState.selected)
      button.setImage(buttonImages["highlightedStar"],
                      for: UIControlState.highlighted)
      button.setImage(buttonImages["highlightedStar"],
                      for: [UIControlState.highlighted,
                            UIControlState.selected])
    }

    for index in 0..<starCount {
      let button = UIButton()
      setButtonImagesForDifferentStates(button: button,
                                        buttonImages: buttonImages)
      setButtonConstraints(button)
      // Set the accessibility label
      button.accessibilityLabel = "Set \(index + 1) star rating"
      button.addTarget(
        self,
        action: #selector(RatingControl.ratingButtonTapped(button:)),
        for: .touchUpInside
      )
      addButtonToStack(button)
      ratingButtons.append(button)
    }
  }

  private func updateButtonSelectionStates() {
    for (index, button) in ratingButtons.enumerated() {
      button.isSelected = index < rating
      let hintString: String?
      if index + 1 == rating {
        hintString = "Tap to reset the rating to zero"
      } else {
        hintString = nil
      }

      let valueString: String
      switch (rating) {
      case 0:
        valueString = "No rating set."
      case 1:
        valueString = "1 star set."
      default:
        valueString = "\(rating) stars set."
      }
      // Assign the hint string and value string
      button.accessibilityHint = hintString
      button.accessibilityValue = valueString
    }
  }
}
