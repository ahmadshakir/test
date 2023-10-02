//
//  DatabaseManager.swift
//  test
//
//  Created by AHMAD SHAKIR on 29/09/2023.
//

import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let realm = try! Realm()
    private let realmUser = try! Realm()
    
    private init() {}
    
    // MARK: - Work With users
    
    func add(user: User) {
        try! realm.write {
            realm.add(user)
        }
    }
    func delete(user: User) {
        try! realm.write {
            realm.delete(user)
        }
    }
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }

    func fetchusers() -> [User] {
        return Array(realm.objects(User.self))
    }

    func isAddeduser(_ user: User) -> Bool {
        let users = realm.objects(User.self).filter("id == \(user.id)")
        return !users.isEmpty
    }
    
    func fetchuser(_ user: User) -> User? {
        let user = realm.objects(User.self).filter("id == \(user.id)").first
        return user
    }
}
