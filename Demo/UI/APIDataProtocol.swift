//
//  APIDataProtocol.swift
//  Demo
//
//  Created by 高涌 on 2020/11/1.
//

import Foundation

public protocol APIList {
    var time: Date { get }
    var apis:[APIData] { get }
}

public protocol APIData {
    var name: String { get }
    var url: String { get }
    
}
