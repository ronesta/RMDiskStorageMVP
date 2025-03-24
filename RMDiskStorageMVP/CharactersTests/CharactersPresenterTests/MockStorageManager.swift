//
//  MockStorageManager.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

import Foundation
@testable import RMDiskStorageMVP

final class MockStorageManager: StorageManagerProtocol {
    var characters: [Character]?
    var images = [String: Data]()

    func saveCharacters(_ characters: [Character]) {
        self.characters = characters
    }

    func loadCharacters() -> [Character]? {
        return characters
    }

    func saveImage(_ image: Data, key: String) {
        images[key] = image
    }

    func loadImage(key: String) -> Data? {
        return images[key]
    }
}
