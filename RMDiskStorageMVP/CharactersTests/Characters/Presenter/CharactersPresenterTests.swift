//
//  CharactersPresenterTests.swift
//  CharactersPresenterTests
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

import XCTest
@testable import RMDiskStorageMVP

final class CharactersPresenterTests: XCTestCase {
    private var presenter: CharactersPresenter!
    private var mockView: MockCharactersView!
    private var mockService: MockCharactersService!
    private var mockStorageManager: MockStorageManager!

    override func setUp() {
        super.setUp()
        mockView = MockCharactersView()
        mockService = MockCharactersService()
        mockStorageManager = MockStorageManager()
        presenter = CharactersPresenter(charactersService: mockService,
                                        storageManager: mockStorageManager
        )
        presenter.view = mockView
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockService = nil
        mockStorageManager = nil
        super.tearDown()
    }

    func testGivenSavedCharacters_WhenViewDidLoad_ThenCharactersAreDisplayedFromStorage() {
        // Given
        let savedCharacters = [
            Character(name: "Summer Smith",
                      status: "Alive",
                      species: "Human",
                      gender: "Female",
                      location: Location(name: "Earth (C-137)"),
                      image: "url_to_image"
                     ),
            Character(name: "Beth Smith",
                      status: "Alive",
                      species: "Human",
                      gender: "Female",
                      location: Location(name: "Earth (C-137)"),
                      image: "url_to_image"
                     )
        ]

        mockStorageManager.saveCharacters(savedCharacters)

        // When
        presenter.viewDidLoad()

        // Then
        XCTAssertEqual(mockView.updateCharactersCallCount, 1)
        XCTAssertEqual(mockView.updateCharactersArgsCharacters.first, savedCharacters)
        XCTAssertEqual(mockView.showErrorCallCount, 0)

    }

    func testGivenNoSavedCharacters_WhenViewDidLoad_ThenCharactersAreFetchedAndDisplayed() {
        // Given
        let fetchedCharacters = [
            Character(name: "Rick Sanchez",
                      status: "Alive",
                      species: "Human",
                      gender: "Male",
                      location: Location(name: "Earth (C-137)"),
                      image: "url_to_image"
                     ),
            Character(name: "Morty Smith",
                      status: "Alive",
                      species: "Human",
                      gender: "Male",
                      location: Location(name: "Earth (C-137)"),
                      image: "url_to_image"
                     )

        ]

        mockService.stubbedCharactersResult = .success(fetchedCharacters)

        // When
        presenter.viewDidLoad()

        // Then
        XCTAssertEqual(mockService.getCharactersCallCount, 1)
        XCTAssertEqual(mockView.updateCharactersCallCount, 1)
        XCTAssertEqual(mockView.updateCharactersArgsCharacters.first, fetchedCharacters)
        XCTAssertEqual(mockView.showErrorCallCount, 0)
        XCTAssertEqual(mockStorageManager.characters, fetchedCharacters)
    }

    func testGivenServiceFailure_WhenViewDidLoad_ThenErrorIsDisplayed() {
        // Given
        let expectedError = NSError(domain: "Test", code: 0, userInfo: nil)
        mockService.stubbedCharactersResult = .failure(expectedError)

        // When
        presenter.viewDidLoad()

        // Then
        XCTAssertEqual(mockService.getCharactersCallCount, 1)
        XCTAssertEqual(mockView.showErrorCallCount, 1)
        XCTAssertEqual(mockView.updateCharactersCallCount, 0)
    }
}
