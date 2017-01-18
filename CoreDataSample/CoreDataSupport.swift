//
//  CoreDataSupport.swift
//  CoreDataSample
//
//  Created by 藤井陽介 on 2017/01/18.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class CoreDataSupport<T: NSManagedObject> {
    private var appDelegate: AppDelegate
    private var context: NSManagedObjectContext
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    open func searchData(by predicate: NSPredicate) -> [T]? {
        let fetchRequest = T.fetchRequest()
        let fetchData = try! context.fetch(fetchRequest)
        return fetchData as? [T]
    }
    
    open func saveOrUpdateData() {}
}
