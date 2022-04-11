//
//  FetchRewardsIOSChallangeTests.swift
//  FetchRewardsIOSChallangeTests
//
//  Created by Emre Yasa on 4/8/22.
//

import XCTest
@testable import FetchRewardsIOSChallange

class FetchRewardsIOSChallangeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFRDessetMealModel() {
        let meal = Desserts(name: "Apam balik", urlToImage: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert", idMeal: "53049")
        let dessertTVViewModel = FRDessertCellViewModel(meals: meal)

        XCTAssertEqual(meal.name, dessertTVViewModel.title)
        XCTAssertEqual(URL(string: meal.urlToImage ?? ""), dessertTVViewModel.imageURL)
        XCTAssertEqual(meal.idMeal, dessertTVViewModel.idMeal)
    }
    
    func testFRDetailViewModel() {
        let dessertById = DessertsById(name: "Tart", id: "324", instructions: "fdsf sdfk fsd ", urlToImage: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")
        let dessertDetailViewModel = FRDessertDetailViewModel(dessert: dessertById)
        
        XCTAssertEqual(dessertById.name, dessertDetailViewModel.title)
        XCTAssertEqual(dessertById.id, dessertDetailViewModel.idMeal)
        XCTAssertEqual(URL(string: dessertById.urlToImage), dessertDetailViewModel.imageURL)
    }

}
