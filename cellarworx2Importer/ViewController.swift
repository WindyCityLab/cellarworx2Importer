//
//  ViewController.swift
//  cellarworx2Importer
//
//  Created by Kevin McQuown on 6/4/16.
//  Copyright © 2016 Windy City Lab. All rights reserved.
//

import UIKit
//import CellarworxKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        User.addClientRelationships { (success, error) in
            print("Done")
        }
//        Lot.buildClassFromFile("lots") { (success, error) in
//            Client.buildClassFromFile("clients", complete: { (success, error) in
//                Lot.addClientRelationships { (success, error) in
//                    
//                }
//            })
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension String
{
    func checkForBool() -> Bool
    {
        if self == "YES"
        {
            return true
        }
        else
        {
            return false
        }
    }
}

