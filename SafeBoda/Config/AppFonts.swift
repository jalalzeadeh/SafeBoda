//
//  AppFonts.swift
//  SafeBoda
//
//  Created by Jalal on 9/22/21.
//

import Foundation
import UIKit

struct Fonts {
    // "Cairo-Regular" : "Cairo-Bold"
    private static let name = "Roboto-Regular", nameBold = "Roboto-Bold", light = "Roboto-Light"
    static let normal = UIFont(name: name, size: 17)
    static let small = UIFont(name: name, size: 14)
    static let xSmall = UIFont(name: name, size: 4)
    static let xxSmall = UIFont(name: name, size: 1)
    static let big = UIFont(name: name, size: 20)
    static let xBig = UIFont(name: name, size: 28)
    static let xBigName = UIFont(name: light, size: 20)
    static let xBarg = UIFont(name: light, size: 30)
    static let normalBold = UIFont(name: nameBold, size: 17)
    static let smallBold = UIFont(name: nameBold, size: 14)
    static let bigBold = UIFont(name: nameBold, size: 20)
    static let xbigBold = UIFont(name: nameBold, size: 30)
}
