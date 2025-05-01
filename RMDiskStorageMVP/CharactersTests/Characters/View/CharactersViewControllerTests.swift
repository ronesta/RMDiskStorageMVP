//
//  CharactersViewControllerTests.swift
//  CharactersPresenterTests
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

import XCTest
import ViewControllerPresentationSpy
@testable import RMDiskStorageMVP

final class CharactersViewControllerTests: XCTestCase {
    private var viewController: CharactersViewController!
    private var mockPresenter: MockPresenter!
    private var mockDataSource: MockDataSource!

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

    func testGivenViewController_WhenViewDidLoad_ThenPresenterViewDidLoadIsCalled() {
        // Given
        // ViewController initialized with mockPresenter & mockDataSource

        // When
        viewController.viewDidLoad()

        // Then
        XCTAssertTrue(mockPresenter.viewDidLoadCalled)
    }

    func testGivenViewController_WhenViewDidLoad_ThenTableViewIsConfigured() {
        // Given
        // ViewController initialized with mockPresenter & mockDataSource

        // When
        viewController.viewDidLoad()

        // Then
        XCTAssertNotNil(viewController.tableView.dataSource)
        XCTAssertTrue(viewController.tableView.dataSource === mockDataSource)

        XCTAssertNotNil(viewController.tableView.delegate)
        XCTAssertTrue(viewController.tableView.delegate === viewController)
    }

    func testGivenCharacters_WhenUpdateCharacters_ThenDataSourceIsUpdated() {
        // Given
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

        // When
        viewController.updateCharacters(characters)

        // Then
        XCTAssertEqual(mockDataSource.characters, characters)
    }

    @MainActor func testGivenErrorMessage_WhenShowError_ThenDisplaysAlert() {
        // Given
        let errorMessage = "Test Error"
        let alertVerifier = AlertVerifier()

        // When
        viewController.showError(errorMessage)

        // Then
        alertVerifier.verify(
            title: "Error",
            message: "Test Error",
            animated: true,
            actions: [
                .default("OK")
            ],
            presentingViewController: viewController
        )
    }
}
