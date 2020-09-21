//
//  ContentView.swift
//  DeCode
//
//  Created by 李瑞华 on 2020/9/9.
//  Copyright © 2020 lirh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var show = false
    //跟随手势位置
    @State var viewState = CGSize.zero
    
    @State var showCard = false
    
    @State var bottomState = CGSize.zero
    
    @State var showFull = false
    
    var body: some View {
        ZStack {
            
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                //向上移动
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        //动画延时
                        .delay(0.1)
                    //默认速度的2倍
                    //                        .speed(2)
                    //重复次数
                    //                        .repeatCount(3)
                    //一直重复
                    //                      .repeatForever()
            )
            
            BackCardView()
                .frame(width: showCard ? 300 : 340, height: 220.0)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                //设置偏移量
                .offset(x: 0.0, y: show ? -400 : -40)
                //两个偏移，在第一个偏移的基础上，执行第二个偏移
                .offset(x:viewState.width, y:viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                //旋转角度
                .rotationEffect(.degrees(show ? 0 : 10))
                //取消上面的旋转，用于点击动画
                .rotationEffect(Angle(degrees: showCard ? -10 : 0))
                //3D旋转
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 10), axis: (x: 10.0, y: 0.0, z: 0.0))
                .blendMode(.hardLight)
                //设置动画及延时
                .animation(.easeOut(duration:0.3))
            
            BackCardView()
                .frame(width: 340.0, height: 220.0)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                //设置偏移量
                .offset(x: 0.0, y: show ? -200 : -20)
                .offset(y: showCard ? -140 : 0)
                .offset(x:viewState.width, y:viewState.height)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(Angle(degrees: show ? 0 : 5))
                .rotationEffect(Angle(degrees: showCard ? -5 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (x: 10.0, y: 0.0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeOut)
            
            CardView()
                .frame(width: showCard ? 375 : 340.0, height: 220.0)
                .background(Color.black)
                //                .cornerRadius(20)
                //制作平滑的圆角
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x:viewState.width, y:viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                //弹簧动画
                //                .animation(.spring())
                //response 回弹时间 dampingFraction 阻力
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    //true false 切换,控制动画是否启动或者复位
                    self.showCard.toggle()
            }
            .gesture(
                //拖砖，修改控件的offset来实现动画
                DragGesture()
                    .onChanged{ value in
                        self.viewState = value.translation
                        self.show = true
                }
                .onEnded{ value in
                    self.viewState = CGSize.zero
                    self.show = false
                }
            )
            
            BottomCardView(show: $showCard)
                .offset(x:0, y: showCard ? 360 : 1000)
                .offset(y:bottomState.height)
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            self.bottomState = value.translation
                            if self.showFull {
                                self.bottomState.height += -300
                            }
                            //当bottomCardView 达到最大高度，则不再变化，不能再被拖到更高处
                            if self.bottomState.height < -300 {
                                self.bottomState.height = -300
                            }
                    }
                    .onEnded{ value in
                        //制作下拉隐藏bottomCard并恢复其他控件原始状态
                        if self.bottomState.height > 50 {
                            self.showCard = false
                        }
                        if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull) {
                            self.bottomState.height = -300
                            self.showFull = true
                        } else {
                            self.bottomState = .zero
                            self.showFull = false
                        }
                        
                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}


struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                    Text("Certificates")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding()
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:300,height: 110,alignment: .top)
            
        }
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        
        
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    @Binding var show: Bool
    
    var body: some View {
        VStack() {
            Rectangle()
                .frame(width:40, height: 5)
                .cornerRadius(3)
                //不透明度
                .opacity(0.1)
            
            Text("This certificate is proof that Meng To has achieved the UI Design course with approval from a Design+Code instructor.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            HStack(spacing: 20.0) {
                RingView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 88, height: 88, percent: 78, show: $show)
                    //动画，延时， 当父容器设置动画是，动画会用到所有子容器，但是，当子容器中有动画设置时，子容器的动画优先级，高于父容器动画
                    .animation(Animation.easeOut.delay(0.3))
                VStack(alignment: .leading) {
                    Text("Swift UI")
                        .fontWeight(.bold)
                    Text("12 to 12 sections complate\n10 hours spent so far")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineLimit(4)
                }
                .padding(20)
                .background(Color("background3"))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                
            }
            Spacer()
        }
        .padding(.top,8)
        .padding(.horizontal,20)
        .frame(maxWidth:.infinity)
        .background(BlurView(style: .systemThinMaterial))
        .cornerRadius(30)
        .shadow(radius: 20)
    }
}
