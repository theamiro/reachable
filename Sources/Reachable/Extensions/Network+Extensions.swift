//
//  Network+Extensions.swift
//  Reachable
//
//  Created by Michael Amiro on 03/12/2024.
//

import Foundation
import Network

public protocol PathProtocol {
    var status: NWPath.Status { get }
}

extension NWPath: PathProtocol {}

struct MockPathProtocol: PathProtocol {
    var status: NWPath.Status
}

public protocol NetworkPathMonitor {
    var updateHandler: ((PathProtocol) -> Void)? { get set }
    func start(queue: DispatchQueue)
    func cancel()
}

extension NWPathMonitor: NetworkPathMonitor {
    public var updateHandler: ((PathProtocol) -> Void)? {
        get {
            let handler = pathUpdateHandler as? ((PathProtocol) -> Void)
            assert(handler != nil, "Casting is not expected to fail")
            return handler
        }
        set { pathUpdateHandler = newValue }
    }
}


