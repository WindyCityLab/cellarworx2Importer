//
//  ViewController.swift
//  cellarworx2Importer
//
//  Created by Kevin McQuown on 6/4/16.
//  Copyright © 2016 Windy City Lab. All rights reserved.
//

import UIKit
import CellarworxKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("clients", ofType: "json")
        do {
            let content = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            let data = content.dataUsingEncoding(NSUTF8StringEncoding)
            do {
                let result : [String: AnyObject] = try NSJSONSerialization.JSONObjectWithData(data!, options : NSJSONReadingOptions.MutableContainers) as! [String: AnyObject]
                let values = result["RECORDS"] as! [[String : AnyObject]]
                let q = Client.query()
                q?.findObjectsInBackgroundWithBlock({ (objects, error) in
                    PFObject.deleteAllInBackground(objects, block: { (result, error) in
                        var clients : [Client] = Array()
                        for client in values
                        {
                           let c = Client()
                            c.clientname = client["CLIENTNAME"] as! String
                            c.code = client["CODE"] as! String
                            clients.append(c)
                        }
                        PFObject.saveAllInBackground(clients, block: { (result, error) in
                            if result
                            {
                                print("hooray client worked")
                            }
                            else
                            {
                                print(error?.localizedDescription)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

