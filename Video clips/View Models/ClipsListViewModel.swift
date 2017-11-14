//
//  ClipsListViewModel.swift
//  Video clips
//
//  Created by Alexander Slobodjanjuk on 11.11.2017.
//  Copyright © 2017 Alexander Slobodjanjuk. All rights reserved.
//

import Foundation

struct ClipsListCoordinatorModel {
    
    private(set)var coordinatorDidUpdateClipsListBlock: (_ clipsList: [Clip]?, _ error: Error?) ->()
    
    init(coordinatorDidUpdateClipsListBlock: @escaping (_ clipsList: [Clip]?, _ error: Error?) ->()) {
        self.coordinatorDidUpdateClipsListBlock = coordinatorDidUpdateClipsListBlock
    }
    
    func loadClipsList(page: Int){
        guard let url = URL(string: Constants.loadPage) else { return }
        
        var request = URLRequest.init(url: url)
        request.httpMethod = Constants.get
        
        URLSession.shared.dataTask(with: request) { (data, responce, error) in
            
            guard error == nil else {
                print(error!)
                self.coordinatorDidUpdateClipsListBlock(nil, error)
                return
            }
            
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            do {
                let locList = try JSONDecoder().decode(DataResponce.self, from: data)
                self.coordinatorDidUpdateClipsListBlock((locList.data?.clips)!, error)
            } catch let error {
                print(error)
            }
            
            }.resume()
    }
}

