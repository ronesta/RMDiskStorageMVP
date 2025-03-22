//
//  MockPresenter.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 21.03.2025.
//

@testable import RMDiskStorageMVP

final class MockPresenter: CharactersPresenterProtocol {
    var viewDidLoadCalled = false

    func viewDidLoad() {
        viewDidLoadCalled = true
    }
}
