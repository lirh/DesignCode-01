//
//  DataStore.swift
//  DesignCode2
//
//  Created by 李瑞华 on 2020/9/18.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
   
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts(){
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
    
}

