//
//  DataStore.swift
//  SafeBoda
//
//  Created by Jalal on 9/23/21.
//


import SwiftKeychainWrapper
import SwiftyJSON

/** This class handle all data needed by view controllers and other app classes
 
 It deals with:
 - Userdefault for read/write cached data
 - Any other data sources e.g social provider, contacts manager, etc..
 ** Usage:**
 - to write something to cache; add a constant key and a computed property accessors (set,get) and use the according method  (save,load)
 */
class DataStore :NSObject {
    
    // MARK: Cache keys
    private let CACHE_KEY_TOKEN = "token"
    private let CACHE_KEY_USER = "user"
    private let CACHE_KEY_FOLLOWING = "following"
    private let CACHE_KEY_FOLLOWERS = "followers"
    
    // MARK: Temp data holders
    // keep reference to the written value in another private property just to prevent reading from cache each time you use this var
    private var _token: String?
    private var _me: AppUser?
    private var _following: [AppUser] = []
    private var _followers: [AppUser] = []
    
    /// User application token
    var token: String? {
        set {
            _token = newValue
            // save token in secure place keychain
            KeychainWrapper.standard.set(_token!, forKey: CACHE_KEY_TOKEN)
        }
        get {
            if (_token == nil) {
                // retrieve token from keychain
                _token = KeychainWrapper.standard.string(forKey: CACHE_KEY_TOKEN)
            }
            return _token
        }
    }
    
    /// user loggedin flag
    var isLoggedin: Bool {
        if let currentToken = token, !currentToken.isEmpty {
            if let currentUser = me, !(currentUser.id == -1) {
                return true
            }
        }
        return false
    }
    
    // MARK: Cached data
    
    /// User profile
    var me: AppUser? {
        set {
            _me = newValue
            do {
                // encode object
                let jsonData = try _me.encode()
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    saveStringWithKey(stringToStore: jsonString, key: CACHE_KEY_USER)
                }
            } catch {
                
            }
            
        }
        get {
            if (_me == nil) {
                do {
                    // Decode data to object
                    if let jsonData = loadStringForKey(key: CACHE_KEY_USER).data(using: .utf8) {
                        _me = try AppUser.decode(data: jsonData)
                    }
                } catch {
                    
                }
            }
            
            return _me
        }
    }
    
    var Folloing: [AppUser] {
        set {
            _following = newValue
            do {
                // encode object
                let jsonData = try _following.encode()
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    saveStringWithKey(stringToStore: jsonString, key: CACHE_KEY_FOLLOWING)
                }
            } catch {
                
            }
            
        }
        get {
            if (_following.isEmpty) {
                do {
                    // Decode data to object
                    if let jsonData = loadStringForKey(key: CACHE_KEY_FOLLOWING).data(using: .utf8) {
                        _following = try [AppUser].decode(data: jsonData)
                    }
                } catch {
                    
                }
            }
            
            return _following
        }
    }
    
    
    var Followers: [AppUser] {
        set {
            _followers = newValue
            do {
                // encode object
                let jsonData = try _followers.encode()
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    saveStringWithKey(stringToStore: jsonString, key: CACHE_KEY_FOLLOWERS)
                }
            } catch {
                
            }
            
        }
        get {
            if (_followers.isEmpty) {
                do {
                    // Decode data to object
                    if let jsonData = loadStringForKey(key: CACHE_KEY_FOLLOWERS).data(using: .utf8) {
                        _followers = try [AppUser].decode(data: jsonData)
                    }
                } catch {
                    
                }
            }
            
            return _followers
        }
    }
    
    // MARK: Singelton
    public static var shared: DataStore = DataStore()
    
    private override init(){
        super.init()
        //logout()
    }
    
    // MARK: Cache Utils
    /// Save base model sobject with key
    public func saveBaseModelObject<T:BaseModel>(object:T?, withKey key:String)
    {
        do{
            UserDefaults.standard.set(try object.encode(), forKey: key)
            UserDefaults.standard.synchronize()
        } catch {
            
        }
        
    }
    
    /// Load base model object for key
    public func loadBaseModelObjectForKey<T:BaseModel>(object:T?, withKey key:String) -> T?
    {
        UserDefaults.standard.synchronize()
        if UserDefaults.standard.object(forKey: key) != nil {
            do {
                let data = UserDefaults.standard.value(forKey: key)
                return try T.decode(data: data as! Data)
            } catch {

            }
        }
        return nil
    }
    
    /// Load string for key
    public func loadStringForKey(key:String) -> String {
        let storedString = UserDefaults.standard.object(forKey: key) as? String ?? ""
        return storedString;
    }
    
    /// Save string with key
    public func saveStringWithKey(stringToStore: String, key: String) {
        UserDefaults.standard.set(stringToStore, forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    /// remove string with key
    public func removeStringWithKey(key: String) {
        UserDefaults.standard.removeObject(forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    /// Load int for key
    private func loadIntForKey(key:String) -> Int {
        let storedInt = UserDefaults.standard.object(forKey: key) as? Int ?? 0
        return storedInt;
    }
    
    /// Save int with key
    private func saveIntWithKey(intToStore: Int, key: String) {
        UserDefaults.standard.set(intToStore, forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    /// Load bool for key
    private func loadBoolForKey(key: String) -> Bool {
        let storedBool = UserDefaults.standard.object(forKey: key) as? Bool ?? false
        return storedBool
    }
    
    /// Save bool with key
    private func saveBoolWithKey(boolToStore: Bool, key: String){
        UserDefaults.standard.set(boolToStore, forKey: key);
        UserDefaults.standard.synchronize()
    }
    
    /// Load object for key
    public func loadObjectForKey(key:String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    /// Save object with key
    public func saveObjectWithKey(object: Any, key: String){
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize();
    }
    
    /// Clear cache
    public func clearCache() {
        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
        }
    }
    
    /// Logout
    public func logout() {
        clearCache()
        me = nil
        _token = nil
        Folloing = []
        Followers = []
        // remove tokens from keychain
        KeychainWrapper.standard.removeObject(forKey: CACHE_KEY_TOKEN)
    }
}

