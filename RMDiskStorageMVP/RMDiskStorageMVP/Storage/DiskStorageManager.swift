//
//  StorageManager.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 09.01.2025.
//

import Foundation

final class DiskStorageManager: StorageManagerProtocol {
    private let fileManager: FileManager

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }

    private var documentsDirectory: URL {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    func saveCharacters(_ characters: [Character]) {
        let fileURL = documentsDirectory.appendingPathComponent("characters.json")

        do {
            let data = try JSONEncoder().encode(characters)
            let path = fileURL.path

            fileManager.createFile(atPath: path, contents: data, attributes: nil)
        } catch {
            print("Failed to save characters: \(error.localizedDescription)")
        }
    }

    func loadCharacters() -> [Character]? {
        let fileURL = documentsDirectory.appendingPathComponent("characters.json")
        let path = fileURL.path

        guard let data = fileManager.contents(atPath: path) else {
            return nil
        }

        return try? JSONDecoder().decode([Character].self, from: data)
    }

    func saveImage(_ data: Data, key: String) {
        let fileURL = documentsDirectory.appendingPathComponent("\(key)")
        let path = fileURL.path

        fileManager.createFile(atPath: path, contents: data, attributes: nil)
    }

    func loadImage(key: String) -> Data? {
        let fileURL = documentsDirectory.appendingPathComponent("\(key)")
        let path = fileURL.path

        guard fileManager.fileExists(atPath: path) else {
            return nil
        }

        return fileManager.contents(atPath: path)
    }
}
