//
//  StringExtension.swift
//  cellarworx2Importer
//
//  Created by Kevin McQuown on 6/6/16.
//  Copyright © 2016 Windy City Lab. All rights reserved.
//

extension String
{
    func checkForBool() -> Bool
    {
        if self == "YES" || self == "1"
        {
            return true
        }
        else
        {
            return false
        }
    }
    func underbar() -> String
    {
        let items = self.componentsSeparatedByString(" ")
        let result = items.joinWithSeparator("_")
        return result
    }
}
