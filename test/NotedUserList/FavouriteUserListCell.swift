//
//  FuserListCell.swift
//  test
//
//  Created by AHMAD SHAKIR on 29/09/2023.
//

import UIKit

class FavouriteUserListCell: UITableViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var secondlabel: UILabel!
    @IBOutlet weak var thirdlabel: UILabel!
    @IBOutlet weak var noteButton: UIButton!
    
    private var viewModel: FavouriteUserListCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(viewModel:FavouriteUserListCellViewModel){
        self.viewModel = viewModel
        poster.kf.setImage(with: URL(string:viewModel.avatarURL ?? ""),placeholder: UIImage(systemName: "photo"))
        label.text = viewModel.login
        secondlabel.text = viewModel.type
        thirdlabel.text = viewModel.nodeID?.description
        guard let constant = self.viewModel else { return }
        let user = User(login: constant.login ?? "", id:constant.id ?? 0, nodeID: constant.nodeID, avatarURL: constant.avatarURL, type: constant.type, siteAdmin: constant.siteAdmin)
        noteButton.isHidden = false
    }
}
