//
//  URLSessionExtension.swift
//  CatSwipe
//
//  Created by Theo on 26/7/21.
//

import Foundation
import Combine

extension URLSession {
    func dataTaskPublisher(for endpoint: Endpoint) -> URLSession.DataTaskPublisher? {
        guard let url = endpoint.url else { return nil }
        return dataTaskPublisher(for: URLRequest(url: url))
    }
}
