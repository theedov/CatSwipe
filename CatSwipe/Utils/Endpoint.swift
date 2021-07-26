//
//  Endpoint.swift
//  CatSwipe
//
//  Created by Theo on 26/7/21.
//

import Foundation

enum Endpoint: String {
    case randomImage
    
    var url: URL? {
        switch self {
        case .randomImage: return constructEndpointURL(domain: "api.thecatapi.com", path: "/v1/images/search", parameters: nil)
        }
    }
    
    private func constructEndpointURL(scheme: String = "https", domain: String, path: String, parameters: [String: Any?]?) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = domain
        components.path = path
        components.percentEncodedQueryItems = parameters?
            .compactMapValues({ $0 })
            .map({ URLQueryItem(name: $0.key, value: String(describing: $0.value )) })
        
        return components.url
    }
}
