//
//  APIOnlineProvider.swift
//  Demo
//
//  Created by 高涌 on 2020/11/1.
//

import Foundation

class APIOnlineProvider: NSObject {
    struct Constants {
        static let kRequestUrl = "https://api.github.com/"
    }
}


extension APIOnlineProvider : APIDataProvider {

    
    func fetchLatestApiList(_ completion: @escaping (APIList?,NSError?) -> Void) {
        let url = URL(string: APIOnlineProvider.Constants.kRequestUrl)
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(nil, error as NSError)
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            if let result = APIResult(data){
                LocalSotrageHelper.shared.saveResult(result: result)
                completion(result,nil)
            }
        }
        task.resume()
    }
    
    
}
