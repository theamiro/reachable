//
//  Reachable.swift
//
//  Created by Michael Amiro on 11/06/2024.
//  Copyright © 2024. All rights reserved.
//

import Foundation
import Network
import RxSwift

public class Reachable {
    var monitor: NetworkPathMonitor
    var queue: DispatchQueue
    var subject = BehaviorSubject<NetworkStatus>(value: .requiresConnection)

    public var status: Observable<NetworkStatus> {
        subject.asObservable()
    }

    public init(monitor: NetworkPathMonitor = NWPathMonitor(), qos: DispatchQoS = .background) {
        self.monitor = monitor
        self.queue = DispatchQueue.init(label: "ReachableNetworkMonitor", qos: qos)
        self.monitor.updateHandler = { [weak self] path in
            switch path.status {
            case .requiresConnection:
                self?.subject.onNext(.requiresConnection)
            case .satisfied:
                self?.subject.onNext(.satisfied)
            case .unsatisfied:
                self?.subject.onNext(.unsatisfied)
            default:
                self?.subject.onNext(.unsatisfied)
            }
        }
        self.start()
    }

    public func start() {
        self.monitor.start(queue: queue)
        print("Reachable start monitoring on \(queue.label)")
    }

    public func cancel() {
        self.monitor.cancel()
        print("Reachable cancel monitoring on \(queue.label)")
    }

    deinit {
        self.cancel()
    }
}
