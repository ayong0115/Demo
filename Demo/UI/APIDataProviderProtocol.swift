//
//  APIDataProviderProtocol.swift
//  Demo
//
//  Created by 高涌 on 2020/11/1.
//

import Foundation

public protocol APIDataProvider {
    func fetchLatestApiList(_ completion: @escaping (APIList?,NSError?) -> Void)
}
