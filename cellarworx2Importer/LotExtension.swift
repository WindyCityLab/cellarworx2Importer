//
//  LotExtension.swift
//  cellarworx2Importer
//
//  Created by Kevin McQuown on 6/5/16.
//  Copyright © 2016 Windy City Lab. All rights reserved.
//

import Foundation
extension Lot
{
    class func lotFromJSON(lot : [String:AnyObject]) -> Lot
    {
        let l = Lot()
        l.lotnumber = lot["LOTNUMBER"] as! String
        l.the_description = lot["DESCRIPTION"] as! String
        l.year = Int(lot["YEAR"] as! String)!
        l.clientcode = Int(lot["CLIENTCODE"] as! String)!
        l.theorder = Int(lot["THEORDER"] as! String)!
        l.favorite = (lot["FAVORITE"] as! String).checkForBool()
        l.organic = (lot["ORGANIC"] as! String).checkForBool()
        l.activelot = (lot["ACTIVELOT"] as! String).checkForBool()
        return l
    }
    
    override class func buildClassFromFile(file : String, complete:(success : Bool, error : NSError?) -> Void)
    {
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource(file, ofType: "json")
        do {
            let content = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            let data = content.dataUsingEncoding(NSUTF8StringEncoding)
            do {
                let result : [String: AnyObject] = try NSJSONSerialization.JSONObjectWithData(data!, options : NSJSONReadingOptions.MutableContainers) as! [String: AnyObject]
                let values = result["RECORDS"] as! [[String : AnyObject]]
                let q = Lot.query()
                q?.limit = 1000
                q?.findObjectsInBackgroundWithBlock({ (objects, error) in
                    PFObject.deleteAllInBackground(objects, block: { (result, error) in
                        var lots : [Lot] = Array()
                        print ("creating \(values.count) \(file) records")
                        for lot in values
                        {
                            lots.append(Lot.lotFromJSON(lot))
                        }
                        PFObject.saveAllInBackground(lots, block: { (result, error) in
                            if result
                            {
                                complete(success: true, error: nil)
                            }
                            else
                            {
                                complete(success: false, error: error)
                            }
                        })
                    })
                })
            }
            catch {
                
            }
        }
        catch {
            
        }
    }
    
    class func addClientRelationships(complete : (success : Bool, error : NSError?) -> Void)
    {
        var clientDictionary : [Int : Client] = [:]
        Client.getAll { (clients, error) in
            for c in clients
            {
                clientDictionary[c.clientid] = c
            }
            Lot.getAll({ (lots, error) in
                for l in lots
                {
                    l.client = clientDictionary[l.clientcode]!
                }
                PFObject.saveAllInBackground(lots, block: { (success, error) in
                    complete(success: success , error: error)
                })
            })
        }
    }
    
    class func getAll(complete : (object : [Lot], error : NSError?) -> Void)
    {
        getAllGeneric(Lot()) { (objects, error) in
            complete(object: objects, error: error)
        }
    }

}