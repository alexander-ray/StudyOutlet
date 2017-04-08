//
//  Helper.swift
//  StudyOutlet
//
//  Created by Alex Ray on 4/4/17.
//  Copyright © 2017 StudyOutletGroup. All rights reserved.
//
import UIKit

class Helper {
    static func base64ToImage(input: String) -> UIImage {
        let str = base64PaddingWithEqual(encoded64: input)
        let data = NSData(base64Encoded: str)
        // unsafe
        return UIImage(data: data! as Data)!
    }
    
    // Pad string to be divisible by 4
    // http://stackoverflow.com/questions/36364324/swift-base64-decoding-returns-nil
    static func base64PaddingWithEqual(encoded64: String) -> String {
        let remainder = encoded64.characters.count % 4
        // If no padding needed
        if remainder == 0 {
            return encoded64
        } else {
            // padding with equal
            let newLength = encoded64.characters.count + (4 - remainder)
            return encoded64.padding(toLength: newLength, withPad: "=", startingAt: 0)
        }
    }
}
