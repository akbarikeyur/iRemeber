//
//  CoreDataUtility.swift
//  Fabric
//
//  Created by PC on 31/12/18.
//  Copyright © 2018 PC. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class CoreDataUtility: NSObject {
    static let shared = CoreDataUtility()
    
    //MARK:- save
    func saveQuestionAnswer(Model : QuestionModel, TableName : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: TableName, in: managedContext)
        
        // Here adding data
        let user = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        user.setValue(Model.id, forKey: COREDATA.QUESTION.id)
        user.setValue(Model.question, forKey: COREDATA.QUESTION.question)
        user.setValue(Model.answer, forKey: COREDATA.QUESTION.answer)
        
        
        do {
            try managedContext.save()
            print("Successfully save data")
        } catch let Error as NSError {
            print("Could not save. \(Error), \(Error.userInfo)")
        }
    }
    
    //MARK:- Fatch
    func fatchQuestionAnswer(TableName: String) -> [QuestionModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TableName)
        // fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: true)]
        var customerArr:[QuestionModel] = [QuestionModel]()
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]
            {
                let customer : QuestionModel = QuestionModel.init()
                customer.id = data.value(forKey: COREDATA.QUESTION.id) as! String
                customer.question = data.value(forKey: COREDATA.QUESTION.question) as! String
                customer.answer = data.value(forKey: COREDATA.QUESTION.answer) as! String
                customerArr.append(customer)
            }
        } catch {
            print("Failed")
        }
        return customerArr
    }
    
    func selectQuestionAnswer(item : QuestionModel, TableName: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TableName)
//        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: true)]
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", item.id)
        
        var customerArr:QuestionModel = QuestionModel()
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count == 0 {
                print("no data")
                return false
            } else {
                print("ok")
                return true
            }
        } catch {
            print("Failed")
            return false
        }
        return false
    }
    
    func updateItem(item : QuestionModel, TableName : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TableName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", item.id)

        do {
            let result = try managedContext.fetch(fetchRequest)
            let objectUpdate = result[0] as! NSManagedObject
            objectUpdate.setValue(item.id, forKey: COREDATA.QUESTION.id)
            objectUpdate.setValue(item.question, forKey: COREDATA.QUESTION.question)
            objectUpdate.setValue(item.answer, forKey: COREDATA.QUESTION.answer)
            do {
                try managedContext.save()
                print("Successfully data updated")
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteQuestion(order : QuestionModel, TableName : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TableName)
        
        // Conditions
        fetchRequest.predicate = NSPredicate(format: "id = %@", order.id)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count != 0 {
                let objectToDelete = result[0] as! NSManagedObject
                managedContext.delete(objectToDelete)
                do {
                    try managedContext.save()
                    print("Successfully data deleted")
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    //MARK:- save
    func saveLocatorData(Model : LocatorModel, TableName : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: TableName, in: managedContext)
        
        // Here adding data
        let user = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        user.setValue(Model.id, forKey: COREDATA.LOCATOR.id)
        user.setValue(Model.image, forKey: COREDATA.LOCATOR.image)
        user.setValue(Model.name, forKey: COREDATA.LOCATOR.name)
        user.setValue(Model.descriptions, forKey: COREDATA.LOCATOR.descriptions)
        user.setValue(Model.location, forKey: COREDATA.LOCATOR.location)
        
        do {
            try managedContext.save()
            print("Successfully save data")
        } catch let Error as NSError {
            print("Could not save. \(Error), \(Error.userInfo)")
        }
    }
    
    //MARK:- Fatch
    func fatchLocatorData(TableName: String) -> [LocatorModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TableName)
        // fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: true)]
        var customerArr:[LocatorModel] = [LocatorModel]()
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]
            {
                let customer : LocatorModel = LocatorModel.init()
                customer.id = data.value(forKey: COREDATA.LOCATOR.id) as? String
                customer.image = (data.value(forKey: COREDATA.LOCATOR.image) as! String)
                customer.name = (data.value(forKey: COREDATA.LOCATOR.name) as! String)
                customer.descriptions = data.value(forKey: COREDATA.LOCATOR.descriptions) as? String
                customer.location = data.value(forKey: COREDATA.LOCATOR.location) as? String
                customerArr.append(customer)
            }
        } catch {
            print("Failed")
        }
        return customerArr
    }
    
    func deleteLocator(order : LocatorModel, TableName : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TableName)
        
        // Conditions
        fetchRequest.predicate = NSPredicate(format: "id = %@", order.id)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count != 0 {
                let objectToDelete = result[0] as! NSManagedObject
                managedContext.delete(objectToDelete)
                do {
                    try managedContext.save()
                    print("Successfully data deleted")
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func updateLocator(item : LocatorModel, TableName : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TableName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", item.id)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let objectUpdate = result[0] as! NSManagedObject
            objectUpdate.setValue(item.id, forKey: COREDATA.LOCATOR.id)
            objectUpdate.setValue(item.image, forKey: COREDATA.LOCATOR.image)
            objectUpdate.setValue(item.name, forKey: COREDATA.LOCATOR.name)
            objectUpdate.setValue(item.description, forKey: COREDATA.LOCATOR.descriptions)
            objectUpdate.setValue(item.location, forKey: COREDATA.LOCATOR.location)
            do {
                try managedContext.save()
                print("Successfully data updated")
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }

    
    
    //MARK: - MEMORY SETUP
    func saveMemories(Model : MemoryModel, TableName : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: TableName, in: managedContext)
        
        // Here adding data
        let user = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        user.setValue(Model.id, forKey: COREDATA.MEMORY.id)
        user.setValue(Model.title, forKey: COREDATA.MEMORY.title)
        user.setValue(Model.image, forKey: COREDATA.MEMORY.image)
        user.setValue(Model.name, forKey: COREDATA.MEMORY.name)
        user.setValue(Model.date, forKey: COREDATA.MEMORY.date)
        do {
            try managedContext.save()
            print("Successfully save data")
        } catch let Error as NSError {
            print("Could not save. \(Error), \(Error.userInfo)")
        }
    }
    
    //MARK:- Fatch
    func fatchMemories(TableName: String) -> [MemoryModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TableName)
        // fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: true)]
        var customerArr:[MemoryModel] = [MemoryModel]()
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]
            {
                let customer : MemoryModel = MemoryModel.init()
                customer.id = data.value(forKey: COREDATA.MEMORY.id) as? String
                customer.title = data.value(forKey: COREDATA.MEMORY.title) as? String
                customer.image = data.value(forKey: COREDATA.MEMORY.image) as? String
                customer.name = data.value(forKey: COREDATA.MEMORY.name) as? String
                customer.date = data.value(forKey: COREDATA.MEMORY.date) as? String
                customerArr.append(customer)
            }
        } catch {
            print("Failed")
        }
        return customerArr
    }
    
    func selectMemories(item : MemoryModel, TableName: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TableName)
        //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: true)]
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", item.id)

        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count == 0 {
                print("no data")
                return false
            } else {
                print("ok")
                return true
            }
        } catch {
            print("Failed")
            return false
        }
        return false
    }
    
    func updateMemories(item : MemoryModel, TableName : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TableName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", item.id)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let objectUpdate = result[0] as! NSManagedObject
            objectUpdate.setValue(item.id, forKey: COREDATA.MEMORY.id)
            objectUpdate.setValue(item.title, forKey: COREDATA.MEMORY.title)
            objectUpdate.setValue(item.image, forKey: COREDATA.MEMORY.image)
            objectUpdate.setValue(item.name, forKey: COREDATA.MEMORY.name)
            objectUpdate.setValue(item.date, forKey: COREDATA.MEMORY.date)
            do {
                try managedContext.save()
                print("Successfully data updated")
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteMemories(order : MemoryModel, TableName : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TableName)
        
        // Conditions
        fetchRequest.predicate = NSPredicate(format: "id = %@", order.id)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count != 0 {
                let objectToDelete = result[0] as! NSManagedObject
                managedContext.delete(objectToDelete)
                do {
                    try managedContext.save()
                    print("Successfully data deleted")
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    //MARK:- save
    func saveCaptureData(Model : LocatorModel, TableName : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: TableName, in: managedContext)
        
        // Here adding data
        let user = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        user.setValue(Model.id, forKey: COREDATA.CAPTURE.id)
        user.setValue(Model.image, forKey: COREDATA.CAPTURE.image)
        user.setValue(Model.descriptions, forKey: COREDATA.CAPTURE.descriptions)
        user.setValue(Model.type, forKey: COREDATA.CAPTURE.type)
        user.setValue(Model.time, forKey: COREDATA.CAPTURE.time)
        
        do {
            try managedContext.save()
            print("Successfully save data")
        } catch let Error as NSError {
            print("Could not save. \(Error), \(Error.userInfo)")
        }
    }
    
    //MARK:- Fatch
    func fatchCaptureData(TableName: String) -> [LocatorModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TableName)
        // fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: true)]
        var customerArr:[LocatorModel] = [LocatorModel]()
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]
            {
                let customer : LocatorModel = LocatorModel.init()
                customer.id = data.value(forKey: COREDATA.CAPTURE.id) as? String
                customer.image = (data.value(forKey: COREDATA.CAPTURE.image) as! String)
                customer.descriptions = data.value(forKey: COREDATA.CAPTURE.descriptions) as? String
                customer.type = data.value(forKey: COREDATA.CAPTURE.type) as? Int
                customer.time = data.value(forKey: COREDATA.CAPTURE.time) as? String
                customerArr.append(customer)
            }
        } catch {
            print("Failed")
        }
        return customerArr
    }

    func updateCapture(item : LocatorModel, TableName : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TableName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", item.id)

        do {
            let result = try managedContext.fetch(fetchRequest)
            let objectUpdate = result[0] as! NSManagedObject
            objectUpdate.setValue(item.id, forKey: COREDATA.CAPTURE.id)
            objectUpdate.setValue(item.image, forKey: COREDATA.CAPTURE.image)
            objectUpdate.setValue(item.descriptions, forKey: COREDATA.CAPTURE.descriptions)
            objectUpdate.setValue(item.type, forKey: COREDATA.CAPTURE.type)
            objectUpdate.setValue(item.time, forKey: COREDATA.CAPTURE.time)
            do {
                try managedContext.save()
                print("Successfully data updated")
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
}




//MARK:- save
func saveUserNameData(username : String, TableName : String) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let userEntity = NSEntityDescription.entity(forEntityName: TableName, in: managedContext)
    
    // Here adding data
    let user = NSManagedObject(entity: userEntity!, insertInto: managedContext)
    user.setValue(username, forKey: COREDATA.USERNAME.name)
    
    do {
        try managedContext.save()
        print("Successfully save data")
    } catch let Error as NSError {
        print("Could not save. \(Error), \(Error.userInfo)")
    }
}

//MARK:- Fatch
func fatchUserNameData(TableName: String) -> String {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TableName)
    // fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: true)]
    var customerArr : String = String()
    do {
        let result = try managedContext.fetch(fetchRequest)
        for data in result as! [NSManagedObject]
        {
            customerArr = data.value(forKey: COREDATA.USERNAME.name) as! String
        }
    } catch {
        print("Failed")
    }
    return customerArr
}
