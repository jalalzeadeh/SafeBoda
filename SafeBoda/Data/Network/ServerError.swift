//
//  ServerError.swift
//  SafeBoda
//
//  Created by Jalal on 9/22/21.
//


import SwiftyJSON

/**
 Server error represents custome errors types from back end
 */
struct ServerError: Error {

    public var errorName: String?
    public var status: Int?
    public var code: Int!

    public var type: ErrorType {
        get {
            return ErrorType(rawValue: code) ?? .unknown
        }
    }

    /// Server errors codes meaning according to backend
    enum ErrorType: Int {

        // in app errors
        case connection = -100
        case unknown = -101
        case timout = -102
        // server errors
        
        /// Handle generic error messages
        public var errorMessage: String {
            switch (self) {
            case .connection:
                return "NO_DATA_CONNECTION_MESSAGE"
            case .unknown:
                return "ERROR_UNKNOWN_MESSAGE"
            case .timout:
                return "ERROR_TIMEOUT_MESSAGE"
           
            }
        }
        
        /// Returns the title associated with the error
        var errorTitle: String {
            switch self {
            case .connection:
                return "NO_DATA_CONNECTION_TITLE"
            case .unknown:
                return "ERROR_UNKNOWN_TITLE"
            case .timout:
                return "ERROR_TIMEOUT_TITLE"
            
            }
        }
        
    }

    /// Connection error
    public static var connectionError: ServerError {
        get {
            var error = ServerError()
            error.code = ErrorType.connection.rawValue
            return error
        }
    }

    /// Unknow error
    public static var unknownError: ServerError {
        get {
            var error = ServerError()
            error.code = ErrorType.unknown.rawValue
            return error
        }
    }
    
    /// Timeout error
    public static var timoutError: ServerError {
        get {
            var error = ServerError()
            error.code = ErrorType.timout.rawValue
            return error
        }
    }
    

    // MARK: initializer
    public init() {
    }

    /**
     Initates the instance based on the JSON that was passed.
     - parameter json: JSON object from SwiftyJSON.
     - returns: An initalized instance of the class.
     */
    public init?(json: JSON) {
        guard let errorCode = json["code"].int else {
            return nil
        }
        code = errorCode
        if let errorString = json["message"].string{ errorName = errorString}
        if let statusCode = json["statusCode"].int{ status = statusCode}
    }
}
