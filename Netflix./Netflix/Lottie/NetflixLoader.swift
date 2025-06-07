//
//  NetflixLoader.swift
//  Netflix.
//
//  Created by Sameer Nikhil on 09/06/25.
//

import SwiftUI

struct NetflixLoader: View {
    
    @State private var isSpinning: Bool = false
    
    var body: some View {
        Circle()
            .stroke(.linearGradient(colors: [
                .red, // Netflix red color
                .red,
                .red,
                .red,
                .red.opacity(0.7),
                .red.opacity(0.4),
                .red.opacity(0.1),
                .clear
            ], startPoint: .top, endPoint: .bottom), lineWidth: 6) // Fixed: .top instead of top
            .rotationEffect(.degrees(isSpinning ? 360 : 0)) // Fixed: Added missing opening parenthesis
            .onAppear {
                withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                    self.isSpinning = true
                }
            }
    }
}

#Preview {
    NetflixLoader()
        .frame(width: 100, height: 100)
        .preferredColorScheme(.dark)
}
