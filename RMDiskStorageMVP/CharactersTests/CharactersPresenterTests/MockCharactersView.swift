//
//  MockCharactersView.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

@testable import RMDiskStorageMVP

final class MockCharactersView: CharactersViewProtocol {
    var characters: [Character]?
    var updateCharactersCalled = false

    var errorMessage: String?
    var showErrorCalled = false

    func updateCharacters(_ characters: [Character]) {
        updateCharactersCalled = true
        self.characters = characters
    }

    func showError(_ message: String) {
        showErrorCalled = true
        errorMessage = message
    }
}
