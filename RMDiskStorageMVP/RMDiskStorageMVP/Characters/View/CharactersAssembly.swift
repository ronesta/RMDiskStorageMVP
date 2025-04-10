//
//  CharacterAssembly.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 27.02.2025.
//

import Foundation
import UIKit

final class CharactersAssembly {
    func createModule() -> UIViewController {
        let storageManager = DiskStorageManager()
        let charactersService = CharactersService()
        let imageLoader = ImageLoader(storageManager: storageManager)

        let presenter = CharactersPresenter(charactersService: charactersService,
                                            storageManager: storageManager
        )

        let tableViewDataSource = CharactersTableViewDataSource(imageLoader: imageLoader)

        let viewController = CharactersViewController(
            presenter: presenter,
            tableViewDataSource: tableViewDataSource
        )

        presenter.view = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
