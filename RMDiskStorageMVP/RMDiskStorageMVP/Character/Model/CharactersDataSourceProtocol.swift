//
//  CharacterDataSourceProtocol.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 14.01.2025.
//

import Foundation
import UIKit

protocol CharactersDataSourceProtocol: UITableViewDataSource {
    var characters: [Character] { get set }
}
