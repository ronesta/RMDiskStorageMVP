//
//  MockCharactersService.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 25.03.2025.
//

import Foundation
@testable import RMDiskStorageMVP

final class MockedCharactersService: CharactersServiceProtocol {
    func getCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        let invalidJSON = "".data(using: .utf8)!

        do {
            let _ = try JSONDecoder().decode(PostCharacters.self, from: invalidJSON)
            completion(.success([]))
        } catch {
            completion(.failure(error))
        }
    }
}
