//
//  MockDataSource.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

import UIKit
@testable import RMDiskStorageMVP

final class MockDataSource: NSObject, CharactersDataSourceProtocol {

    // Обязательное свойство протокола
    var characters = [Character]()

    // Реализация метода UITableViewDataSource: количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    // Реализация метода UITableViewDataSource: создание/заполнение ячеек
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Вам необходимо заменить "UITableViewCell" на вашу кастомную ячейку, если она у вас есть (например, CharacterTableViewCell)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "mockCell")
        let character = characters[indexPath.row]

        // Настройка вашей ячейки (здесь упрощённая версия)
        cell.textLabel?.text = character.name
        cell.detailTextLabel?.text = character.status
        return cell
    }
}
