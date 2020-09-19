//
//  CourseStore.swift
//  DesignCode2
//
//  Created by 李瑞华 on 2020/9/18.
//

import SwiftUI
import Contentful

class CourseStore: ObservableObject {
    @Published var courseData: [Course] = []
    
    let client = Client(spaceId: "0ge8xzmnbp2c", accessToken: "03010b0d79abcb655ca3fda453f2f493b5472e0aaa53664bc7dea5ef4fce2676")
    
    init() {
        getArray()
    }

    func getArray(){
        let query = Query.where(contentTypeId: "course")
        
        client.fetchArray(of: Entry.self, matching: query) { result in
            print(result)
        }
    }
}

