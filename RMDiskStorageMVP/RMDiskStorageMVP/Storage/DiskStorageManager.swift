//
//  StorageManager.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 09.01.2025.
//

import Foundation

final class DiskStorageManager: StorageManagerProtocol {
    private let fileManager = FileManager.default

    private var documentsDirectory: URL {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    func saveCharacters(_ characters: [Character]) {
        let fileURL = documentsDirectory.appendingPathComponent("characters.json")
        do {
            let data = try JSONEncoder().encode(characters)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save characters: \(error.localizedDescription)")
        }
    }

    func loadCharacters() -> [Character]? {
        let fileURL = documentsDirectory.appendingPathComponent("characters.json")

        guard let data = try? Data(contentsOf: fileURL),
              let characters = try? JSONDecoder().decode([Character].self, from: data) else {
            return nil
        }

        return characters
    }

    func saveImage(_ data: Data, key: String) {
        let fileURL = documentsDirectory.appendingPathComponent("\(key)")

        do {
            try data.write(to: fileURL)
        } catch {
            print("Failed to save image: \(error.localizedDescription)")
        }
    }

    func loadImage(key: String) -> Data? {
        let fileURL = documentsDirectory.appendingPathComponent("\(key)")

        guard fileManager.fileExists(atPath: fileURL.path) else {
            return nil
        }

        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            print("Error loading image: \(error.localizedDescription)")
            return nil
        }
    }
}
