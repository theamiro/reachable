//
//  ReachableModifier.swift
//
//  Created by Michael Amiro on 11/06/2024.
//  Copyright © 2024. All rights reserved.
//

import Network
import SwiftUI

@available(iOS 14.0, *)
struct ReachableModifier: ViewModifier {
    @ObservedObject var viewModel = ReachableViewModel()

    var onChange: (NetworkStatus) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear {
                self.onChange(self.viewModel.currentStatus)
            }
            .onChange(of: viewModel.currentStatus) { value in
                self.onChange(value)
            }
    }
}
