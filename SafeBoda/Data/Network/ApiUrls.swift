//
//  ApiUrls.swift
//  SafeBoda
//
//  Created by Jalal on 9/22/21.
//

import Foundation
import Foundation

struct URLs {
    //https://api.github.com/users/jalalzeadeh/following
    static let MainURL = "https://api.github.com"
    static let UsersUrl = MainURL + "/users/"
    
    static func getSearchUrl(_ name: String) -> String {
        return "\(URLs.UsersUrl)\(name)"
    }
    
    static func getFollowingUrl(_ name: String, page: Int) -> String {
        return "\(URLs.UsersUrl)\(name)/following?per_page=10&page=\(page)"
    }
    
    static func getFollowersUrl(_ name: String, page: Int) -> String {
        return "\(URLs.UsersUrl)\(name)/followers?per_page=10&page=\(page)"
    }
    
}
