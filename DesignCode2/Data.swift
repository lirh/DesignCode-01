//
//  Data.swift
//  DesignCode2
//
//  Created by 李瑞华 on 2020/9/17.
//

import SwiftUI

struct Post: Codable, Identifiable{
    var id: Int
    var title: String
    var body: String
}

class Api {
    func getPosts(completion: @escaping ([Post]) -> ()) {
        //注意⚠️ iOS请求，默认只允许 https
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
       
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            let posts = try! JSONDecoder().decode([Post].self, from: data)
            
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        .resume()
    }
}
