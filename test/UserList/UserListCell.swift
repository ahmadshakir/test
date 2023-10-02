//
//  UserListCell.swift
//  test
//
//  Created by AHMAD SHAKIR on 28/09/2023.
//

import UIKit
import Kingfisher
import Unrealm
import RealmSwift

class UserListCell: UITableViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var secondlabel: UILabel!
    @IBOutlet weak var thirdlabel: UILabel!
    @IBOutlet weak var noteButton: UIButton!
    
    private var viewModel: UserListCellViewModel?
    
    func setup(viewModel:UserListCellViewModel){
        self.viewModel = viewModel
        poster.kf.setImage(with: URL(string:viewModel.avatarURL ?? ""),placeholder: UIImage(systemName: "photo"))
        label.text = viewModel.login
        secondlabel.text = viewModel.type
        thirdlabel.text = viewModel.nodeID?.description
        guard let constant = self.viewModel else { return }
        let user = User(login: constant.login ?? "", id:constant.id ?? 0,
                        nodeID: constant.nodeID, avatarURL: constant.avatarURL,
                          type: constant.type,
                          siteAdmin: constant.siteAdmin)
        noteButton.isHidden = !DatabaseManager.shared.isAddeduser(user)
    }
}
