//
//  CategoryList.swift
//  RSTTur-Test
//
//  Created by Ibragim Akaev on 04/08/2021.
//

import SwiftUI

struct CategoryList: View {
    @ObservedObject var viewModel = CategoryViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    categories
                }
            }
            .alert(item: $viewModel.error, content: { e -> Alert in
                Alert(
                    title: Text("Unable to load Data"),
                    message: Text(e.error.description),
                    primaryButton: .default(Text("Retry"), action: {
                        self.viewModel.fetch()
                    }),
                    secondaryButton: .cancel()
                )
            })
            .navigationTitle("Категории")
        }
    }
    
    private var categories: some View {
        List(viewModel.categories) { category in
            NavigationLink(
                destination: ToursList(model: viewModel.tours.filter { $0.type == category.type }),
                label: {
                    CategoryRow(category: category)
                })
        }
    }
}

