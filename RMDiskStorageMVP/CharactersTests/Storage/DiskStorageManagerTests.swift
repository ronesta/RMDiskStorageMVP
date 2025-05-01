//
//  DiskStorageManagerTests.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 26.03.2025.
//

import XCTest
@testable import RMDiskStorageMVP

final class DiskStorageManagerTests: XCTestCase {
    private var storageManager: DiskStorageManager!
    private var mockFileManager: MockFileManager!
    private var documentsDirectory: URL!

    override func setUpWithError() throws {
        super.setUp()
        mockFileManager = MockFileManager()
        storageManager = DiskStorageManager(fileManager: mockFileManager)
        documentsDirectory = mockFileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("characters.json")
        try? mockFileManager.removeItem(at: fileURL)

    }

    override func tearDownWithError() throws {
        let contents = mockFileManager.storage.keys

        for file in contents {
            try? mockFileManager.removeItem(at: URL(fileURLWithPath: file))
        }

        storageManager = nil
        super.tearDown()
    }

    func testGivenCharacters_WhenSaveCharacters_ThenReturnsSameCharacters() throws {
        // Given
        let testCharacters = [
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

        // When
        storageManager.saveCharacters(testCharacters)
        let loadedCharacters = storageManager.loadCharacters()

        // Then
        XCTAssertNotNil(loadedCharacters)
        XCTAssertEqual(testCharacters, loadedCharacters)
    }

    func testGivenNotExistFile_WhenLoadCharacters_ThenReturnsNil() {
        // Given
        // File does not exist

        // When
        let loadedCharacters = storageManager.loadCharacters()

        // Then
        XCTAssertNil(loadedCharacters)
    }

    func testGivenImageData_WhenSaveImage_ThenReturnsSameImageData() throws {
        // Given
        let imageData = "TestImage".data(using: .utf8)!
        let imageKey = "testImageKey"

        // When
        storageManager.saveImage(imageData, key: imageKey)
        let loadedImageData = storageManager.loadImage(key: imageKey)

        // Then
        XCTAssertNotNil(loadedImageData)
        XCTAssertEqual(imageData, loadedImageData)
    }

    func testGivenNonExistImageKey_WhenLoadImage_ThenReturnsNil() {
        // Given
        let nonExistentKey = "nonExistentKey"

        // When
        let loadedImageData = storageManager.loadImage(key: nonExistentKey)

        // Then
        XCTAssertNil(loadedImageData)
    }

    func testGivenInvalidImageKey_WhenSaveImage_ThenLoadImageReturnsNil() {
        // Given
        let imageData = Data()
        let invalidKey = "/invalid/path/imageKey"

        // When
        storageManager.saveImage(imageData, key: invalidKey)
        let loadedData = storageManager.loadImage(key: invalidKey)

        // Then
        XCTAssertNil(loadedData)
    }

    func testGivenInvalidCharactersData_WhenSaveCharacters_ThenThrowsError() {
        // Given
        let mockJSON = """
        {
            "results": [
                { "invalidKey": "value" }
            ]
        }
        """

        let invalidData = mockJSON.data(using: .utf8)!
        let fileURL = documentsDirectory.appendingPathComponent("invalidPath/characters.json")

        // When
        do {
            try invalidData.write(to: fileURL)
            XCTFail("Expected writing to invalid path to fail")
        } catch {
            // Then
            XCTAssertNotNil(error)
        }
    }
}
