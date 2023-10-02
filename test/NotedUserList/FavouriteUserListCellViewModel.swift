//
//  FavouriteUserListCellViewModel.swift
//  test
//
//  Created by AHMAD SHAKIR on 29/09/2023.
//

import Foundation

class FavouriteUserListCellViewModel {
    let id: Int?
    let login: String?
    let avatarURL: String?
    let nodeID: String?
    let type: String?
    let siteAdmin: Bool?

    init(id: Int?,login: String?, avatarURL: String?, nodeID: String?, type: String?, siteAdmin: Bool?) {
        self.id = id
        self.login = login
        self.avatarURL = avatarURL
        self.nodeID = nodeID
        self.type = type
        self.siteAdmin = siteAdmin
    }
}
