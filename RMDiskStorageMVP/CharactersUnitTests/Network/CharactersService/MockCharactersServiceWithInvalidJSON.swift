//
//  MockCharactersServiceWithInvalidJSON.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 26.03.2025.
//

import Foundation
@testable import RMDiskStorageMVP

final class MockCharactersServiceWithInvalidJSON: CharactersServiceProtocol {
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
