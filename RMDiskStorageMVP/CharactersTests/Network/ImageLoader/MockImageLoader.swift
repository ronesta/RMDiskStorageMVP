//
//  MockImageLoader.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 05.04.2025.
//

import UIKit
@testable import RMDiskStorageMVP

final class MockImageLoader: ImageLoaderProtocol {
    var mockImageData: Data?
    var isImageSaved = false

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let data = mockImageData,
           let image = UIImage(data: data) {
            completion(image)
        } else {
            completion(nil)
        }
    }

    func simulateImageSave(with data: Data) {
        isImageSaved = true
        mockImageData = data
    }
}
