//
//  DataManager.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 24.03.2025.
//

import Foundation
@testable import RMDiskStorageMVP

final class DataManager {
    private let charactersService: CharactersServiceProtocol

    init(charactersService: CharactersServiceProtocol) {
        self.charactersService = charactersService
    }

    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        charactersService.getCharacters { result in
            switch result {
            case .success(let characters):
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
