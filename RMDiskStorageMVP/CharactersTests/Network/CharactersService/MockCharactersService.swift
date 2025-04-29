//
//  MockCharactersService.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

import Foundation
@testable import RMDiskStorageMVP

final class MockCharactersService: CharactersServiceProtocol {
    private(set) var getCharactersCallCount = 0
    private(set) var getCharactersCompletions = [(Result<[Character], Error>) -> Void]()

    var stubbedCharactersResult: Result<[Character], Error>?

    func getCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        getCharactersCallCount += 1
        getCharactersCompletions.append(completion)

        if let result = stubbedCharactersResult {
            completion(result)
        }
    }
}
