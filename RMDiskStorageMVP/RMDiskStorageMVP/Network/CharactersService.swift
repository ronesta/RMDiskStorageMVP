//
//  NetworkManager.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 09.01.2025.
//

import Foundation
import UIKit

final class CharactersService: CharactersServiceProtocol {
    private var counter = 1

    private let urlString: String

    init(urlString: String = "https://rickandmortyapi.com/api/character") {
        self.urlString = urlString
    }

    func getCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let url = URL(string: urlString),
        UIApplication.shared.canOpenURL(url) else {
            print("Invalid URL")
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data else {
                print("No data")
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }

            do {
                let character = try JSONDecoder().decode(PostCharacters.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(character.results))
                    print("Load data \(self.counter)")
                    self.counter += 1
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
