//
//  AdditionsExtension.swift
//  cellarworx2Importer
//
//  Created by Kevin McQuown on 6/7/16.
//  Copyright © 2016 Windy City Lab. All rights reserved.
//

import Foundation

extension Addition
{
    class func additionsFromJSON(additions : [[String:AnyObject]], complete : (success : Bool, error : NSError?) -> Void)
    {
        var allAdditions : [Addition] = Array()
        for addition in additions
        {
            let a = Addition()
            a.id = Int(addition["ID"] as! String)!
            a.superfoodamt = Int(addition["SUPERFOODAMT"] as! String)!
            a.dapamount = Int(addition["DAPAMOUNT"] as! String)!
            a.htaamount = Int(addition["HTAAMOUNT"] as! String)!
            a.goamount = Int(addition["GOAMOUNT"] as! String)!
            a.wateramount = Int(addition["WATERAMOUNT"] as! String)!
            a.innoculationbrand = addition["INNOCULATIONBRAND"] as! String
            a.innoculationamount = Int(addition["INNOCULATION"] as! String)!
            a.brix = Int(addition["BRIX"] as! String)!
            a.labtest = addition["LABTEST"] as! String
            a.bleedamount = Int(addition["BLEEDAMOUNT"] as! String)!
            a.daycount = Int(addition["DAYCOUNT"] as! String)!
            allAdditions.append(a)
        }
        PFObject.saveAllInBackground(allAdditions) { (success, error) in
            complete(success: success, error: error)
        }
    }

}