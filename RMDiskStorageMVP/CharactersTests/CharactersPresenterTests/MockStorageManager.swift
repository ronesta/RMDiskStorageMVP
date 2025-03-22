//
//  MockStorageManager.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

import Foundation
@testable import RMDiskStorageMVP

final class MockStorageManager: StorageManagerProtocol {
    var savedCharacters: [Character]?
    var savedImages = [String: Data]()

    func saveCharacters(_ characters: [Character]) {
        savedCharacters = characters
    }

    func loadCharacters() -> [Character]? {
        return savedCharacters
    }

    func saveImage(_ image: Data, key: String) {
        savedImages[key] = image
    }

    func loadImage(key: String) -> Data? {
        return savedImages[key]
    }
}
