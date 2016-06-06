//
//  WoExtension.swift
//  cellarworx2Importer
//
//  Created by Kevin McQuown on 6/5/16.
//  Copyright © 2016 Windy City Lab. All rights reserved.
//

import Foundation
extension Wo
{
    class func woFromJSONAndMapLots(workOrdersArray : [[String:AnyObject]], complete:(success : Bool, error : NSError?)->Void)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)) {
            var lotDictionary : [String: Lot] = [:]
            Lot.getAll { (lots, error) in
                for l in lots
                {
                    lotDictionary[l.lotnumber] = l
                }
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "MM/DD/YYYY HH:MM:SS"
                
                var count = 0
                var allWo : [Wo] = Array()
                for item in workOrdersArray
                {
                    count += 1
                    let w = Wo()
                    w.id = Int(item["ID"] as! String)!
                    w.dueDate = dateFormatter.dateFromString(item["DUEDATE"] as! String)!
                    w.type = typeEnum(rawValue: (item["TYPE"] as! String).underbar())!
                    w.lotNumber = item["LOT"] as! String
                    w.lot = lotDictionary[w.lotNumber]!
                    w.vesseltype = vesseltypeEnum(rawValue: (item["VESSELTYPE"] as! String).underbar())!
                    allWo.append(w)
                    if count >= 100
                    {
                        
                    }
                }
            }
        }
    }

}