//
//  SpyCharactersPresenter.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 22.03.2025.
//

@testable import RMDiskStorageMVP

final class SpyCharactersPresenter: CharactersPresenter {
    var getCharactersCalled = false
    
    override func getCharacters() {
        getCharactersCalled = true
        super.getCharacters()
    }
}
