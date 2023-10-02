//
//  FuserListViewModel.swift
//  test
//
//  Created by AHMAD SHAKIR on 29/09/2023.
//

import Foundation
import RxSwift
import RxCocoa

class FavouriteUserListViewModel {
    
    var items: BehaviorRelay = BehaviorRelay<[FavouriteUserListCellViewModel]>(value: [])
    private let disposeBag = DisposeBag()
    
    func fetchData(){
        items.accept(createItems(from:DatabaseManager.shared.fetchusers()))
    }
}

extension FavouriteUserListViewModel {
    private func createItems(from users: [User]) -> [FavouriteUserListCellViewModel] {
        var favouritusers: [FavouriteUserListCellViewModel] = []
        for user in users {
            let item = FavouriteUserListCellViewModel(
                id: user.id,
                login: user.login,
                avatarURL: user.avatarURL,
                nodeID: user.nodeID,
                type: user.type,
                siteAdmin: user.siteAdmin
            )
            favouritusers.append(item)
            
        }
        return favouritusers
    }
}
