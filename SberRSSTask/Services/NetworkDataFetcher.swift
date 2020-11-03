//
//  NetworkDataFetcher.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import Foundation

protocol DataFetcherProtocol {
    func fetchNewsData(sourceURL: String, completion: @escaping (Data?) -> ())
}

class NetworkDataFetcher {
    
    let networking: Networking

    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchNewsData(sourceURL: String, completion: @escaping (Data?) -> ()) {
        networking.getNewsData(sourceURL: sourceURL) { (data, error) in
            
            if let error = error {
                print("Error recevied requesting data:  \(error.localizedDescription)")
                completion(nil)
            }
            
            completion(data)
        }
    }
}
