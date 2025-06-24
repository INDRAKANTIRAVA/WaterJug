//
//  StartView.swift
//  WaterJug
//
//  Created by INDRA KANTI RAVA on 10/04/25.
//

import SwiftUI

struct StartView: View {
    @State private var navigateToGame = false
    @State private var animate = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                LinearGradient(colors: [.blue.opacity(0.6), .purple.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack(spacing: 40) {
                    Spacer()

                    // Title with animation
                    Text("💧 Water Jug Puzzle")
                        .font(.system(size: 36, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .scaleEffect(animate ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animate)

                    // Jug image or emoji
                    Text("🥤\n🥛\n🫗")
                        .font(.system(size: 100))
                        .padding(.top, 20)

                    Spacer()

                    // Start Button
                   
                    Spacer()
                }
                .padding()
            }
            .onAppear {
                animate = true
            }
            .navigationDestination(isPresented: $navigateToGame) {
                ContentView()
            }
        }
    }
}

#Preview {
    StartView()
}
