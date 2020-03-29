//
//  IceCreamNetworkService.swift
//  IceCreamParlorChallenge
//
//  Created by Cris on 29/03/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation
import os.log

enum IceCreamNetworkServiceError: Error {
    case generalError
    case invalidURL
    case invalidData
}

struct IceCreamNetworkService {

    private struct Constants {
        static let BaseURL = "http://gl-endpoint.herokuapp.com/products"
    }
    
    func fetchIceCreamResponse<T: Decodable>(classType: T.Type, completion: @escaping (T?, IceCreamNetworkServiceError?) -> ()) {
        guard let URL = URL(string: Constants.BaseURL) else {
            completion(nil, IceCreamNetworkServiceError.invalidURL)
            os_log("error: trying to get URL")
            return
        }
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            guard let resultData = data else {
                completion(nil, IceCreamNetworkServiceError.generalError)
                os_log("error: trying to get Data")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: resultData)
                completion(result, nil)
            } catch {
                os_log("error: trying to decode Data")
                completion(nil, IceCreamNetworkServiceError.invalidData)
            }
        }.resume()
    }
}
