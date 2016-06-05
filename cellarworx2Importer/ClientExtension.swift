//
//  Client_Extension.swift
//  cellarworx2Importer
//
//  Created by Kevin McQuown on 6/4/16.
//  Copyright © 2016 Windy City Lab. All rights reserved.
//

import Foundation

extension Client
{
    class func clientFromJSON(client : [String:AnyObject]) -> Client
    {
        let c = Client()
        c.clientid = Int(client["clientid"] as! String)!
        c.clientname = client["CLIENTNAME"] as! String
        c.code = client["CODE"] as! String
        c.address1 = client["ADDRESS1"] as! String
        c.address2 = client["ADDRESS2"] as! String
        c.city = client["CITY"] as! String
        c.state = client["STATE"] as! String
        c.zip = client["ZIP"] as! String
        c.phone = client["PHONE"] as! String
        c.bond = client["BOND"] as! String
        c.ap = (client["AP"] as! String).checkForBool()
        c.active = (client["ACTIVE"] as! String).checkForBool()
        return c
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
                let q = Client.query()
                q?.limit = 1000
                q?.findObjectsInBackgroundWithBlock({ (objects, error) in
                    PFObject.deleteAllInBackground(objects, block: { (result, error) in
                        var clients : [Client] = Array()
                        print ("creating \(values.count) \(file) records")
                        for client in values
                        {
                            clients.append(Client.clientFromJSON(client))
                        }
                        PFObject.saveAllInBackground(clients, block: { (result, error) in
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
    class func getAll(complete : (object : [Client], error : NSError?) -> Void)
    {
        getAllGeneric(Client()) { (objects, error) in
            complete(object: objects, error: error)
        }
    }

}