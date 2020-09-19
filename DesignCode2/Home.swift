//
//  Home.swift
//  DeCode
//
//  Created by 李瑞华 on 2020/9/9.
//  Copyright © 2020 lirh. All rights reserved.
//

import SwiftUI

//将所有视图联接到一起的地方
struct Home: View {
    
    @State var showProfile = false
    
    @State var menuState = CGSize.zero
    
    @State var showContent = false
    
    var body: some View {
        ZStack {
            //简单的为ZStack制作一个全屏背景色
            //全屏幕着色 root背景 适用于所有子元素背景
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(.all)

            HomeView(showProfile: $showProfile,showContent: $showContent)
                //设置padding，防止安全区域
                .padding(.top,44)
                .background(
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color("background2"), Color.white]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 200)
                        Spacer()
                    }
                    .background(Color.white)
                )
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
                .offset(y:showProfile ?  -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(self.menuState.height / 10) - 10 : 0), axis: (x: 10, y: 0, z: 0))
                //缩放当前View
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)
            
            MenuView()
                //设置背景色，用以在出现菜单时，点击背景可以复位
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : screen.height)
                .offset(y:menuState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showProfile.toggle()
            }
                //拖动，改变位置，以及复位
                .gesture(
                    DragGesture()
                        .onChanged{value in
                            self.menuState = value.translation
                            if self.menuState.height > 50 {
                                self.showProfile = false
                            }
                    }
                    .onEnded{value in
                        self.menuState = CGSize.zero
                    }
            )
            
            if showContent {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                ContentView()
                    .transition(.move(edge: .bottom))
                    .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width:32,height: 32)
                            .foregroundColor(Color.white)
                            .background(Color.black)
                            .clipShape(Circle())
                            
                    }
                    Spacer()
                }
                .offset(x: -16, y: 16)
                    //if 显示新视图，开启动画
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                .onTapGesture {
                        self.showContent = false
                    
                }
            }
        }
        //如果背景色写在视图外，且使用全屏，注意 padding安全区域
        //        .padding(.top,44)
        //        .background(Color.blue)
        //        .edgesIgnoringSafeArea(.all)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct AvaterView: View {
    @Binding var showProfile: Bool
    var body: some View {
        Button(action: { self.showProfile.toggle() }) {
            Image("Avatar")
                .renderingMode(.original)
                .resizable()
                .frame(width:36,height: 36)
                .clipShape(Circle())
        }
    }
}

//检测屏幕 消除各种位置的硬编码
let screen = UIScreen.main.bounds
