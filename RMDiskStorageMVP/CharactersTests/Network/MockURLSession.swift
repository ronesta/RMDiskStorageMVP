//
//  MockURLSession.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 28.04.2025.
//

import Foundation
@testable import RMDiskStorageMVP

final class MockURLSession: URLSessionProtocol {
    private(set) var dataTaskCallCount = 0
    var data: Data?
    var error: Error?

    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        dataTaskCallCount += 1
        completionHandler(data, nil, error)
        return MockURLSessionDataTask()
    }
}
