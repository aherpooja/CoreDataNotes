//
//  CoreDataManager.swift
//  CoreDataDemo
//
//  Created by webwerks on 01/08/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit
import CoreData

/// This class handles all core data related methods
final class CoreDataManager: NSObject {

    //MARK:- Variables
    static let shared = CoreDataManager()
    let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDel.persistentContainer.viewContext

    //MARK:- CRUD Operations

    /// This method inserts data
    ///
    /// - Parameters:
    ///   - data: [String:Any]
    ///   - entityName: String
    ///   - completion: returns success, error message on completion
    func inserData(_ data:[String:Any],entityName:String,_ completion: @escaping(_ success: Bool, _ error: String) -> Void) {

        if let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) {
            let newUser = NSManagedObject(entity: entity, insertInto: context)
            for (key,value) in data {
                newUser.setValue(value, forKey: key)
            }
            do {
                try context.save()
                completion(true,"")
            } catch {
                print(error.localizedDescription)
                completion(false,error.localizedDescription)
            }
        }

    }


    /// This method gets all record from entity
    ///
    /// - Parameter completion: returns success, data and error msg
    func fetchAllData(_ entityName:String,_ completion: @escaping(_ success: Bool, _ data: [[String:Any]]?, _ error: String) -> Void) {
        var arrData = [[String:Any]]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            if let result = try context.fetch(request) as? [NSManagedObject] {
                for data in result {
                    arrData.append(data.toDictionary())
                }
                completion(true, arrData, "")
            }
        } catch  let error as NSError {
            completion(false, nil, error.localizedDescription)
        }
    }


    /// This method update record
    ///
    /// - Parameters:
    ///   - data: [String:Any]
    ///   - search: (String,String)
    ///   - entityName: entityName
    ///   - completion: returns success, error
    func updateData(_ data:[String:Any], search:(String,String),entityName:String,_ completion: @escaping(_ success: Bool, _ error: String) -> Void){

        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "\(search.0) = %@", search.1)
        do
        {
            let test = try context.fetch(fetchRequest)

            if let objectUpdate = test.first as? NSManagedObject {
                for (key,value) in data {

                    objectUpdate.setValue(value, forKey: key)
                }
                do{
                    try context.save()
                    completion(true,"")
                }
                catch
                {
                    print(error)
                    completion(false,error.localizedDescription)
                }
            }
        }
        catch
        {
            print(error)
            completion(false,error.localizedDescription)
        }
    }

    /// This method deletes record
    ///
    /// - Parameters:
    ///   - data: (String,String)
    ///   - entityName: String
    ///   - completion: returns success , error msg
    func deleteData(_ data:(String,String),entityName:String,_ completion: @escaping(_ success: Bool, _ error: String) -> Void){

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "\(data.0) = %@", data.1)

        do
        {
            let test = try context.fetch(fetchRequest)

            if let objectToDelete = test.first as? NSManagedObject {
                context.delete(objectToDelete)

                do{
                    try context.save()
                    completion(true,"")
                }
                catch
                {
                    print(error)
                    completion(false,error.localizedDescription)
                }
            }
        }
        catch
        {
            print(error)
            completion(false,error.localizedDescription)
        }
    }
}

// MARK: - NSManagedObject
extension NSManagedObject {

    /// This method converts object to dictionary
    ///
    /// - Returns: [String:Any]
    func toDictionary() -> [String:Any] {
        let keys = Array(entity.attributesByName.keys)
        return dictionaryWithValues(forKeys:keys)
    }
}
