//
//  StorageManager.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 09.01.2025.
//

import Foundation

final class DiskStorageManager {
    static let shared = DiskStorageManager()

    private let fileManager = FileManager.default
    private var documentsDirectory: URL {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    private init() {}

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

        guard fileManager.fileExists(atPath: fileURL.path) else {
            return nil
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let characters = try JSONDecoder().decode([Character].self, from: data)

            return characters
        } catch {
            print("Error loading characters: \(error.localizedDescription)")
            return nil
        }
    }

    func deleteCharacters() {
        let fileURL = documentsDirectory.appendingPathComponent("characters.json")

        do {
            if fileManager.fileExists(atPath: fileURL.path) {
                try fileManager.removeItem(at: fileURL)
            }
        } catch {
            print("Error deleting characters: \(error.localizedDescription)")
        }
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

    func deleteImage(key: String) {
        let fileURL = documentsDirectory.appendingPathComponent("\(key)")

        do {
            if fileManager.fileExists(atPath: fileURL.path) {
                try fileManager.removeItem(at: fileURL)
            }
        } catch {
            print("Error deleting image: \(error.localizedDescription)")
        }
    }
}
