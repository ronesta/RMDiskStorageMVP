//
//  MockCharactersService.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

import Foundation
@testable import RMDiskStorageMVP

final class MockCharactersService: CharactersServiceProtocol {
    var shouldReturnError = false
    var characters = [Character]()

    func getCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "Test", code: 0, userInfo: nil)))
        } else {
            completion(.success(characters))
        }
    }
}
