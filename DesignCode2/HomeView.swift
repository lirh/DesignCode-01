//
//  HomeView.swift
//  DeCode
//
//  Created by 李瑞华 on 2020/9/10.
//  Copyright © 2020 lirh. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var showProfile: Bool
    @State var showUpdate = false
    @Binding var showContent: Bool
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack {
                HStack {
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))
                        .modifier(CustomFontModifier(size: 32))
                    Spacer()
                    
                    AvaterView(showProfile: $showProfile)
                    
                    //使用iOS13的内建模型视图导航，切换大另一个视图
                    Button(action: {self.showUpdate.toggle()}) {
                        Image(systemName: "bell")
//                            .renderingMode(.original)
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width:36,height: 36)
                            .background(Color("background3"))
                            .clipShape(Circle())
                            //双层阴影，制作圆形立体背景
                            .modifier(IconModifier())
                    }
                    .sheet(isPresented: $showUpdate){
                        UpdateList()
                    }
                    
                }
                .padding(.horizontal)
                .padding(.leading,14)
                .padding(.top,30)
                
                ScrollView(.horizontal,showsIndicators: false) {
                    WatchRingsView()
                        .padding(.horizontal,30)
                        .padding(.bottom,30)
                        .onTapGesture {
                            self.showContent = true
                    }
                }
                
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing:20) {
                        ForEach (sectionData) { section in
                            GeometryReader { geometry in
                                SectionsView(section: section)
                                    .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -20), axis: (x: 0.0, y: 10, z: 0))
                            }
                            .frame(width:275,height: 275)
                        }
                    }
                    .padding(30)
                    .padding(.bottom,30)
                }
                .offset(y: -30)
                
                HStack {
                    Text("Courses")
                        .font(.title).bold()
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                
                SectionsView(section: sectionData[2], width: screen.width - 60, height: 275)
                .offset(y: -60)
                
                
                
                Spacer()
            }
            .frame(width: screen.width)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false),showContent: .constant(false))
    }
}

struct SectionsView: View {
    var section:Section
    
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    var body: some View {
        VStack {
            HStack(alignment:.top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width:160,alignment: .leading)
                    .foregroundColor(Color.white)
                Spacer()
                Image(section.logo)
            }
            
            Text(section.text.uppercased())
                .frame(maxWidth:.infinity,alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:210)
            
        }
        .padding(.top,30)
        .padding(.horizontal,16)
        .frame(width:width,height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 30, x: 0, y: 30)
    }
}

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Prototype designs in SwiftUI", text: "18, Sections", logo: "Logo1", image: Image("Card1"), color: Color("card1")),
    Section(title: "Build a SwiftUI app", text: "18, Sections", logo: "Logo1", image: Image("Card2"), color: Color("card2")),
    Section(title: "Build a SwiftUI app", text: "18, Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card1")), color: Color("card3")),
    Section(title: "Build a SwiftUI app", text: "18, Sections", logo: "Logo2", image: Image("Card4"), color: Color("card4")),
    Section(title: "Build a SwiftUI app", text: "18, Sections", logo: "Logo2", image: Image("Card5"), color: Color("card5")),
    Section(title: "Build a SwiftUI app", text: "18, Sections", logo: "Logo2", image: Image("Card6"), color: Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
]

struct WatchRingsView: View {
    var body: some View {
        HStack (spacing:30){
            HStack {
                RingView(color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), width: 44, height: 44, percent: 68, show: .constant(true))
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("剩余6分钟")
                        .bold()
                        .modifier(FontModifier(style: .subheadline))
                    Text("今天看了10分钟")
                        .modifier(FontModifier(style: .caption))
                }
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack {
                RingView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), width: 32, height: 32, percent: 54, show: .constant(true))
                
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack {
                RingView(color1: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), color2: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), width: 32, height: 32, percent: 32, show: .constant(true))
                
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
