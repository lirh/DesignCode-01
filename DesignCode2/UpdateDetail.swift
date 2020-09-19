//
//  UpdateDetail.swift
//  DeCode
//
//  Created by 李瑞华 on 2020/9/10.
//  Copyright © 2020 lirh. All rights reserved.
//

import SwiftUI

struct UpdateDetail: View {
    
    var update:Update = updateData[0]
    
    var body: some View {
        //放到可滚动的容器中，当标题被隐藏时，可自动到导航栏
        List {
            VStack {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth:.infinity)
                Text(update.text)
                    .frame(maxWidth:.infinity,alignment: .leading)
            }
            .padding(.top,4)
            .navigationBarTitle(update.title)
        
        }
            //借用list的样式
            .listStyle(DefaultListStyle())
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
