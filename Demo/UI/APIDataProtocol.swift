//
//  APIDataProtocol.swift
//  Demo
//
//  Created by 高涌 on 2020/11/1.
//

import Foundation

public protocol APIList {
    var time: Date { get }
    var apiList:[APIData] { get }
}

public protocol APIData {
    var apiName: String { get }
    var apiUrl: String { get }
    
}
