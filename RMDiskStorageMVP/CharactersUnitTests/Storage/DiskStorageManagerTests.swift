//
//  DiskStorageManagerTests.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 26.03.2025.
//

import XCTest
@testable import RMDiskStorageMVP

final class DiskStorageManagerTests: XCTestCase {
    var storageManager: DiskStorageManager!
    var fileManager: FileManager!
    var documentsDirectory: URL!

    override func setUpWithError() throws {
        super.setUp()
        storageManager = DiskStorageManager()
        fileManager = FileManager.default
        documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("characters.json")
        try? fileManager.removeItem(at: fileURL)

    }

    override func tearDownWithError() throws {
        let contents = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
        for file in contents {
            try? fileManager.removeItem(at: file)
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
        let invalidKey = "/invalid/path/imageKey"
        let imageData = "TestImage".data(using: .utf8)!

        storageManager.saveImage(imageData, key: invalidKey)
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
