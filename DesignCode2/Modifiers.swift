//
//  Modifiers.swift
//  DeCode
//
//  Created by 李瑞华 on 2020/9/15.
//  Copyright © 2020 lirh. All rights reserved.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}

struct IconModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
    }
}

struct FontModifier: ViewModifier {
    var style:Font.TextStyle = .body
    
    func body(content: Content) -> some View {
        content
            .font(.system(style, design: .default))
    }
}


struct CustomFontModifier: ViewModifier {
    var size: CGFloat = 28
    
    func body(content: Content) -> some View {
        content.font(.custom("WorkSans-Bold", size: size))
    }
}
