//
//  LoginVIew.swift
//  DesignCode2
//
//  Created by 李瑞华 on 2020/9/23.
//

import SwiftUI

struct LoginVIew: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            Color("background2")
                .edgesIgnoringSafeArea(.bottom)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            
            VStack {
                GeometryReader { geometry in
                    Text("Learn design & code. \nFrom scratch")
                        .font(.system(size: geometry.size.width / 10, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity,maxHeight: 100)
                .padding(.horizontal, 16)
                .offset(x: viewState.width / 15, y: viewState.height / 15)
                
                Text("80 hours of courses for SwiftUI, React and design tools.")
                    .font(.subheadline)
                    .frame(width: 250)
                    .offset(x: viewState.width / 20, y: viewState.height / 20)
                
                Spacer()
            }
            //多行文本居中对齐
            .multilineTextAlignment(.center)
            .padding(.top, 100)
            .frame(height: 477)
            .frame(maxWidth: .infinity)
            .background(
                //重叠透明图片，不同光照制作背景
                ZStack {
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x:-150, y: -200)
                        .rotationEffect(Angle(degrees: show ? 360 + 90 : 90))
                        .blendMode(.plusDarker)
                        //线性动画，持续120秒一个周期，一直重复
                        .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                        .onAppear {
                            self.show = true
                        }
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x:-200, y: -250)
                        .rotationEffect(Angle(degrees: show ? 360 : 0),anchor: .leading)
                        .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
                        .blendMode(.overlay)
                }
            )
            .background(
                Image(uiImage: #imageLiteral(resourceName: "Card3")).offset(x: viewState.width / 15, y: viewState.height / 15),
                alignment: .bottom
            )
            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            //缩放
            .scaleEffect(isDragging ? 0.9 : 1)
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            .rotation3DEffect(Angle(degrees: 5), axis: (x: viewState.width, y: viewState.height, z: 0))
            
            .gesture(
                DragGesture().onChanged({ value in
                    viewState = value.translation
                    isDragging = true
                }).onEnded({ value in
                    viewState = .zero
                    isDragging = false
                })
            )
        }
    }
}

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginVIew()
    }
}
