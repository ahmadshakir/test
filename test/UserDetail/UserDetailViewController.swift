//
//  UserDetailViewController.swift
//  test
//
//  Created by AHMAD SHAKIR on 28/09/2023.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var viewModel: UserDetailViewModel?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.reloadData()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.needPop),
            name: NSNotification.Name(rawValue: "needPop"),
            object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @objc func needPop() {
        navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func buttonTapped(_ sender: Any) {
        if let viewmodel = viewModel,let login=viewmodel.login{ //else { return }
            let user = User(
                login: login, id:viewmodel.id ?? 0,
                nodeID: viewmodel.nodeID, avatarURL: viewmodel.avatarURL,
                type: viewmodel.type,
                siteAdmin: viewmodel.siteAdmin)
            if DatabaseManager.shared.isAddeduser(user){
                DatabaseManager.shared.delete(user: user)
                navigationController?.popViewController(animated: true)
            }
            else{
                DatabaseManager.shared.add(user: user)
            }
        }
    }
    
}
extension UserDetailViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard (viewModel != nil) else { return 0}
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailCell") as! UserDetailCell
        let viewmodel = UserDetailCellViewModel(id: viewModel?.id, login: viewModel?.login, avatarURL: viewModel?.avatarURL, nodeID: viewModel?.nodeID, type: viewModel?.type, siteAdmin: viewModel?.siteAdmin)
        cell.setup(viewModel: viewmodel)
        return cell
    }
    
    
    
}
