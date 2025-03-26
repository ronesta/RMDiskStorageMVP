//
//  StorageManagerMock.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 26.03.2025.
//

import Foundation
@testable import RMDiskStorageMVP

final class StorageManagerMock: StorageManagerProtocol {
    var imageData: Data?
    var characters: [Character]?

    func loadImage(key: String) -> Data? {
        return imageData
    }

    func saveImage(_ data: Data, key: String) {
        self.imageData = data
    }

    func saveCharacters(_ characters: [Character]) {
        self.characters = characters
    }

    func loadCharacters() -> [Character]? {
        return characters
    }
}
