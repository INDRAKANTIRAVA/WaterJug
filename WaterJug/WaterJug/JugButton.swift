//
//  JugButton.swift
//  WaterJug
//
//  Created by INDRA KANTI RAVA on 10/04/25.
//

import SwiftUI

struct JugButton: View {
    var title: String
    var color: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption2) // Smaller font
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .frame(width: 130, height: 45) // 🔽 Less height
                .background(color.opacity(0.9))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
