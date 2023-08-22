//
//  NetworkManager.swift
//  ContactList
//
//  Created by Lera Savchenko on 22.08.23.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private let urlParams = [
        "results": "\(15)",
    ]
    
    private init() {}
    
    func fetchUsers(_ completion: @escaping(Result<[User], AFError>) -> Void) {
        AF.request(URLConstants.randomUserAPI.rawValue, parameters: urlParams)
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let users = User.getRandomUsers(from: value)
                    completion(.success(users))
                case .failure(let error):
                    print(error)
                }
            }
    }
}


