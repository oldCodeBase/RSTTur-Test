//
//  CategoryRowModel.swift
//  RSTTur-Test
//
//  Created by Ibragim Akaev on 04/08/2021.
//

import SwiftUI

final class CategoryRowModel: ObservableObject, Identifiable {
    
    let category: Category
    
    var name: String { category.name }
    var type: TypeEnum { category.type }
    var color: Colour { category.colour }
    var count: Int { category.count }
    
    
    init(category: Category) {
        self.category = category
    }
}
