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

public protocol APIHistoryProvider : APIDataProvider {
    func fetchAllRequestHistory(_ completion: @escaping ([APIList],NSError?) -> Void)
}
