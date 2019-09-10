//
//  GlobalConstant.swift
//  Cozy Up
//
//  Created by Amisha on 15/10/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import Foundation
import UIKit

let DEVICE_ID = UIDevice.current.identifierForVendor?.uuidString

struct SCREEN
{
    static var WIDTH = UIScreen.main.bounds.size.width
    static var HEIGHT = UIScreen.main.bounds.size.height
}

struct DATE_FORMAT {
    static var SERVER_DATE_FORMAT = "YYYY-MM-dd"
    static var SERVER_TIME_FORMAT = "HH:mm"
    static var SERVER_DATE_TIME_FORMAT = "yyyy-MM-dd" //HH:mm:ss"
    static var DISPLAY_DATE_FORMAT = "dd/MM/yyyy"
    static var DISPLAY_DATE_FORMAT1 = "MM/dd/yyyy"
    static var DISPLAY_TIME_FORMAT = "hh:mm a"
    static var DISPLAY_DATE_TIME_FORMAT = "YYYY-MM-dd HH:mm:ss"
}

struct NOTIFICATION {
    static let SELECTED_CAPTURE             =   "SELECTED_CAPTURE"
    static let UPDATE_CAPTURE               =   "UPDATE_CAPTURE"
}

struct COREDATA {
    struct QUESTION
    {
        static var id = "id"
        static var answer = "answer"
        static var question = "question"
    }
    struct LOCATOR
    {
        static var id = "id"
        static var image = "image"
        static var name = "name"
        static var descriptions = "descriptions"
        static var location = "location"
    }
    struct MEMORY
    {
        static var id = "id"
        static var title = "title"
        static var image = "image"
        static var name = "name"
        static var date = "date"

    }
    struct CAPTURE
    {
        static var id = "id"
        static var image = "image"
        static var type = "type"
        static var descriptions = "descriptions"
        static var time = "time"
    }
    struct USERNAME
    {
        static var name = "name"
    }
}

struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}
