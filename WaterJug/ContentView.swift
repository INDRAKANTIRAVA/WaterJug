//
//  ContentView.swift
//  WaterJug
//
//  Created by INDRA KANTI RAVA on 10/04/25.
//
import SwiftUI

struct ContentView: View {
    @State private var jugACapacity = 4
    @State private var jugBCapacity = 3
    @State private var goal = 2
    @State private var showGame = false
    @State private var blink = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 40.0) {
                // Title
                Text("🎯 Water Jug Puzzle 🎯")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .shadow(radius: 2)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)

                Spacer()
                // Jugs + Goal Block in horizontal row
                VStack(spacing: 40) {
    
                    HStack(spacing: 30){
                        CustomStepperBlock(title: "🌊 Jug A Capacity", value: $jugACapacity, color: .cyan)
                        CustomStepperBlock(title: "🌊 Jug B Capacity", value: $jugBCapacity, color: .orange)
                    }
                    CustomStepperBlock(title: "🎯 Goal Amount", value: $goal, color: .red)
                }
                .padding(.horizontal)
                Spacer()
                // Start Button
                Button(action: {
                    withAnimation {
                        showGame = true
                    }
                }) {
                    Text("🚀 Start Game")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .fill(LinearGradient(colors: [.blue, .mint], startPoint: .leading, endPoint: .trailing))
                                .shadow(color: .cyan.opacity(0.6), radius: 8, x: 0, y: 5)
                        )
                        .opacity(blink ? 0.4 : 1.0)
                        .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: blink)
                        .onAppear { blink = true }
                        .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
            .background(
                LinearGradient(colors: [.purple, .indigo, .blue], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            )
            .navigationDestination(isPresented: $showGame) {
                JugGameView(maxA: jugACapacity, maxB: jugBCapacity, goal: goal)
            }
        }
    }
}

// MARK: - Custom Equal Block Stepper View
struct CustomStepperBlock: View {
    var title: String
    @Binding var value: Int
    var color: Color

    var body: some View {
        VStack(spacing: 12) {
            Text("\(title): \(value) L")
                .font(.headline)
                .foregroundColor(color)
                .multilineTextAlignment(.center)

            Stepper("", value: $value, in: 1...10)
                .labelsHidden()
                .padding(.horizontal)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity) // Equal width for all
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(color.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

#Preview {
    ContentView()
}
