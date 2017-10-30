//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by baytoor on 8/11/17.
//  Copyright © 2017 Baytur. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
}
