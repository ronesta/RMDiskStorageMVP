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
    private var mockService: MockCharactersServiceForPresenter!
    private var mockStorageManager: MockStorageManager!

    override func setUp() {
        super.setUp()
        mockView = MockCharactersView()
        mockService = MockCharactersServiceForPresenter()
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

    func testViewDidLoadCallsGetCharacters() {
        let spyPresenter = SpyCharactersPresenter(charactersService: mockService, storageManager: mockStorageManager)

        spyPresenter.view = mockView
        spyPresenter.viewDidLoad()

        XCTAssertTrue(spyPresenter.getCharactersCalled)
    }

    func testViewDidLoadWhenCharactersAreSaved() {
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

        presenter.viewDidLoad()

        XCTAssertEqual(mockView.characters, savedCharacters)
        XCTAssertNil(mockView.errorMessage)
    }

    func testViewDidLoadWhenCharactersAreNotSaved() {
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

        mockService.characters = fetchedCharacters

        presenter.viewDidLoad()

        XCTAssertEqual(mockView.characters, fetchedCharacters)
        XCTAssertNil(mockView.errorMessage)
        XCTAssertEqual(mockStorageManager.characters, fetchedCharacters)
    }

    func testGetCharactersFailureShowsError() {
        mockService.shouldReturnError = true

        presenter.viewDidLoad()

        XCTAssertNotNil(mockView.errorMessage)
        XCTAssertNil(mockView.characters)
    }
}
