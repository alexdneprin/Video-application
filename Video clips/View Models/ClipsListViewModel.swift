//
//  ClipsListViewModel.swift
//  Video clips
//
//  Created by Alexander Slobodjanjuk on 11.11.2017.
//  Copyright © 2017 Alexander Slobodjanjuk. All rights reserved.
//

import Foundation

class ClipsListViewModel {
    
    private init() { }
    
    static let shared: ClipsListViewModel = {
        let instance = ClipsListViewModel()
        return instance
    }()
    
    typealias CompletionBlock = ([Clip]?, _ error: Error?) -> Void
    
    func viewModel(page: Int, completionBlock: @escaping CompletionBlock){
        guard let url = URL(string: Constants.loadPage) else { return }
        
        var request = URLRequest.init(url: url)
        request.httpMethod = Constants.get
        
        URLSession.shared.dataTask(with: request) { (data, responce, error) in
            
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            do {
                let locList = try JSONDecoder().decode(DataResponce.self, from: data)
                completionBlock((locList.data?.clips)!, error)
                
            } catch let error {
                print(error)
            }
            
            }.resume()
    }
}

protocol ViewModel {
    

}

