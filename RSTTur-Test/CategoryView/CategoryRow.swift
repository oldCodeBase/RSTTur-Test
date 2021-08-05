//
//  CategoryRow.swift
//  RSTTur-Test
//
//  Created by Ibragim Akaev on 04/08/2021.
//

import SwiftUI

struct CategoryRow: View {
    @ObservedObject var category: CategoryRowModel
    var body: some View {
        HStack {
            Text(category.name)
            Spacer()
            ZStack {
                Circle()
                    .foregroundColor(category.color.hexColor)
                    .frame(width: 30, height: 30, alignment: .center)
                Text("\(category.count)")
            }
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(category: CategoryRowModel(category: Category(name: "Интересные места", type: .food, colour: .cyan10, count: 15)))
    }
}


