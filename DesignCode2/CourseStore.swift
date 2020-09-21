//
//  CourseStore.swift
//  DesignCode2
//
//  Created by 李瑞华 on 2020/9/18.
//

import SwiftUI
import Contentful

let client = Client(spaceId: "0ge8xzmnbp2c", accessToken: "03010b0d79abcb655ca3fda453f2f493b5472e0aaa53664bc7dea5ef4fce2676")


func getArray(id: String,completion: @escaping([Entry]) -> ()){
    let query = Query.where(contentTypeId: id)
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
            case .success(let array):
                completion(array.items)
        case .failure(let error):
                print("Error \(error)!")
            }
    }
}

class CourseStore: ObservableObject {
    @Published var courses: [Course] = courseData
    
    init() {
        getArray(id: "course") { (items) in
            items.forEach { (item) in
//                print(item.fields["title"] as! String)
                self.courses.append(
                    Course(
                        title: item.fields["title"] as! String,
                        subtitle: item.fields["subtitle"] as! String,
                        image: #imageLiteral(resourceName: "Card1"),
                        logo:  #imageLiteral(resourceName: "Logo2"),
                        color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),
                        show: false
                    )
                )
            }
        }
    }
}

