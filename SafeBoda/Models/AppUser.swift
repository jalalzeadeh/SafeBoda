//
//  AppUser.swift
//  SafeBoda
//
//  Created by Jalal on 9/21/21.
//

import Foundation

struct AppUser: BaseModel {
    var id: Int = -1
    var name: String?
    var login: String?
    var email: String?
    var avatarUrl: String?
    var url: String?
    var company: String?
    var location: String?
    var bio: String?
    var blog: String?
    var nodeId: String?
    var siteAdmin: Bool? = false
    var followers: Int?
    var following: Int?
    var repos: Int?
    var created: String?
    var updated: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case login
        case email
        case avatarUrl = "avatar_url"
        case url
        case company
        case location
        case bio
        case blog
        case nodeId = "node_id"
        case siteAdmin = "site_admin"
        case followers
        case following
        case repos = "public_repos"
        case created = "created_at"
        case updated = "updated_at"
    }
    
    /// Equatable Protocol
    static func == (lhs: AppUser, rhs: AppUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    init() {
        self.id = -1
        name = ""
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
            name = try container.decodeIfPresent(String.self, forKey: .name)
            email = try container.decodeIfPresent(String.self, forKey: .email)
            login = try container.decodeIfPresent(String.self, forKey: .login)
            avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
            url = try container.decodeIfPresent(String.self, forKey: .url)
            company = try container.decodeIfPresent(String.self, forKey: .company)
            location = try container.decodeIfPresent(String.self, forKey: .location)
            bio = try container.decodeIfPresent(String.self, forKey: .bio)
            blog = try container.decodeIfPresent(String.self, forKey: .blog)
            nodeId = try container.decodeIfPresent(String.self, forKey: .nodeId)
            siteAdmin = try container.decodeIfPresent(Bool.self, forKey: .siteAdmin) ?? false
            following = try container.decodeIfPresent(Int.self, forKey: .following)
            followers = try container.decodeIfPresent(Int.self, forKey: .followers)
            repos = try container.decodeIfPresent(Int.self, forKey: .repos)
            created = try container.decodeIfPresent(String.self, forKey: .created)
            updated = try container.decodeIfPresent(String.self, forKey: .updated)
        } catch {
        }
    }
    
}
