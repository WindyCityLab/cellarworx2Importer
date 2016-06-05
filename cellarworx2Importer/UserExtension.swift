//
//  User_Extension.swift
//  cellarworx2Importer
//
//  Created by Kevin McQuown on 6/4/16.
//  Copyright © 2016 Windy City Lab. All rights reserved.
//

import Foundation

extension User
{
    class func userFromJSON(user : [String:AnyObject]) -> User
    {
        let u = User()
        u.clientid = Int(user["clientid"] as! String)!
        u.username = user["username"] as! String!
        u.staffEnum = (user["staff"] as! String).checkForBool()
        if let g = Int(user["group"] as! String)
        {
            u.group = g
        }
        else
        {
            u.group = 0
        }
        u.deviceid = user["deviceid"] as! String
        u.password = "1234"
        u.cellphone = user["cellphone"] as! String
        //        u.carrier = user["carrier"] as! String!
        u.name = user["name"] as! String
        return u
    }
    
    class func buildClassFromFile(file : String, complete:(success : Bool, error : NSError?) -> Void)
    {
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource(file, ofType: "json")
        do {
            let content = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            let data = content.dataUsingEncoding(NSUTF8StringEncoding)
            do {
                let result : [String: AnyObject] = try NSJSONSerialization.JSONObjectWithData(data!, options : NSJSONReadingOptions.MutableContainers) as! [String: AnyObject]
                let values = result["RECORDS"] as! [[String : AnyObject]]
                var users : [User] = Array()
                print ("creating \(values.count) \(file) records")
                for user in values
                {
                    users.append(User.userFromJSON(user))
                }
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    for user in users
                    {
                        do {
                            try user.signUp()
                        }
                        catch {
                            complete(success: false, error: nil)
                        }
                    }
                    dispatch_async(dispatch_get_main_queue()) {
                        complete(success: true, error: nil)
                    }
                }
            }
            catch {
                
            }
        }
        catch {
            
        }
    }
    
    class func getAll(complete: (objects : [User], error : NSError?)-> Void)
    {
        getGenericAll(User()) { (objects, error) in
            complete(objects: objects, error: error)
        }
    }
}