//
//  IceCreamViewModel.swift
//  IceCreamParlorChallenge
//
//  Created by Cris on 29/03/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation

class IceCreamViewModel {
    let networkAPI = IceCreamNetworkService()
    
    func loadIceCreams(completion: @escaping ([IceCreamModel]) -> ()) {
        networkAPI.fetchIceCreamResponse(classType: [IceCreamModel].self) { (result, error) in
            if let iceCreamArray = result {
                completion(iceCreamArray)
            } else {
                completion([IceCreamModel]())
            }
        }
    }
}
