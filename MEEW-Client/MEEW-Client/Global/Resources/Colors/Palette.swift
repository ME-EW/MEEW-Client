//
//  Palette.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/20.
//
import UIKit

extension UIColor {

  @nonobjc class var white: UIColor {
    return UIColor(white: 1.0, alpha: 1.0)
  }

  @nonobjc class var lightGrey1: UIColor {
    return UIColor(white: 212.0 / 255.0, alpha: 1.0)
  }
  @nonobjc class var lightgrey2: UIColor {
    return UIColor(displayP3Red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
  }

  @nonobjc class var grey: UIColor {
    return UIColor(white: 152.0 / 255.0, alpha: 1.0)
  }
  
  @nonobjc class var grey2: UIColor {
    return UIColor(displayP3Red: 73/255, green: 73/255, blue: 73/255, alpha: 1)
  }
  
  @nonobjc class var darkgrey2: UIColor {
    return UIColor(displayP3Red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
  }

  @nonobjc class var bgDarkgrey: UIColor {
    return UIColor(white: 48.0 / 255.0, alpha: 1.0)
  }

}
