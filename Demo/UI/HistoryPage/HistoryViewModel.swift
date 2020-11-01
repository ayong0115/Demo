//
//  HistoryViewModel.swift
//  Demo
//
//  Created by 高涌 on 2020/11/1.
//

import UIKit
class HistoryViewModelFactory {
    static func createHisotryViewModel(aDelegate:HistoryViewModelDelegate) -> HistoryViewModel {
        return HistoryViewModel(dataProvider: APILocalProvider(),delegate: aDelegate)
    }
}

protocol HistoryViewModelDelegate:class {
    func fetchWithError(error:NSError)
    func fetchSuccess()
}

class HistoryViewModel: NSObject {
    private let apiDataProvider: APIHistoryProvider
    weak var delegate:HistoryViewModelDelegate?
    private var currentResultList:[APIList] = []
    
    internal init(dataProvider:APIHistoryProvider,delegate:HistoryViewModelDelegate) {
        self.apiDataProvider = dataProvider
        self.delegate = delegate
    }
    
    func loadHistory() {
        
        weak var weakSelf = self
        self.apiDataProvider.fetchAllRequestHistory{ (list, error) in
            DispatchQueue.main.async {
                if let error = error{
                    weakSelf?.delegate?.fetchWithError(error: error)
                }else{
                    weakSelf?.currentResultList.removeAll()
                    weakSelf?.currentResultList.append(contentsOf: list)
                    weakSelf?.delegate?.fetchSuccess()
                }
                
                
                
            }
        }
        
    }
    
    func numberOfHistory() -> Int {
        return currentResultList.count
    }
    
    func resultFor(indexpath:IndexPath) -> APIList?{
        if indexpath.row <= currentResultList.count - 1 {
            return currentResultList[indexpath.row]
        }
        return nil
    }
}
