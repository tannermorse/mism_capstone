//
//  +UIColor.swift
//  Final_Exam_Morse_Tanner
//
//  Created by Tanner Morse on 12/16/19.
//  Copyright © 2019 Tanner Morse. All rights reserved.
//

import UIKit

extension UIColor{
    class func fromHex(_ rgbValue:UInt32, alpha:Double=1.0) -> UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    class func themeOrange() -> UIColor{
        let color = UIColor.fromHex(0xFFAE41, alpha: 1.0)
        return color
    }
    
    class func themeRed() -> UIColor{
        let color = UIColor.fromHex(0xB0413E, alpha: 1.0)
        return color
    }
    
    class func themeBlue() -> UIColor{
        let color = UIColor.fromHex(0x4DA1A9, alpha: 1.0)
        return color
    }
    
    class func themeBone() -> UIColor{
        let color = UIColor.fromHex(0xFFFFC7, alpha: 1.0)
        return color
    }
    
    class func themeBlack() -> UIColor{
        let color = UIColor.fromHex(0x1F363D, alpha: 1.0)
        return color
    }
    
}
