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

    override func setUp() {
        super.setUp()
        service = CharactersService()
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func testGetCharactersValidURL() {
        let expectation = XCTestExpectation(description: "Valid URL")

        service.getCharacters { result in
            switch result {
            case .success(let characters):
                XCTAssertNotNil(characters)
                XCTAssertGreaterThan(characters.count, 0)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error.localizedDescription)")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testGetCharactersInvalidURL() {
        let service = CharactersService(urlString: "invalid_url")
        let expectation = expectation(description: "Invalid URL error")

        service.getCharacters { result in
            switch result {
            case .success(let characters):
                XCTFail("Expected failure, but got success with characters: \(characters)")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.invalidURL)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testDecodingError() {
        let mockService = MockCharactersServiceWithInvalidJSON()
        let expectation = XCTestExpectation(description: "Decoding error")

        mockService.getCharacters { result in
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
