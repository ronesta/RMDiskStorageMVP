//
//  MockDataSource.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

import UIKit
@testable import RMDiskStorageMVP

final class MockDataSource: NSObject, CharactersDataSourceProtocol {
    var characters = [Character]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CharactersTableViewCell.id,
            for: indexPath
        ) as? CharactersTableViewCell else {
            return UITableViewCell()
        }

        let character = characters[indexPath.row]

        cell.configure(with: character, image: nil)

        return cell
    }
}
