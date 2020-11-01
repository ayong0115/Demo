//
//  APIResultModle.swift
//  Demo
//
//  Created by 高涌 on 2020/11/1.
//

import UIKit

struct APIResult:APIList {
    
    var apiList: [APIData]
    var time: Date
    
    init?(_ jsonData:Data) {
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        guard let dic = dict as? Dictionary<String, String> else {
            return nil
        }
        self.apiList = [];
        for (key,value) in dic {
            self.apiList.append(APIItem(apiName: key, apiUrl: value))
        }
        self.time = Date()
    }
    
    
}
