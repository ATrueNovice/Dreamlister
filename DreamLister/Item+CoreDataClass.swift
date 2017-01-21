//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by New on 1/19/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {


    //Any time an item is insterted (any item is created) this function will be called.
    public override func awakeFromInsert() {
        super.awakeFromInsert()


        //Whenever something is created, assign an attribute date.
        self.created = NSDate()
    }

}
