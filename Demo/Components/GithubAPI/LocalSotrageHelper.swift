//
//  LocalSotrageHelper.swift
//  Demo
//
//  Created by 高涌 on 2020/11/1.
//

import UIKit
import CoreData

class LocalSotrageHelper: NSObject {
    static let shared = LocalSotrageHelper()
    lazy var coreDataStack = CoreDataStack(modelName: "Demo")

    private override init() {
        
    }
    
    override func copy() -> Any {
        return self
    }
    
    override func mutableCopy() -> Any {
        return self
    }
    
    func saveResult(result: APIResult){
        let storeResult = APIRequestResult(context: coreDataStack.managedContext)
        storeResult.time = result.time
        if let items = storeResult.apis?.mutableCopy() as? NSMutableOrderedSet{
            for APIItem in result.apis {
                let item = APIRequestItem(context: coreDataStack.managedContext)
                item.name = APIItem.name
                item.url = APIItem.url
                items.add(item)
            }
            storeResult.apis = items
        }
        do {
            try coreDataStack.managedContext.save()
        }catch let error as NSError {
            print("Save error: \(error), description: \(error.userInfo)")
          }

    }
    func fetchAllResult() ->[APIList]{
        
        let resultFetch: NSFetchRequest<APIRequestResult> = APIRequestResult.fetchRequest()
        let sort = NSSortDescriptor(key: "time", ascending: false)
        resultFetch.sortDescriptors = [sort]
        do {
            let result = try coreDataStack.managedContext.fetch(resultFetch)
            print("current number: \(result.count)")
            var array = [APIList]()
            for request in result {
                if let model = APIResult(request) {
                    array.append(model)
                }
                
            }
            return array
            
        }catch let error as NSError{
            print("fetch error: \(error), description: \(error.userInfo)")
            return []
        }
        
    }
    


}
