//
//  JugGameView.swift
//  WaterJug
//
//  Created by INDRA KANTI RAVA on 10/04/25.
//
import SwiftUI

struct JugGameView: View {
    let maxA: Int
    let maxB: Int
    let goal: Int
    @Environment(\.dismiss) private var dismiss
    @State private var jugA = 0
    @State private var jugB = 0
    @State private var message = "💧 Choose a Rule 💧"
    @State private var goalReached = false
    @State private var blink = false

    var body: some View {
        VStack(spacing: 15) {
            
            // ✅ Centered Header
            HStack {
                Button(action: {
                    dismiss() // Go back to ContentView
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.black.opacity(0.3))
                        .clipShape(Circle())
                }

                Spacer()

                Text("🎯 Water Jug AI Game 🎯")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .shadow(radius: 2)
                    .multilineTextAlignment(.center)

                Spacer()
                // Add an invisible Spacer for symmetry
                Color.clear.frame(width: 44)
            }
            .padding(.bottom, 20)
            // 🧊 Jug displays
            HStack {
                JugDisplay(jugValue: jugA, jugMax: maxA, label: "Jug A", color: .blue)
                    .transition(.slide)
                JugDisplay(jugValue: jugB, jugMax: maxB, label: "Jug B", color: .green)
                    .transition(.slide)
            }
            .padding(.horizontal)

            // 🧩 Rule buttons
            VStack(spacing: 8) {
                ForEach(0..<4) { index in
                    HStack(spacing: 12) {
                        let start = index * 2 + 1
                        JugButton(title: ruleTitle(start), color: buttonColor(start)) {
                            applyRule(start)
                        }
                        JugButton(title: ruleTitle(start + 1), color: buttonColor(start + 1)) {
                            applyRule(start + 1)
                        }
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(colors: [.yellow.opacity(0.3), .pink.opacity(0.3)], startPoint: .top, endPoint: .bottom))
            )

            // ✅ Goal / Message moved here
            if goalReached {
                Text("🎉 Suceesfully Goal Reached \(goal)L")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.green)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(12)
                    .opacity(blink ? 0.2 : 1)
                    .animation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: blink)
                    .onAppear { blink = true }
            } else {
                Text(message)
                    .font(.title3)
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(12)
            }

            // ✅ Smaller styled reset button
            Button(action: resetGame) {
                Text("🔄 Restart")
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .frame(minWidth: 150)
            .padding(.top, 8)

            Spacer()
        }
        .padding()
        .background(
            LinearGradient(colors: [.purple, .indigo, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
    }

    private func ruleTitle(_ rule: Int) -> String {
        switch rule {
        case 1: return "💧 Fill Jug A"
        case 2: return "💧 Fill Jug B"
        case 3: return "🧹 Empty Jug A"
        case 4: return "🧹 Empty Jug B"
        case 5: return "➡️ A ➝ B All"
        case 6: return "⬅️ B ➝ A All"
        case 7: return "↪️ A ➝ B Till Full"
        case 8: return "↩️ B ➝ A Till Full"
        default: return ""
        }
    }

    private func buttonColor(_ rule: Int) -> Color {
        switch rule {
        case 1, 3: return .blue
        case 2, 4: return .green
        case 5: return .purple
        case 6: return .orange
        case 7: return .mint
        case 8: return .pink
        default: return .gray
        }
    }

    private func applyRule(_ rule: Int) {
        var newA = jugA
        var newB = jugB

        switch rule {
        case 1: if jugA < maxA { newA = maxA } else { message = "❌ Can't Fill Jug A"; return }
        case 2: if jugB < maxB { newB = maxB } else { message = "❌ Can't Fill Jug B"; return }
        case 3: if jugA > 0 { newA = 0 } else { message = "❌ Jug A is already empty"; return }
        case 4: if jugB > 0 { newB = 0 } else { message = "❌ Jug B is already empty"; return }
        case 5:
            if jugA > 0 && jugA + jugB <= maxB {
                newB = jugA + jugB
                newA = 0
            } else { message = "❌ Can't transfer all A to B"; return }
        case 6:
            if jugB > 0 && jugA + jugB <= maxA {
                newA = jugA + jugB
                newB = 0
            } else { message = "❌ Can't transfer all B to A"; return }
        case 7:
            if jugA > 0 && jugA + jugB >= maxB {
                let transfer = maxB - jugB
                newA -= transfer
                newB = maxB
            } else { message = "❌ Can't pour A to B until full"; return }
        case 8:
            if jugB > 0 && jugA + jugB >= maxA {
                let transfer = maxA - jugA
                newB -= transfer
                newA = maxA
            } else { message = "❌ Can't pour B to A until full"; return }
        default: return
        }

        jugA = newA
        jugB = newB
        message = "✅ Rule \(rule) Applied!"
        goalReached = (jugA == goal && jugB == 0)
    }

    private func resetGame() {
        jugA = 0
        jugB = 0
        message = "💧 Choose a Rule 💧"
        goalReached = false
        blink = false
    }
}

#Preview {
    NavigationStack {
        JugGameView(maxA: 4, maxB: 3, goal: 2)
    }
}
