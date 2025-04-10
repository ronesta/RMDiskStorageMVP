//
//  CharacterTableViewDataSource.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 14.01.2025.
//

import Foundation
import UIKit

final class CharactersTableViewDataSource: NSObject, CharactersDataSourceProtocol {
    var characters = [Character]()
    private let imageLoader: ImageLoaderProtocol

    init(imageLoader: ImageLoaderProtocol) {
        self.imageLoader = imageLoader
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CharactersTableViewCell.id,
            for: indexPath
        ) as? CharactersTableViewCell else {
            return UITableViewCell()
        }

        let character = characters[indexPath.row]

        imageLoader.loadImage(from: character.image) { image in
            DispatchQueue.main.async {
                guard let currentCell = tableView.cellForRow(at: indexPath) as? CharactersTableViewCell else {
                    return
                }

                currentCell.configure(with: character, image: image)
            }
        }

        return cell
    }
}
