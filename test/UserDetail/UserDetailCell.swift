//
//  UserDetailCell.swift
//  test
//
//  Created by AHMAD SHAKIR on 28/09/2023.
//

import UIKit
import Kingfisher

class UserDetailCell: UITableViewCell {
    
    private var viewModel: UserDetailCellViewModel?
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var secondlabel: UILabel!
    @IBOutlet weak var thirdlabel: UILabel!
    @IBOutlet weak var fourth: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var userExist:Bool?=false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(viewModel:UserDetailCellViewModel){
        self.viewModel = viewModel
        poster.kf.setImage(with:URL(string:viewModel.avatarURL ?? ""),placeholder: UIImage(systemName: "photo"))
        label.text = viewModel.login
        secondlabel.text = viewModel.type
        thirdlabel.text = viewModel.nodeID?.description
        fourth.text = viewModel.siteAdmin?.description
        let user = User(login: viewModel.login ?? "", id:viewModel.id ?? 0,
                        nodeID: viewModel.nodeID, avatarURL: viewModel.avatarURL,
                          type: viewModel.type,
                          siteAdmin: viewModel.siteAdmin)
        if let user = DatabaseManager.shared.fetchuser(user){
            userExist=true
            textField.text=user.note
        }
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {
        
        if let constant = viewModel{
            let user = User(login: constant.login, id:constant.id ?? 0, nodeID: constant.nodeID, avatarURL: constant.avatarURL, type: constant.type, siteAdmin: constant.siteAdmin,note: textField.text)
            if DatabaseManager.shared.isAddeduser(user) && textField.text=="" {
                DatabaseManager.shared.delete(user: user)
            }
            else{
                if userExist ?? false{DatabaseManager.shared.delete(user: user)}
                DatabaseManager.shared.add(user: user)
            }
        }
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "needPop"), object: nil)
    
    }
    
}
