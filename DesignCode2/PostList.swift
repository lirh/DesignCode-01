//
//  PostList.swift
//  DesignCode2
//
//  Created by 李瑞华 on 2020/9/17.
//

import SwiftUI

struct PostList: View {
    
    @ObservedObject var store = DataStore()
    
    var body: some View {
        
        List(store.posts) { post in
            VStack(alignment: .leading, spacing: 8.0) {
                Text(post.title)
                    .font(.system(.title, design: .serif))
                    .bold()
                Text(post.body)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
        }
        
    }
}


struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
