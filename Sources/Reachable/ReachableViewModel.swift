//
//  ReachableViewModel.swift
//
//  Created by Michael Amiro on 11/06/2024.
//  Copyright © 2024. All rights reserved.
//

import Foundation
import Network
import RxSwift
import SwiftUI

@available(iOS 14.0, *)
public class ReachableViewModel: ObservableObject {
    @Published var currentStatus: NetworkStatus = .requiresConnection
    let reachabilityService = Reachable()
    let disposeBag = DisposeBag()

    public init() {
        reachabilityService
            .status
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] status in
                self?.currentStatus = status
            })
            .disposed(by: disposeBag)
    }
}
