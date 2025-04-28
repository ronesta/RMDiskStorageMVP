//
//  ImageLoaderTests.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 26.03.2025.
//

import XCTest
@testable import RMDiskStorageMVP

final class ImageLoaderTests: XCTestCase {
    private var imageLoader: ImageLoader!
    private var mockStorageManager: MockStorageManager!
    private var mockURLSession: MockURLSession!
    private var mockDispatchQueue: MockDispatchQueue!

    override func setUp() {
        super.setUp()
        mockStorageManager = MockStorageManager()
        mockURLSession = MockURLSession()
        mockDispatchQueue = MockDispatchQueue()
        imageLoader = ImageLoader(
            storageManager: mockStorageManager,
            urlSession: mockURLSession,
            dispatchQueue: mockDispatchQueue
        )
    }

    override func tearDown() {
        imageLoader = nil
        mockStorageManager = nil
        mockURLSession = nil
        mockDispatchQueue = nil
        super.tearDown()
    }

    func test_loadImage_ReturnsImageFromStorage() {
        let urlString = "https://example.com/test.png"
        let testImage = UIImage(systemName: "star")!
        let imageData = testImage.pngData()!
        let key = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? urlString

        mockStorageManager.saveImage(imageData, key: key)

        imageLoader.loadImage(from: urlString) { image in
            XCTAssertNotNil(image)
        }
    }

    func test_loadImage_LoadsImageFromNetworkAndCachesIt() {
        let urlString = "https://example.com/test.png"
        let testImage = UIImage(systemName: "star")!
        let imageData = testImage.pngData()!
        let key = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? urlString

        mockURLSession.data = imageData

        imageLoader.loadImage(from: urlString) { image in
            XCTAssertNotNil(image)
            XCTAssertEqual(self.mockStorageManager.images[key], imageData)
        }
    }

    func test_loadImage_invalidURL_ReturnsNil() {
        let urlString = "not-a url"

        imageLoader.loadImage(from: urlString) { image in
            XCTAssertNil(image)
        }
    }

    func test_loadImage_NetworkError_ReturnsNil() {
        let urlString = "http://example.com/test3.png"

        mockURLSession.error = NSError(domain: "test", code: 1)

        imageLoader.loadImage(from: urlString) { image in
            XCTAssertNil(image)
        }
    }

    func test_loadImage_invalidData_ReturnsNil() {
        let urlString = "http://example.com/test4.png"

        mockURLSession.data = Data()

        imageLoader.loadImage(from: urlString) { image in
            XCTAssertNil(image)
        }
    }
}
