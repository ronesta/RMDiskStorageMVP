//
//  MockURLSession.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 28.04.2025.
//

import Foundation
@testable import RMDiskStorageMVP

final class MockURLSession: URLSessionProtocol {
    var data: Data?
    var error: Error?

    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        completionHandler(data, nil, error)
        return MockURLSessionDataTask()
    }
}
