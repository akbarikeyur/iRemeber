//
//  AppModel.swift
//  Cozy Up
//
//  Created by Amisha on 15/10/18.
//  Copyright © 2018 Amisha. All rights reserved.
//
import UIKit

var categoryNameArr : [String] = [String]()


class AppModel: NSObject {
    static let shared = AppModel()
    
    var ImageQueue : [String : UIImage] = [String : UIImage]()
    var QuestionArr : [QuestionModel] = [QuestionModel]()
    
    func validateUser(dict : [String : Any]) -> Bool{
        if let uID = dict["uID"] as? String, let email = dict["email"] as? String
        {
            if(uID != "" && email != "") {
                return true
            }
        }
        return false
    }
    
//    func getSentUserArrOfDictionary(arr:[UserModel]) -> [[String:Any]]{
//
//        let len:Int = arr.count
//        var retArr:[[String:Any]] =  [[String:Any]] ()
//        for i in 0..<len{
//            retArr.append(arr[i].dictionary())
//        }
//        return retArr
//    }
    
//    func getReviewArrOfDictionary(arr:[ReviewModel]) -> [[String:Any]]{
//
//        let len:Int = arr.count
//        var retArr:[[String:Any]] =  [[String:Any]] ()
//        for i in 0..<len{
//            retArr.append(arr[i].dictionary())
//        }
//        return retArr
//    }

//    func getExperienceArrOfDictionary(arr:[ExperienceModel]) -> [[String:Any]]{
//
//        let len:Int = arr.count
//        var retArr:[[String:Any]] =  [[String:Any]] ()
//        for i in 0..<len{
//            retArr.append(arr[i].dictionary())
//        }
//        return retArr
//    }
    
    func resetAllModel()
    {
//        currentUser = UserModel.init()
        ImageQueue = [String : UIImage]()
       
    }
}



class QuestionModel : AppModel
{
    var id : String!
    var question : String!
    var answer : String!
    
    override init(){
        id = ""
        question = ""
        answer = ""
        
    }
    
    init(dict : [String : Any])
    {
        id = ""
        question = ""
        answer = ""
        
        
        if let temp = dict["id"] as? String {
            id = temp
        }
        if let temp = dict["question"] as? String {
            question = temp
        }
        if let temp = dict["answer"] as? String {
            answer = temp
        }
      
    }
    
    func dictionary() -> [String:Any]  {
        return ["id" : id ,"question":question, "answer":answer]
    }
    
    func toJson(_ dict:[String:Any]) -> String{
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString!
    }
}


class LocatorModel : AppModel
{
    var id : String!
    var image : String!
    var name : String!
    var descriptions : String!
    var location : String!
    var type : Int!
    var time : String!
    
    override init(){
        id = ""
        image = ""
        name = ""
        descriptions = ""
        location = ""
        type = 0
        time = ""
    }
    
    init(dict : [String : Any])
    {
        id = ""
        image = ""
        name = ""
        descriptions = ""
        location = ""
        type = 0
        time = ""
        
        
        if let temp = dict["id"] as? String {
            id = temp
        }
        if let temp = dict["image"] as? String {
            image = temp
        }
        if let temp = dict["name"] as? String {
            name = temp
        }
        if let temp = dict["descriptions"] as? String {
            descriptions = temp
        }
        if let temp = dict["location"] as? String {
            location = temp
        }
        if let temp = dict["type"] as? Int {
            type = temp
        }
        if let temp = dict["time"] as? String {
            time = temp
        }
        
    }
    
    func dictionary() -> [String:Any]  {
        return ["id":id, "image":image, "name":name, "descriptions":descriptions, "location":location, "type": type, "time":time]
    }
    
    func toJson(_ dict:[String:Any]) -> String{
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString!
    }
}


class MemoryModel : AppModel
{
    var id : String!
    var title : String!
    var image : String!
    var name : String!
    var date : String!
    var selectedImg : UIImage!
    
    override init(){
        id = ""
        title = ""
        image = ""
        name = ""
        date = ""
        selectedImg = nil
    }
    
    init(dict : [String : Any])
    {
        id = ""
        title = ""
        image = ""
        name = ""
        date = ""
        selectedImg = nil
        
        
        if let temp = dict["id"] as? String {
            id = temp
        }
        if let temp = dict["title"] as? String {
            title = temp
        }
        if let temp = dict["image"] as? String {
            image = temp
        }
        if let temp = dict["name"] as? String {
            name = temp
        }
        if let temp = dict["date"] as? String {
            date = temp
        }

    }
    
    func dictionary() -> [String:Any]  {
        return ["id":id, "title" : title, "image":image, "name":name, "date":date]
    }
    
    func toJson(_ dict:[String:Any]) -> String{
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString!
    }
}


//class CaptureModel : AppModel
//{
//    var id : String!
//    var image : String!
//    var type : Int!
//    var descriptions : String!
//    
//    override init(){
//        id = ""
//        image = ""
//        type = 0
//        descriptions = ""
//    }
//    
//    init(dict : [String : Any])
//    {
//        id = ""
//        image = ""
//        type = 0
//        descriptions = ""
//        
//        if let temp = dict["id"] as? String {
//            id = temp
//        }
//        if let temp = dict["image"] as? String {
//            image = temp
//        }
//        if let temp = dict["type"] as? Int {
//            type = temp
//        }
//        if let temp = dict["descriptions"] as? String {
//            descriptions = temp
//        }
//        
//    }
//    
//    func dictionary() -> [String:Any]  {
//        return ["id":id, "image":image, "type":type, "descriptions":descriptions]
//    }
//    
//    func toJson(_ dict:[String:Any]) -> String{
//        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
//        let jsonString = String(data: jsonData!, encoding: .utf8)
//        return jsonString!
//    }
//}

