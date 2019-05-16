//
//  NetworkService.swift
//  20190514-EduardoSantiz-NYCSchools
//
//  Created by Eduardo Santiz on 5/14/19.
//  Copyright © 2019 EduardoSantiz. All rights reserved.
//

import Foundation

class NetworkService {
    let urlSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func download(fromURL url: String, completion: @escaping (Data?) -> Void) {
        dataTask?.cancel()
        
        guard let validURL = URL(string: url) else { completion(nil); return }
        
        urlSession.dataTask(with: validURL) { (data, respnse, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            if let jsonData = data {
                completion(jsonData)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
