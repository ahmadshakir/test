//
//  File.swift
//  test
//
//  Created by AHMAD SHAKIR on 30/09/2023.
//

import Foundation
import Unrealm

// MARK: - User
struct User: Codable,Realmable {
    var login: String? = ""
    var id: Int = 0
    var nodeID: String? = ""
    var avatarURL: String? = ""
    var type: String? = ""
    var siteAdmin: Bool? = false
    var note: String?

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case type = "type"
        case siteAdmin = "site_admin"
    }
    
    static func primaryKey () -> String? {
        return "id"
    }
    
}

typealias Users = [User]
