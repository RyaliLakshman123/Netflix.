//
//  RectAnchorKey.swift
//  Netflix.
//
//  Created by Sameer Nikhil on 09/06/25.
//

import SwiftUI

// RectAnchorKey for preference tracking
struct RectAnchorKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [String: Anchor<CGRect>], nextValue: () -> [String: Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}

struct RectKey: PreferenceKey {
    static var defaultValue: CGRect? = .zero
    
    static func reduce(value: inout CGRect?, nextValue: () -> CGRect?) {
        value = nextValue()
    }
}
