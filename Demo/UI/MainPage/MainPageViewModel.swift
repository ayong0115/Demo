//
//  MainPageViewModel.swift
//  Demo
//
//  Created by 高涌 on 2020/11/1.
//

import UIKit

class MainPageViewModelFactory {
    static func createMainPageViewModel(aDelegate:MainPageViewModelDelegate) -> MainPageViewModel {
        return MainPageViewModel(dataProvider: APIOnlineProvider(),localProvider: APILocalProvider(),delegate: aDelegate)
    }
}

protocol MainPageViewModelDelegate:class {
    func fetchWithError(error:NSError)
    func fetchSuccess()
}

class MainPageViewModel: NSObject {
    struct constants {
        static let kTimerInterval = 5.0
    }
    
    private let apiDataProvider: APIDataProvider
    private let apiLocalProvider: APILocalProvider
    private var timer: Timer?
    weak var delegate:MainPageViewModelDelegate?
    private var currentResult:APIList?
    
    internal init(dataProvider:APIDataProvider,localProvider:APILocalProvider, delegate:MainPageViewModelDelegate) {
        self.apiDataProvider = dataProvider
        self.apiLocalProvider = localProvider
        self.delegate = delegate
    }
    
    func startRegularRefresh() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: constants.kTimerInterval, target: self, selector: #selector(fetchAPI), userInfo: nil, repeats: true)
        if currentResult == nil {
            fetchFromLocal()
        }
    }
    
    func stopRegularRefresh() {
        timer?.invalidate()
    }
    
    func numberOfRecord() -> Int{
        if currentResult != nil {
            return 1
        }
        return 0
    }
    
    func resultFor(indexpath:IndexPath) -> APIList?{
        if currentResult != nil {
            return currentResult
        }
        return nil
    }
//MARK: PRIVATE
    
    private func fetchFromLocal() {
        weak var weakSelf = self
        apiLocalProvider.fetchLatestApiList { (apiList, error) in
            DispatchQueue.main.async {
                if let error = error{
                    weakSelf?.delegate?.fetchWithError(error: error)
                    return
                }
                weakSelf?.currentResult = apiList
                weakSelf?.delegate?.fetchSuccess()
            }
        }
    }
    
    @objc private func fetchAPI() {
        weak var weakSelf = self
        apiDataProvider.fetchLatestApiList { (apiList, error) in
            DispatchQueue.main.async {
                if let error = error{
                    weakSelf?.delegate?.fetchWithError(error: error)
                    return
                }
                weakSelf?.currentResult = apiList
                weakSelf?.delegate?.fetchSuccess()
            }

        }
    }
    
}

