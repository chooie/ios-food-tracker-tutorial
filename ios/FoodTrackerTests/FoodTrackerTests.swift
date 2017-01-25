//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Charlie Hebert on 12/20/16.
//  Copyright © 2016 Charlie Hebert. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {

  //MARK: Meal Class Tests
  func testMealInitializationSucceeds() {
    let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
    XCTAssertNotNil(zeroRatingMeal)

    let highestPositiveRatingMeal = Meal.init(name: "Positive",
                                              photo: nil,
                                              rating: 5)
    XCTAssertNotNil(highestPositiveRatingMeal)
  }

  func testMealInitializationFails() {
    let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
    XCTAssertNil(negativeRatingMeal)

    let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
    XCTAssertNil(largeRatingMeal)

    let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
    XCTAssertNil(emptyStringMeal)
  }
}
