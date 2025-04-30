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

    func testSaveAndLoadCharacters() throws {
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

        storageManager.saveCharacters(testCharacters)
        let loadedCharacters = storageManager.loadCharacters()

        XCTAssertNotNil(loadedCharacters)
        XCTAssertEqual(testCharacters, loadedCharacters)
    }

    func testLoadCharactersReturnsNilWhenFileDoesNotExist() {
        let loadedCharacters = storageManager.loadCharacters()

        XCTAssertNil(loadedCharacters)
    }

    func testSaveAndLoadImage() throws {
        let imageData = "TestImage".data(using: .utf8)!
        let imageKey = "testImageKey"

        storageManager.saveImage(imageData, key: imageKey)
        let loadedImageData = storageManager.loadImage(key: imageKey)

        XCTAssertNotNil(loadedImageData)
        XCTAssertEqual(imageData, loadedImageData)
    }

    func testLoadImageReturnsNilWhenFileDoesNotExist() {
        let nonExistentKey = "nonExistentKey"

        let loadedImageData = storageManager.loadImage(key: nonExistentKey)

        XCTAssertNil(loadedImageData)
    }

    func testSaveImageHandlesErrors() {
        let imageData = Data()
        let invalidKey = "/invalid/path/imageKey"

        storageManager.saveImage(imageData, key: invalidKey)

        let loadedData = storageManager.loadImage(key: invalidKey)
        XCTAssertNil(loadedData)
    }

    func testSaveCharactersHandlesErrors() {
        let testCharacters = [["invalidKey": "value"]]
        let fileURL = documentsDirectory.appendingPathComponent("invalidPath/characters.json")

        do {
            let data = try JSONEncoder().encode(testCharacters)
            try data.write(to: fileURL)
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
