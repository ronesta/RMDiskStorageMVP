//
//  CharactersServiceTests.swift
//  CharactersPresenterTests
//
//  Created by Ибрагим Габибли on 24.03.2025.
//

import XCTest
@testable import RMDiskStorageMVP

final class CharactersServiceTests: XCTestCase {
    private var service: CharactersService!
    private var mockURLSession: MockURLSession!
    private var mockDispatchQueue: MockDispatchQueue!

    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        mockDispatchQueue = MockDispatchQueue()
        service = CharactersService(
            urlSession: mockURLSession,
            dispatchQueue: mockDispatchQueue
        )
    }

    override func tearDown() {
        service = nil
        mockURLSession = nil
        mockDispatchQueue = nil
        super.tearDown()
    }

    func testGivenValidResponse_WhenGetCharacters_ThenReturnsCharactersArray() {
        // Given
        let characters = [
            Character(
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                gender: "Male",
                location: Location(name: "Earth (C-137)"),
                image: "url_to_image"
            ),
            Character(
                name: "Morty Smith",
                status: "Alive",
                species: "Human",
                gender: "Male",
                location: Location(name: "Earth (C-137)"),
                image: "url_to_image"
            )
        ]
        
        let postCharacters = PostCharacters(results: characters)
        let data = try! JSONEncoder().encode(postCharacters)
        mockURLSession.data = data
        mockURLSession.error = nil

        // When
        service.getCharacters { result in
            // Then
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.count, 2)
                XCTAssertEqual(characters[0].name, "Rick Sanchez")
                XCTAssertEqual(characters[1].name, "Morty Smith")
            case .failure:
                XCTFail("Expected success, got failure instead")
            }
        }
    }

    func testGivenNoData_WhenGetCharacters_ThenReturnsNoDataError() {
        // Given
        mockURLSession.data = nil
        mockURLSession.error = nil

        // When
        service.getCharacters { result in
            // Then
            switch result {
            case .success:
                XCTFail("Should fail with no data")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.noData)
            }
        }
    }

    func testGivenInvalidData_WhenGetCharacters_ThenReturnsDecodingError() {
        // Given
        mockURLSession.data = Data()
        mockURLSession.error = nil

        // When
        service.getCharacters { result in
            // Then
            switch result {
            case .success:
                XCTFail("Should fail")
            case .failure(let error):
                XCTAssertTrue(error is DecodingError)
            }
        }
    }

    func testGivenSessionError_WhenGetCharacters_ThenReturnsError() {
        // Given
        mockURLSession.data = nil
        mockURLSession.error = NSError(domain: "", code: -1, userInfo: nil)
        let expectation = expectation(description: "Failure completion called")

        // When
        service.getCharacters { result in
            // Then
            switch result {
            case .success:
                XCTFail("Should fail with error from session")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
