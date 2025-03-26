//
//  MockURLProtocol.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 26.03.2025.
//

import Foundation

final class MockURLProtocol: URLProtocol {
    static var testURLs = [URL?: Data]()
    static var response: URLResponse?

    override func startLoading() {
        if let url = request.url, let data = MockURLProtocol.testURLs[url] {
            client?.urlProtocol(self, didReceive: MockURLProtocol.response!, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
}
