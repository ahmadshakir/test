//
//  userListViewModel.swift
//  test
//
//  Created by AHMAD SHAKIR on 28/09/2023.
//

import Foundation
import RxSwift
import RxCocoa

class UserListViewModel {
    
    var items: BehaviorRelay = BehaviorRelay<[User]>(value: [])
    var lastLogin = BehaviorRelay<String>(value: "")
    
    private let disposeBag = DisposeBag()
    
    func fetchData(){
        let urlString = "https://api.github.com/users?since=0"
        var request = URLRequest(url: URL(string:urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            do {
                let json = try JSONDecoder().decode(Users.self, from: data)
                self.items.accept(json)
            }
            catch{

            }
        }
        
        task.resume()
    }
}
