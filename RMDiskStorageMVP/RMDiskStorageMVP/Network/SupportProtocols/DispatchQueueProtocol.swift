//
//  DispatchQueueProtocol.swift
//  RMDiskStorageMVP
//
//  Created by Ибрагим Габибли on 27.04.2025.
//

import Foundation

protocol DispatchQueueProtocol {
    func async(_ block: @escaping () -> Void)
}

extension DispatchQueue: DispatchQueueProtocol {
    func async(_ block: @escaping () -> Void) {
        async(execute: block)
    }
}

//struct MainDispatchQueue: DispatchQueueProtocol {
//    func async(_ block: @escaping () -> Void) {
//        DispatchQueue.main.async(execute: block)
//    }
//}
