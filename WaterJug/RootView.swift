//
//  RootView.swift
//  WaterJug
//
//  Created by INDRA KANTI RAVA on 10/04/25.
//

import SwiftUI

struct RootView: View {
    @State private var showMainView = false

    var body: some View {
        Group {
            if showMainView {
                ContentView()
            } else {
                StartView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            showMainView = true
                        }
                    }
            }
        }
    }
}

