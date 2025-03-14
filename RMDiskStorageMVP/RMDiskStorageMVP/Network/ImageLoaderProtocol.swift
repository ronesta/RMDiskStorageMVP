//
//  ImageLoaderProtocol.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 14.03.2025.
//

import Foundation
import UIKit.UIImage

protocol ImageLoaderProtocol {
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
}
