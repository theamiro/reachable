//
//  View+Extensions.swift
//
//  Created by Michael Amiro on 11/06/2024.
//  Copyright © 2024. All rights reserved.
//

import Foundation
import Network
import SwiftUI

@available(iOS 14.0, *)
public extension View {
    func onReachabilityChange(perform: @escaping (NetworkStatus) -> Void) -> some View {
        self.modifier(ReachableModifier(onChange: perform))
    }
}
