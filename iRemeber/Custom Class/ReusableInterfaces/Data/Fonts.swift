//
//  Fonts.swift
//  Cozy Up
//
//  Created by Amisha on 22/05/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import Foundation

import UIKit

let HELVETICA_BOLD = "HelveticaNeue-Bold"
let HELVETICA_MEDIUM = "HelveticaNeue-Medium"
let HELVETICA_REGULAR = "HelveticaNeue"

enum FontType : String {
    case Clear = ""
    case HelveticaBold = "hb"
    case HelveticaMedium = "hm"
    case HelveticaRegular = "hr"
}


extension FontType {
    var value: String {
        get {
            switch self {
            case .Clear:
                return HELVETICA_REGULAR
            
            case .HelveticaBold:
                return HELVETICA_BOLD
            case .HelveticaMedium:
                return HELVETICA_MEDIUM
            case .HelveticaRegular:
                return HELVETICA_REGULAR
            }
        }
    }
}

