//
//  JugDisplay.swift
//  WaterJug
//
//  Created by INDRA KANTI RAVA on 10/04/25.
//
import SwiftUI

struct JugDisplay: View {
    let jugValue: Int
    let jugMax: Int
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .bottom) {
                // Jug outline
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(color, lineWidth: 4)
                    .frame(width: 70, height: 200)

                // Water level
                RoundedRectangle(cornerRadius: 20)
                    .fill(color.opacity(0.5))
                    .frame(width: 70, height: CGFloat(jugValue) / CGFloat(max(jugMax, 1)) * 200)
                    .animation(.easeInOut, value: jugValue)
            }

            // Jug label + value
            Text("\(label): \(jugValue)L")
                .font(.caption)
                .foregroundColor(.black)
        }
    }
}
