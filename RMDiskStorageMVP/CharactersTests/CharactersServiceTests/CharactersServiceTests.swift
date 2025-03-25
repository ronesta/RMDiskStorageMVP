//
//  CharactersServiceTests.swift
//  CharactersPresenterTests
//
//  Created by Ибрагим Габибли on 24.03.2025.
//

import XCTest
@testable import RMDiskStorageMVP

final class DataManagerTests: XCTestCase {
    var dataManager: DataManager!
    var mockNetworking: MockNetworking!

    override func setUp() {
        super.setUp()
        mockNetworking = MockNetworking()
        dataManager = DataManager(charactersService: mockNetworking)
    }

    override func tearDown() {
        dataManager = nil
        mockNetworking = nil
        super.tearDown()
    }

    func testFetchingDataSuccessfully() {
        let expectedCharacters = [
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

        mockNetworking.characters = expectedCharacters

        var actualCharacters: [Character]?
        dataManager.fetchCharacters { result in
            switch result {
            case .success(let characters):
                actualCharacters = characters
            case .failure:
                XCTFail()
            }
        }

        XCTAssertEqual(actualCharacters, expectedCharacters)
    }

    func testFetchingDataWithError() {
        mockNetworking.shouldReturnError = true

        var receivedError: Error?

        dataManager.fetchCharacters { result in
            switch result {
            case .success: XCTFail()
            case .failure(let error):
                receivedError = error
            }
        }

        XCTAssertNotNil(receivedError)
    }
}

//final class CharactersServiceTests: XCTestCase {
//    var service: CharactersService!
//
//    override func setUp() {
//        super.setUp()
//        service = CharactersService()
//    }
//
//    override func tearDown() {
//        service = nil
//        super.tearDown()
//    }
//
//    func testGetCharactersValidURL() {
//        let expectation = XCTestExpectation(description: "Valid URL")
//
//        service.getCharacters { result in
//            switch result {
//            case .success(let characters):
//                XCTAssertNotNil(characters, "Characters should not be nil")
//                expectation.fulfill()
//            case .failure(let error):
//                XCTFail("Expected success, but got error: \(error.localizedDescription)")
//            }
//        }
//
//        wait(for: [expectation], timeout: 5.0)
//    }
//
//    func testGetCharactersInvalidURL() {
//        service.urlString = "invalid-url"
//        let expectation = expectation(description: "Invalid URL")
//
//        service.getCharacters { result in
//            switch result {
//            case .success(let characters):
//                XCTFail("Expected failure, but got success with characters: \(characters)")
//            case .failure(let error):
//                XCTAssertEqual(error.localizedDescription, NetworkError.invalidURL.localizedDescription)
//                expectation.fulfill()
//            }
//        }
//
//        wait(for: [expectation], timeout: 5.0)
//    }
//
//    func testDecodingError() {
//        // Проверка на случай ошибки декодирования
//        let expectation = XCTestExpectation(description: "Decoding Error")
//        service.urlString = "https://rickandmortyapi.com/api/character"
//
//        service.getCharacters { result in
//            switch result {
//            case .success(let characters):
//                XCTFail("Expected failure, but got success with characters: \(characters)")
//            case .failure(let error):
//                XCTAssertNotNil(error, "Error should not be nil")
//                expectation.fulfill()
//            }
//        }
//
//        wait(for: [expectation], timeout: 5.0)
//    }
//}
