//
//  LoginVIew.swift
//  DesignCode2
//
//  Created by 李瑞华 on 2020/9/23.
//

import SwiftUI

struct LoginVIew: View {
   
    @State var email: String = ""
    @State var password: String = ""
    //检测是否是文本输入状态，用来将视图向上偏移，防止遮挡
    @State var isFocused: Bool = false
    
    @State var showAlert: Bool = false
    @State var alertMessage = "Some went wrong."
    
    @State var isLoading: Bool = false
    
//    MARK: - 隐藏键盘方法
    func hideKeyborad() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack(alignment: .top) {
               
                Color("background2")
                    .edgesIgnoringSafeArea(.bottom)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                
                CoverView()
                
                VStack {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        TextField("Your email".uppercased(), text: $email)
                            .keyboardType(.emailAddress)
                            .font(.subheadline)
    //                        .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                isFocused = true
                            })
                    }
                    
                    //分割线
                    Divider().padding(.leading, 80)
                    
                    HStack {
                        Image(systemName: "lock.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        SecureField("Password".uppercased(), text: $password)
                            .keyboardType(.emailAddress)
                            .font(.subheadline)
    //                        .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                isFocused = true
                            })
                    }
                }
                .frame(height: 136)
                .frame(maxWidth: .infinity)
                .background(BlurView(style: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.15), radius: 20, x: 5, y: 5)
                .padding(.horizontal)
                .offset(y: 460)
                
                HStack {
                    Text("forgot password?")
                    Spacer()
                    Button(action: {
                        
                        hideKeyborad()
                        isFocused = false
                        isLoading = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoading = false
                            showAlert = true
                        }
                    }) {
                        Text("Log in")
                    }
                    .padding(12)
                    .padding(.horizontal, 30)
                    .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding()
                .padding(.bottom,30)
               
            }
            .offset(y: isFocused ? -100 : 0)
            .animation(isFocused ? .easeOut : nil)
            .onTapGesture(count: 1, perform: {
                isFocused = false
                hideKeyborad()
            })
            
            if isLoading {
                LoadingView()
            }
        }
    }
}

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginVIew()
    }
}

//MARK: - 头部图片动画
struct CoverView: View {
    
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    
    var body: some View {
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
                    .rotationEffect(Angle(degrees: show ? 360 + 90 : 90))                    //线性动画，持续120秒一个周期，一直重复
                    .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
//                    .animation(nil)
                    .blendMode(.plusDarker)
                    .onAppear {
                        self.show = true
                    }
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x:-200, y: -250)
                    .rotationEffect(Angle(degrees: show ? 360 : 0),anchor: .leading)
                    .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
//                    .animation(nil)
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
