//
//  NetworkService.swift
//  StoriTest
//
//  Created by Cristian Hernandez Garcia on 04/03/24.
//

import Foundation

protocol NetworkService {
    func fetchData(from url: URL, headers: [String: String]?, completion: @escaping (Result<Data, Error>) -> Void)
}

extension URLSession: NetworkService {
    func fetchData(from url: URL, headers: [String: String]? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        let task = self.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let emptyDataError = NSError(domain: "EmptyDataErrorDomain", code: -1, userInfo: nil)
                completion(.failure(emptyDataError))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }
}
