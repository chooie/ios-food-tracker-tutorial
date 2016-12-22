//
//  ViewController.swift
//  FoodTracker
//
//  Created by Charlie Hebert on 12/20/16.
//  Copyright © 2016 Charlie Hebert. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  //MARK: Properties
  @IBOutlet weak var mealNameLabel: UILabel!
  @IBOutlet weak var nameTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    nameTextField.delegate = self
  }

  //MARK: UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    mealNameLabel.text = nameTextField.text
  }

  //MARK: Actions
  @IBAction func setDefaultLabelText(_ sender: UIButton) {
    mealNameLabel.text = "Default Text"
  }
}

