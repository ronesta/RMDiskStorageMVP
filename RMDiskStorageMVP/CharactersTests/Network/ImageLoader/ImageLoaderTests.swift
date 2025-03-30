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

    override func setUp() {
        super.setUp()
        mockStorageManager = MockStorageManager()
        imageLoader = ImageLoader(storageManager: mockStorageManager)
    }

    override func tearDown() {
        imageLoader = nil
        mockStorageManager = nil
        super.tearDown()
    }

    func testLoadImageFromStorage() {
        guard let imageData = UIImage(named: "testImage")?.pngData() else {
            return
        }

        let urlString = "https://example.com/image.png"

        mockStorageManager.saveImage(imageData, key: urlString)

        let expectation = expectation(description: "Completion called")

        imageLoader.loadImage(from: urlString) { image in
            XCTAssertNotNil(image)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testLoadImageFromNetwork() {
        let urlString = "https://example.com/image.png"

        let url = URL(string: urlString)!
        guard let imageData = UIImage(named: "testImage")?.pngData() else {
            return
        }

        MockURLProtocol.testURLs = [url: imageData]
        MockURLProtocol.response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        let expectation = self.expectation(description: "Image loaded from network")

        imageLoader.loadImage(from: urlString) { image in
            XCTAssertNotNil(image)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testLoadImageInvalidURL() {
        let urlString = "invalid_url"
        let expectation = XCTestExpectation(description: "Completion with nil for invalid URL")

        imageLoader.loadImage(from: urlString) { image in
            XCTAssertNil(image, "Image should be nil for invalid URL")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
