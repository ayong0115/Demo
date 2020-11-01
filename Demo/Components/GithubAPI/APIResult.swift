//
//  APIResultModle.swift
//  Demo
//
//  Created by 高涌 on 2020/11/1.
//

import UIKit

struct APIResult:APIList {

    var apis: [APIData]
    var time: Date

    init?(_ jsonData:Data) {
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        guard let dic = dict as? Dictionary<String, String> else {
            return nil
        }
        self.apis = [];
        for (key,value) in dic {
            self.apis.append(APIItem(name: key, url: value))
        }
        self.time = Date()
    }
    
    init?(_ storage:APIRequestResult){
        self.apis = [];
        
        for item in storage.apis!{
            if  let item = item as? APIRequestItem {
                self.apis.append(APIItem(name: item.name!, url: item.url!))
            }
        }
        self.time = storage.time!
    }


}


