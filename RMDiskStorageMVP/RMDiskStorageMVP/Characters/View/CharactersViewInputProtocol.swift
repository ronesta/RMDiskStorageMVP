//
//  CharacterViewProtocol.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 14.01.2025.
//

import Foundation

protocol CharactersViewInputProtocol: AnyObject {
    func updateCharacters(_ characters: [Character])
    
    func showError(_ message: String)
}
