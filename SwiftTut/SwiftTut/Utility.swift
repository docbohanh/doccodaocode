//
//  Utility.swift
//  SwiftTut
//
//  Created by Thành Lã on 11/21/16.
//  Copyright © 2016 Bình Anh Electonics. All rights reserved.
//

import UIKit

/**
 Enum Font Size cho text
 */
enum FontSize: CGFloat {
    case small  = 12
    case normal = 15
    case large  = 18
    
}

/**
 Các loại Font hiển thị trên Iphone
 */
enum FontType: String {
    case LatoRegular        = "Lato-Regular"
    case LatoMedium         = "Lato-Medium"
    case LatoSemibold       = "Lato-Semibold"
    case LatoLight          = "Lato-Light"
    case LatoBold           = "Lato-Bold"
    case LatoBlackItalic    = "Lato-BlackItalic"
    case LatoItalic         = "Lato-Italic"
    
    case AvenirBlack        = "Avenir-Black"
    case AvenirBlackOblique = "Avenir-BlackOblique"
    case AvenirBookOblique  = "Avenir-BookOblique"
    case AvenirHeavy        = "Avenir-Heavy"
    case AvenirHeavyOblique = "Avenir-HeavyOblique"
    case AvenirLight        = "Avenir-Light"
    case AvenirLightOblique = "Avenir-LightOblique"
    case AvenirMedium       = "Avenir-Medium"
    case AvenirMediumOblique = "Avenir-MediumOblique"
    case AvenirOblique      = "Avenir-Oblique"
    case AvenirRoman        = "Avenir-Roman"
    case AvenirBook         = "Avenir-Book"
    
    case RobotoBold         = "Roboto-Bold"
    case RobotoLight        = "Roboto-Light"
    case RobotoMedium       = "Roboto-Medium"
    case RobotoRegular      = "Roboto-Regular"
    case RobotoThin         = "Roboto-Thin"
}
