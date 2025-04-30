//
//  MockCharactersView.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

@testable import RMDiskStorageMVP

final class MockCharactersView: CharactersViewInputProtocol {
    private(set) var updateCharactersCallCount = 0
    private(set) var updateCharactersArgsCharacters = [[Character]]()

    private(set) var showErrorCallCount = 0
    private(set) var showErrorArgsMessages = String()

    func updateCharacters(_ characters: [Character]) {
        updateCharactersCallCount += 1
        updateCharactersArgsCharacters.append(characters)
    }

    func showError(_ message: String) {
        showErrorCallCount += 1
        showErrorArgsMessages.append(message)
    }
}
