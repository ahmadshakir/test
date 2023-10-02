//
//  FavouriteuserListViewController.swift
//  test
//
//  Created by AHMAD SHAKIR on 29/09/2023.
//

import UIKit
import RxSwift

class FavouriteuserListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: FavouriteUserListViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = FavouriteUserListViewModel()
        setupListeners()
        viewModel?.fetchData()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.favouriteDelete),
            name: NSNotification.Name(rawValue: "favouriteDelete"),
            object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.fetchData()
    }
    
    private func setupListeners() {

        viewModel?.items.asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    @objc func favouriteDelete() {
        viewModel?.fetchData()
    }

}

extension FavouriteuserListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.items.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel?.items.value.count ?? 0 > indexPath.row else {return UITableViewCell()}
        let user = viewModel?.items.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteUserListCell") as! FavouriteUserListCell
        let viewModel = FavouriteUserListCellViewModel(
            id: user?.id,
            login: user?.login,
            avatarURL: user?.avatarURL,
            nodeID: user?.nodeID,
            type: user?.type,
            siteAdmin: user?.siteAdmin)
        cell.setup(viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel?.items.value.count ?? 0 > indexPath.row else {return}
        let user = viewModel?.items.value[indexPath.row]
        let viewModel = UserDetailViewModel(id: user?.id,login: user?.login,avatarURL: user?.avatarURL,nodeID: user?.nodeID,type:user?.type,siteAdmin: user?.siteAdmin)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        destinationVC.viewModel = viewModel
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    
}
