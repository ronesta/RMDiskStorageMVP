//
//  CharactersViewControllerSnapshotTests.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 30.03.2025.
//

import XCTest
import SnapshotTesting
@testable import RMDiskStorageMVP

final class CharactersViewControllerSnapshotTests: XCTestCase {
    func testCharactersViewControllerAppearance() {
        let presenter = MockPresenter()
        let dataSource = MockDataSource()

        let viewController = CharactersViewController(presenter: presenter, tableViewDataSource: dataSource)
        let navigationController = UINavigationController(rootViewController: viewController)

        let characters = [
            Character(name: "John Doe",
                      status: "Alive",
                      species: "Human",
                      gender: "Male",
                      location: Location(name: "Earth"),
                      image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
                     ),
            Character(name: "Morty Smith",
                      status: "Alive",
                      species: "Human",
                      gender: "Male",
                      location: Location(name: "Earth (C-137)"),
                      image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
                     )
        ]

        viewController.loadViewIfNeeded()
        viewController.updateCharacters(characters)

        assertSnapshot(of: navigationController, as: .image)
    }
}
