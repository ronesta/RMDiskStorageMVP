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

    func testGetCharactersSuccess() {
        let characters = [
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

        let postCharacters = PostCharacters(results: characters)
        let data = try! JSONEncoder().encode(postCharacters)

        mockURLSession.data = data
        mockURLSession.error = nil

        service.getCharacters { result in
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

    func testGetCharactersFailure_noData() {
        mockURLSession.data = nil
        mockURLSession.error = nil

        service.getCharacters { result in
            switch result {
            case .success:
                XCTFail("Should fail with no data")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.noData)
            }
        }
    }

    func testGetCharactersFailure_invalidData() {
        mockURLSession.data = Data([0x00, 0x01, 0x02])
        mockURLSession.error = nil

        service.getCharacters { result in
            switch result {
            case .success:
                XCTFail("Should fail")
            case .failure(let error):
                XCTAssertTrue(error is DecodingError)
            }
        }
    }

    func testGetCharactersFailure_errorFromSession() {
        mockURLSession.data = nil
        mockURLSession.error = NSError(domain: "", code: -1, userInfo: nil)

        let expectation = expectation(description: "Failure completion called")

        service.getCharacters { result in
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
