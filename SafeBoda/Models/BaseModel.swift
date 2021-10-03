//
//  BaseModel.swift
//  SafeBoda
//
//  Created by Jalal on 9/21/21.
//

import Foundation


public protocol BaseModel: Hashable, Codable {
    var id: Int {get set}
}

public extension BaseModel {
    
    /**
     Check if a BaseModel is exist in the array
     - parameter arr: the BaseModel array
     - returns: true/false for existing in
     */
    func isExistIn<T:BaseModel>(arr:[T]?) -> Bool {
        guard let array = arr else {
            return false
        }
        if array.contains(where: { $0.id == self.id }) {
            return true
        } else {
            return false
        }
    }
    
    /**
     Find the BaseModel object by ID inside array
     - parameter arr: the BaseModel array
     - parameter id: the BaseModel id
     - returns: BaseModel object
     */
    func findObjectById<T:BaseModel>(arr:[T] , id: Int) -> T? {
        let object = arr.filter{$0.id == id}.first
        return object
    }
    
    /**
     Remove the BaseModel object by ID from array
     - parameter arr: the BaseModel array
     - parameter id: the BaseModel id
     - returns: BaseModel array
     */
    func removeObjectById<T:BaseModel>(arr:[T] , id: Int) -> [T] {
        var result = arr
        if let index = arr.firstIndex(where: {$0.id == id}) {
            result.remove(at: index)
        }
        return result
    }
}
