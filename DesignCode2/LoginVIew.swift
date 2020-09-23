//
//  LoginVIew.swift
//  DesignCode2
//
//  Created by 李瑞华 on 2020/9/23.
//

import SwiftUI

struct LoginVIew: View {
    var body: some View {
        GeometryReader { geometry in
            Text("Learn design & code. \nFrom scratch")
                .font(.system(size: geometry.size.width / 10, weight: .bold))
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
}

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginVIew()
    }
}
