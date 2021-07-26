//
//  ViewModel.swift
//  CatSwipe
//
//  Created by Theo on 26/7/21.
//

import Foundation
import Combine

final class ViewModel {
    // MARK: Properties
    var subscriptions = Set<AnyCancellable>()
    let cat = CurrentValueSubject<Cat?, Never>(nil)
    
    // MARK: Inits
    init() {
        fetchCatImage()
    }
    
    // MARK: Fetch
    func fetchCatImage() {
        URLSession.shared
            .dataTaskPublisher(for: .randomImage)?
            .map(\.data)
            .decode(type: [Cat].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in },
                  receiveValue: { [weak self] cats in
                    guard let self = self else { return }
                    self.cat.send(cats.first)
                  })
            .store(in: &subscriptions)
    }
}
