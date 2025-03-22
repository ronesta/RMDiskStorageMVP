//
//  CharactersPresenterTests.swift
//  CharactersPresenterTests
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

import XCTest
@testable import RMDiskStorageMVP

final class CharactersPresenterTests: XCTestCase {
    var presenter: CharactersPresenter!
    var mockView: MockCharactersView!
    var mockService: MockCharactersService!
    var mockStorageManager: MockStorageManager!

    override func setUp() {
        super.setUp()
        mockView = MockCharactersView()
        mockService = MockCharactersService()
        mockStorageManager = MockStorageManager()
        presenter = CharactersPresenter(charactersService: mockService, storageManager: mockStorageManager)
        presenter.view = mockView
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockService = nil
        mockStorageManager = nil
        super.tearDown()
    }

    func testViewDidLoadCallsGetCharacters() {
        let spyPresenter = SpyCharactersPresenter(charactersService: mockService, storageManager: mockStorageManager)

        spyPresenter.view = mockView
        spyPresenter.viewDidLoad()

        XCTAssertTrue(spyPresenter.getCharactersCalled)
    }

    func testGetCharactersSuccessCallsUpdateCharacters() {
        let expectedCharacters = [
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

        mockService.characters = expectedCharacters

        presenter.viewDidLoad()

        XCTAssertTrue(mockView.updateCharactersCalled)
        XCTAssertEqual(mockView.characters, expectedCharacters)
    }

    func testGetCharactersFailureShowsError() {
        mockService.shouldReturnError = true

        presenter.viewDidLoad()

        XCTAssertTrue(mockView.showErrorCalled)
        XCTAssertNotNil(mockView.errorMessage)
    }
}
