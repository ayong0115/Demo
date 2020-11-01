//
//  APILocalProvider.swift
//  Demo
//
//  Created by 高涌 on 2020/11/1.
//

import UIKit

class APILocalProvider: NSObject {
    let localStorage = LocalSotrageHelper.shared
}
extension APILocalProvider : APIHistoryProvider {
    func fetchAllRequestHistory(_ completion: @escaping ([APIList], NSError?) -> Void) {
        let result = localStorage.fetchAllResult()
        completion(result,nil)
        

    }
    
    func fetchLatestApiList(_ completion: @escaping (APIList?,NSError?) -> Void) {
        let result = localStorage.fetchAllResult()
        if let first = result.first {
            completion(first,nil)
        }else{
            //TODO pass custom error
            completion(nil,nil)
        }
    }
        
    
    
}
