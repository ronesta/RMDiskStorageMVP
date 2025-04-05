//
//  ImageLoaderTests.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 26.03.2025.
//

import XCTest
@testable import RMDiskStorageMVP

final class ImageLoaderTests: XCTestCase {
    private var imageLoader: MockImageLoader!
    private var storageManager: MockStorageManager!

    override func setUp() {
        super.setUp()
        storageManager = MockStorageManager()
        imageLoader = MockImageLoader()
    }

    override func tearDown() {
        storageManager = nil
        imageLoader = nil
        super.tearDown()
    }

    func testLoadImageFromStorage() {
        guard let imageData = UIImage(named: "testImage")?.pngData() else {
            return
        }

        let urlString = "https://example.com/image.png"

        storageManager.saveImage(imageData, key: urlString)

        imageLoader.loadImage(from: urlString) { image in
            XCTAssertNotNil(image)
        }
    }

    func testLoadImageFromNetwork() {
        let urlString = "https://example.com/image.png"

        guard let imageData = UIImage(named: "testImage")?.pngData() else {
            return
        }

        imageLoader.simulateImageSave(with: imageData)

        imageLoader.loadImage(from: urlString) { image in
            XCTAssertNotNil(image)
        }
    }

//    func testLoadImageFromNetwork() {
//        let urlString = "https://example.com/image.png"
//
//        let url = URL(string: urlString)!
//        guard let imageData = UIImage(named: "testImage")?.pngData() else {
//            return
//        }
//
//        MockURLProtocol.testURLs = [url: imageData]
//        MockURLProtocol.response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
//
//        imageLoader.loadImage(from: urlString) { image in
//            XCTAssertNotNil(image)
//        }
//    }

    func testLoadImageInvalidURL() {
        let urlString = "invalid_url"

        imageLoader.loadImage(from: urlString) { image in
            XCTAssertNil(image, "Image should be nil for invalid URL")
        }
    }
}
