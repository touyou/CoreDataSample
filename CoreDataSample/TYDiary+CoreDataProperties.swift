//
//  TYDiary+CoreDataProperties.swift
//  CoreDataSample
//
//  Created by 藤井陽介 on 2017/01/15.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import CoreData


extension TYDiary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TYDiary> {
        return NSFetchRequest<TYDiary>(entityName: "Diary");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var text: String?

}
