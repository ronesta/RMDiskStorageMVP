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

    override func setUp() {
        super.setUp()
        imageLoader = MockImageLoader()
    }

    override func tearDown() {
        imageLoader = nil
        super.tearDown()
    }

    func testLoadImageSuccess() {
        let testImage = UIImage(systemName: "person.fill")!
        imageLoader.mockImage = testImage
        imageLoader.shouldReturnError = false

        imageLoader.loadImage(from: "test_url") { image in
            XCTAssertNotNil(image)
            XCTAssertEqual(image, testImage)
        }
    }

    func testLoadImageFailure() {
        imageLoader.shouldReturnError = true

        imageLoader.loadImage(from: "test_url") { image in
            XCTAssertNil(image)
        }
    }

    func testLoadImageInvalidURL() {
        imageLoader.loadImage(from: "") { image in
            XCTAssertNil(image)
        }
    }
}
