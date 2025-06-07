//
//  TestView.swift
//  Netflix
//
//  Created by Sameer Nikhil on 07/06/25.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        ZStack {
            Color.red // Make it red so we can see the boundaries
                .ignoresSafeArea(.all)
            
            VStack {
                Text("FULL SCREEN TEST")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text("If you see red edges, it's working")
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    TestView()
}
