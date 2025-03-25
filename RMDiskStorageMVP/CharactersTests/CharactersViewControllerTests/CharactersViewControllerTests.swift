//
//  CharactersViewControllerTests.swift
//  CharactersPresenterTests
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

import XCTest
@testable import RMDiskStorageMVP

final class CharactersViewControllerTests: XCTestCase {
    var viewController: CharactersViewController!
    var mockPresenter: MockPresenter!
    var mockDataSource: MockDataSource!

    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        mockDataSource = MockDataSource()
        viewController = CharactersViewController(presenter: mockPresenter,
                                                  tableViewDataSource: mockDataSource
        )
    }

    override func tearDown() {
        viewController = nil
        mockPresenter = nil
        mockDataSource = nil
        super.tearDown()
    }

    func testViewDidLoadCallsPresenterViewDidLoad() {
        viewController.viewDidLoad()

        XCTAssertTrue(mockPresenter.viewDidLoadCalled)
    }

    func testSetupViews() {
        viewController.viewDidLoad()

        XCTAssertNotNil(viewController.tableView.dataSource)
        XCTAssertTrue(viewController.tableView.dataSource === mockDataSource)

        XCTAssertNotNil(viewController.tableView.delegate)
        XCTAssertTrue(viewController.tableView.delegate === viewController)
    }

    func testUpdateCharactersReloadsData() {
        let characters = [
            Character(name: "John Doe",
                      status: "Alive",
                      species: "Human",
                      gender: "Male",
                      location: Location(name: "Earth"),
                      image: "image_url"
                     ),
            Character(name: "Morty Smith",
                      status: "Alive",
                      species: "Human",
                      gender: "Male",
                      location: Location(name: "Earth (C-137)"),
                      image: "url_to_image"
                     )
        ]

        viewController.updateCharacters(characters)

        XCTAssertEqual(mockDataSource.characters, characters)
    }

    func testShowErrorDisplaysAlert() {
        let errorMessage = "Test Error"
        let expectation = expectation(description: "Wait for alert presentation")

        let window = UIWindow()
        window.rootViewController = viewController
        window.makeKeyAndVisible()

        viewController.showError(errorMessage)

        DispatchQueue.main.async {
            guard let alertController = try? XCTUnwrap(self.viewController.presentedViewController as? UIAlertController) else {
                return
            }
            XCTAssertEqual(alertController.message, errorMessage)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
