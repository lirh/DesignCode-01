//
//  TabBar.swift
//  DeCode
//
//  Created by 李瑞华 on 2020/9/14.
//  Copyright © 2020 lirh. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home()
                .tabItem{
                    Image(systemName: "play.circle.fill")
                    Text("Home")
                }
            ContentView()
                .tabItem{
                    Image(systemName: "rectangle.stack.fill")
                    Text("Certificates")
                }
        }
//        .edgesIgnoringSafeArea(.all)
        
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBar().previewDevice("iPhone 11 Pro")
//            TabBar().previewDevice("iPhone 8")
        }
    }
}
