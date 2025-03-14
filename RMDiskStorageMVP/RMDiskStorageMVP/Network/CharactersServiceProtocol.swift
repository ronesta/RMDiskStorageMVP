//
//  NetworkManagerProtocol.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 14.01.2025.
//

import Foundation

protocol CharactersServiceProtocol {
    func getCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
}
