//
//  ApiEndPoints.swift
//  SafeBoda
//
//  Created by Jalal on 9/22/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiManager : NSObject {
    
    static let apiPageCount: Int = 10
    //MARK: Shared Instance
    static let shared: ApiManager = ApiManager()
    
    private override init(){
        super.init()
        
    }
    
    private func parseResponse(responseObject: AFDataResponse<Any>) -> ServerError? {
        if responseObject.error != nil {
            // timeout case
            if let code = responseObject.response?.statusCode, code >= 500 {
                return ServerError.timoutError
            } else if let code = responseObject.response?.statusCode, code >= 400 {// server error case
                return ServerError.unknownError
            } else {// connection case
                return ServerError.connectionError
            }
        } else if responseObject.value != nil {// success
            let jsonResponse = JSON(responseObject.value!)
            // timeout case
            if let code = responseObject.response?.statusCode, code >= 500 {
                return ServerError(json: jsonResponse) ?? ServerError.timoutError
            } else if let code = responseObject.response?.statusCode, code >= 400 {// server error case
                let serverError = ServerError(json: jsonResponse) ?? ServerError.unknownError
                return serverError
            }
        }
        return nil
    }
    
    
    func GetPersonalInfo(name: String = "", completionBlock: @escaping (_ success: Bool , _ error: ServerError?) -> Void) {
        let urlString = URLs.getSearchUrl(name)
        guard let url = URL(string: urlString) else { return }
//        let params: Parameters = [:]
        var request        = URLRequest(url: url)
        request.httpMethod = "GET"
        AF.request(request).responseJSON{ (response) in
            if let error = self.parseResponse(responseObject: response) {
                completionBlock(false, error)
            } else {// success case
                if let result = response.value {
                    do {
                        // parse user
                        let jsonResponse = JSON(result)
                        let jsonData = try JSON(jsonResponse).rawData()
                        let user = try AppUser.decode(data: jsonData)
                        DataStore.shared.me = user
                        completionBlock(true, nil)
                    } catch {
                        completionBlock(false, ServerError.connectionError)
                    }
                }
            }

        }
        
    }
    

    func GetUserFollowing(name: String = "", page: Int = 1, completionBlock: @escaping (_ success: Bool , _ error: ServerError?, _ list: [AppUser]) -> Void) {
        let urlString = URLs.getFollowingUrl(name, page: page)
        guard let url = URL(string: urlString) else { return }
        var request        = URLRequest(url: url)
        request.httpMethod = "GET"
        AF.request(request).responseJSON{ (response) in
            if let error = self.parseResponse(responseObject: response) {
                completionBlock(false, error, [])
            } else {// success case
                if let result = response.value {
                    do {
                        // parse users
                        let jsonResponse = JSON(result)
                        let jsonData = try JSON(jsonResponse).rawData()
                        let users = try [AppUser].decode(data: jsonData)
                        completionBlock(true, nil, users)
                    } catch {
                        completionBlock(false, ServerError.connectionError, [])
                    }
                }
            }

        }
        
    }
    
    func GetUserFollowers(name: String = "", page: Int = 1, completionBlock: @escaping (_ success: Bool , _ error: ServerError?, _ list: [AppUser]) -> Void) {
        let urlString = URLs.getFollowersUrl(name, page: page)
        guard let url = URL(string: urlString) else { return }
        var request        = URLRequest(url: url)
        request.httpMethod = "GET"
        AF.request(request).responseJSON{ (response) in
            if let error = self.parseResponse(responseObject: response) {
                completionBlock(false, error, [])
            } else {// success case
                if let result = response.value {
                    do {
                        // parse users
                        let jsonResponse = JSON(result)
                        let jsonData = try JSON(jsonResponse).rawData()
                        let users = try [AppUser].decode(data: jsonData)
                        completionBlock(true, nil, users)
                    } catch {
                        completionBlock(false, ServerError.connectionError, [])
                    }
                }
            }

        }
    }
    
   

}
