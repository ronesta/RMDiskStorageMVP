//
//  CharactersServiceTests.swift
//  CharactersPresenterTests
//
//  Created by Ибрагим Габибли on 24.03.2025.
//

import XCTest
@testable import RMDiskStorageMVP

final class CharactersServiceTests: XCTestCase {
    private var service: MockCharactersService!

    override func setUp() {
        super.setUp()
        service = MockCharactersService()
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func testGetCharactersSuccess() {
        let sampleCharacters = [
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

        service.mockResult = .success(sampleCharacters)

        let expectation = expectation(description: "Characters fetched successfully")

        service.getCharacters { result in
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.count, 2)
                XCTAssertEqual(characters[0].name, "Rick Sanchez")
                XCTAssertEqual(characters[1].name, "Morty Smith")
            case .failure:
                XCTFail("Expected success, got failure instead")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetCharactersFailure() {
        service.mockResult = .failure(NetworkError.noData)

        let expectation = expectation(description: "Failed to fetch characters")

        service.getCharacters { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success instead")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.noData)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testDecodingError() {
        let expectation = XCTestExpectation(description: "Decoding error")

        service.getCharactersWithInvalidJSON { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertTrue(error is DecodingError, "Expected a decoding error")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
