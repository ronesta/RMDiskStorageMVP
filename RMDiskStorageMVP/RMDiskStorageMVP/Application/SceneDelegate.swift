//
//  SceneDelegate.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 09.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window  = UIWindow(windowScene: windowScene)

        let viewController = CharacterViewController()
        let tableViewDataSource = CharacterTableViewDataSource()
        let storageManager = DiskStorageManager()
        let networkManager = NetworkManager(storageManager: storageManager)

        let presenter = CharacterPresenter(
            view: viewController,
            networkManager: networkManager,
            storageManager: storageManager
        )

        viewController.presenter = presenter
        viewController.tableViewDataSource = tableViewDataSource
        tableViewDataSource.presenter = presenter

        let navigationControllet = UINavigationController(rootViewController: viewController)

        window.rootViewController = navigationControllet
        self.window = window
        window.makeKeyAndVisible()
    }
}
