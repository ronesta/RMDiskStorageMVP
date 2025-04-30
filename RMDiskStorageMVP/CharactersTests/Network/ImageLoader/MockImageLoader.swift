//
//  MockImageLoader.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 05.04.2025.
//

//import UIKit.UIImage
//@testable import RMDiskStorageMVP
//
//final class MockImageLoader: ImageLoaderProtocol {
//    var mockImage: UIImage?
//    var shouldReturnError: Bool = false
//
//    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
//        if shouldReturnError {
//            completion(nil)
//        } else {
//            completion(mockImage)
//        }
//    }
//}
//
//final class MockImageLoader: ImageLoaderProtocol {
//    private(set) var loadImageCallCount = 0
//    private(set) var loadImageArgsUrlString = [String]()
//    private(set) var loadImageCompletions = [(UIImage?) -> Void]()
//
//    var stubbedImageResult: UIImage?
//
//    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
//        loadImageCallCount += 1
//        loadImageArgsUrlString.append(urlString)
//        loadImageCompletions.append(completion)
//
//        if let image = stubbedImageResult {
//            completion(image)
//        } else {
//            completion(nil)
//        }
//    }
//}
