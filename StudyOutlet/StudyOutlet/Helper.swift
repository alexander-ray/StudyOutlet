//
//  Helper.swift
//  StudyOutlet
//
//  Created by Alex Ray on 4/4/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//
import UIKit

class Helper {
    static func base64ToImage(input: String) -> UIImage? {
        if let data = NSData(base64Encoded: input) {
            return UIImage(data: data as Data)
        }
        return nil
    }
}
