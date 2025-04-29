//
//  CharacterPresenter.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 14.01.2025.
//

import Foundation

final class CharactersPresenter: CharactersPresenterProtocol {
    weak var view: CharactersViewProtocol?

    private let charactersService: CharactersServiceProtocol
    private let storageManager: StorageManagerProtocol

    private var characters = [Character]()

    init(charactersService: CharactersServiceProtocol,
         storageManager: StorageManagerProtocol
    ) {
        self.charactersService = charactersService
        self.storageManager = storageManager
    }

    func viewDidLoad() {
        getCharacters()
    }

    private func getCharacters() {
        if let savedCharacters = storageManager.loadCharacters() {
            characters = savedCharacters
            view?.updateCharacters(characters)
            return
        }

        charactersService.getCharacters { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .success(let characters):
                self.characters = characters
                self.view?.updateCharacters(characters)
                self.storageManager.saveCharacters(characters)
            case .failure(let error):
                self.view?.showError(error.localizedDescription)
            }
        }
    }
}
