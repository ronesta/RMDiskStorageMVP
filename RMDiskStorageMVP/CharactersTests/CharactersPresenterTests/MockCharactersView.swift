//
//  MockCharactersView.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

@testable import RMDiskStorageMVP

final class MockCharactersView: CharactersViewProtocol {
    var characters: [Character]?
    var errorMessage: String?

    func updateCharacters(_ characters: [Character]) {
        self.characters = characters
    }

    func showError(_ message: String) {
        errorMessage = message
    }
}
