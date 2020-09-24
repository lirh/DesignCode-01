//
//  LoadingView.swift
//  DesignCode2
//
//  Created by 李瑞华 on 2020/9/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            LottieView(fileName: "128-around-the-world")
                .frame(width: 200, height: 200)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
