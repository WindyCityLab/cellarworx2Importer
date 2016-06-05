//
//  getAll.swift
//  cellarworx2Importer
//
//  Created by Kevin McQuown on 6/5/16.
//  Copyright © 2016 Windy City Lab. All rights reserved.
//

import Foundation

func deleteGenericAll<T:PFObject>(item : T, complete: (success : Bool, error : NSError?)-> Void)
{
    var allItems : [T] = Array()
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
        var stillMoreToRetrieve = true
        var skipCount = 0
        let q = T.query()
        q?.limit = 1000
        while stillMoreToRetrieve
        {
            do {
                q?.skip = skipCount
                let items = try q?.findObjects() as! [T]
                skipCount = skipCount + 1000
                if items.count < 1000
                {
                    stillMoreToRetrieve = false
                }
                for l in items
                {
                    allItems.append(l)
                }
                try PFObject.deleteAll(allItems)
            }
            catch {
            }
        }
        dispatch_async(dispatch_get_main_queue()) {
            complete(success: true, error: nil)
        }
    }
}

func getGenericAll<T:PFObject>(item : T, complete: (objects : [T], error : NSError?)-> Void)
{
    var allItems : [T] = Array()
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
        var stillMoreToRetrieve = true
        var skipCount = 0
        let q = T.query()
        q?.limit = 1000
        while stillMoreToRetrieve
        {
            do {
                q?.skip = skipCount
                let items = try q?.findObjects() as! [T]
                skipCount = skipCount + 1000
                if items.count < 1000
                {
                    stillMoreToRetrieve = false
                }
                for l in items
                {
                    allItems.append(l)
                }
            }
            catch {
            }
        }
        dispatch_async(dispatch_get_main_queue()) {
            complete(objects: allItems, error: nil)
        }
    }
}

func buildOut<T:CellarworxClass>(item : T, file : String, complete : (success : Bool, error : NSError?) -> Void)
{
    T.buildClassFromFile(file) { (success, error) in
        
    }
}

func getAllGeneric<T:CellarworxClass>(item : T, complete: (objects : [T], error : NSError?)-> Void)
{
    getGenericAll(item) { (objects, error) in
        complete(objects: objects, error: error)
    }
}

func deleteAllGeneric<T:CellarworxClass>(item : T, complete: (success : Bool, error : NSError?) -> Void)
{
    deleteGenericAll(item) { (success, error) in
        complete(success: success, error: error)
    }
}
