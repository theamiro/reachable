//
//  MockNWPathMonitor.swift
//  Reachable
//
//  Created by Michael Amiro on 29/11/2024.
//

import Foundation
import Reachable
import Network

final class MockNWPathMonitor: NetworkPathMonitor {
    var queuePassed: DispatchQueue?
    var startCalledCount = 0
    var cancelCalledCount = 0
    var updateHandler: ((PathProtocol) -> Void)?

    func start(queue: DispatchQueue) {
        startCalledCount += 1
        queuePassed = queue
    }

    func cancel() {
        cancelCalledCount += 1
    }
}
