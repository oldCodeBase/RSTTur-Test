//
//  CategoryViewModel.swift
//  RSTTur-Test
//
//  Created by Ibragim Akaev on 04/08/2021.
//

import SwiftUI
import Combine

final class CategoryViewModel: ObservableObject {
    
    private let api = APIService()

    @Published var isLoading = false
    @Published var categories: [CategoryRowModel] = []
    @Published var tours: [TourRowModel] = []
    @Published var error: IdentifiableError<HTTPError>?
    
    struct IdentifiableError<E: Error>: Identifiable {
        let id = UUID()
        let error: E
    }
    
    init() {
        fetch()
    }
    
    func fetch() {
        error = nil
        let responseData = api.fetch(decoding: Rsttur.self)
            .handleEvents(
                receiveSubscription: { [unowned self] _ in
                    isLoading = true
                },
                receiveCompletion: { [unowned self] _ in
                    isLoading = false
                },
                receiveCancel: { [unowned self] in
                    isLoading = false
                })
            .catch { [unowned self] error -> Just<Rsttur> in
                self.error = IdentifiableError(error: error )
                return Just(
                    Rsttur(data: DataClass(
                            geo: Geo(lat: 0.02, lon: 9.2),
                            categories: [Category(name: "", type: .child, colour: .danger10, count: 4)],
                            objects: [Object(name: "", description: "", image: "", type: .child, lat: 0.3, lon: 0.4)])
                    )
                )
            }
            .share()
        
        responseData
            .flatMap { $0.data.categories.publisher }
            .map { CategoryRowModel(category: $0) }
            .collect()
            .assign(to: &$categories)
        
        responseData
            .flatMap { $0.data.objects.publisher }
            .map { TourRowModel(tour: $0) }
            .collect()
            .assign(to: &$tours)
    }
}
