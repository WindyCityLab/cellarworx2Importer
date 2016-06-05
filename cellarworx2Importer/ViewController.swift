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
        Lot.addClientRelationships { (success, error) in
            print ("relationships added")
        }
//        Lot.buildClassFromFile("lots") { (success, error) in
//            Lot.getAll({ (objects, error) in
//                print("Retrieved all lots, total count: \(objects.count)")
//            })
//        }
//        Client.buildClassFromFile("clients") { (success, error) in
//            User.buildClassFromFile("users", complete: { (success, error) in
//                var clients : [Client] = Array()
//                var users : [User] = Array()
//                Client.getAll({ (objects, error) in
//                    clients = objects
//                    User.getAll({ (objects, error) in
//                        users = objects
//                        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
//                        dispatch_async(dispatch_get_global_queue(priority, 0)) {
//                            for user in users
//                            {
//                                print (user.username)
//                                for client in clients
//                                {
//                                    if client.clientid == user.clientid
//                                    {
//                                        print ("match found")
//                                        user.client = client
//                                        do {
//                                            try PFUser.logInWithUsername(user.username!, password: "1234")
//                                            try user.save()
//                                            PFUser.logOut()
//                                        }
//                                        catch {
//                                        }
//                                        break
//                                    }
//                                }
//                            }
//                        }
//                    })
//                })
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

