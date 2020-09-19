//
//  UpdateList.swift
//  DeCode
//
//  Created by 李瑞华 on 2020/9/10.
//  Copyright © 2020 lirh. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    
    @ObservedObject var store = UpdateStore()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.updates) { update in
                    NavigationLink(destination: UpdateDetail(update: update)) {
                        HStack {
                            Image(update.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:80,height: 80)
                                .background(Color.black)
                                .cornerRadius(10)
                                .padding(.trailing,4)
                            
                            VStack(alignment: .leading,spacing: 8) {
                                Text(update.title)
                                    .font(.system(size: 20, weight: .bold))
                                Text(update.text)
                                    .lineLimit(2)
                                    .font(.subheadline)
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                Text(update.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical,8)
                        
                    }
                }
                    //List 列表开启删除操作
                    .onDelete{index in
                        self.store.updates.remove(at: index.first!)
                }
                    //List 列表开启排序操作
                    .onMove{(source: IndexSet, destination: Int) in
                        self.store.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
                
                //导航标题，也是跳转后页面的返回按钮标题
                .navigationBarTitle("Update")
                .navigationBarItems(
                    leading: Button(action: {
                        self.store.addUpdate(update: Update(image: "Card1", title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "JAN 1"))
                    }) {
                        Text("Add Update")
                    },
                    trailing: EditButton()
            )
        }
        
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}

