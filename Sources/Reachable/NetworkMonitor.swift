//
//  NetworkMonitor.swift
//  Reachable
//
//  Created by Michael Amiro on 03/12/2024.
//

import Network

public class NetworkMonitor {
    private var monitor: NetworkPathMonitor = NWPathMonitor()
    public var networkUpdateHandler: ((NWPath.Status) -> Void)?

    public init() {
        start()
    }

    internal init(monitor: NetworkPathMonitor) {
        self.monitor = monitor
        start()
    }

    private func start() {
        monitor.updateHandler = { [weak self] path in
            self?.handleUpdate(path: path)
        }

        let queue = DispatchQueue(label: "ReachableNetworkMonitor")
        monitor.start(queue: queue)
    }

    private func handleUpdate(path: PathProtocol) {
        DispatchQueue.main.async {
            self.networkUpdateHandler?(path.status)
        }
    }
}
