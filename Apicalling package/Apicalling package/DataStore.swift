//
//  DataStore.swift
//  Apicalling package
//
//  Created by Droadmin on 21/08/23.
//

import Foundation
import SQLite3
import UIKit
class DbManger{
    var db:OpaquePointer?
  
    func openDatabase() -> OpaquePointer?{
        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Store.db")
        if sqlite3_open(fileUrl.path, &db) == SQLITE_OK{
            print("Database connection opened successfully \(fileUrl)")

            return db
        }else{
            return nil
        }
    }
    func createTable(){
        let query = "CREATE TABLE IF NOT EXISTS Store(Id INTEGER PRIMARY KEY, Animalname TEXT  UNIQUE, Image TEXT  UNIQUE);"
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Store table created")
            }else{
                print("Store table not created")
            }
            sqlite3_finalize(statement)
        }else{
            print("could not prepared")
        }
    }
    func insertData(name:String,image:String?){
       

        let insertData = "INSERT INTO Store(Animalname,Image)VALUES(?, ?);"
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertData, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (name as NSString).utf8String, -1, nil)
            if let imageData = image{
                
                sqlite3_bind_text(statement, 2, (imageData as NSString).utf8String, -1, nil)
            }else{
                sqlite3_bind_null(statement, 2)
            }
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Data inserted successfully.")
            } else {
                print("Failed to insert data into the database.")
            }
            
            let status = sqlite3_finalize(statement)
            print("Staus: \(status)")
        }else {
            print("Error preparing statement for insertion: \(String(cString: sqlite3_errmsg(db)))")
        }
    }
}
