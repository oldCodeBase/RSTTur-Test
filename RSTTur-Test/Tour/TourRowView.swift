//
//  TourRowView.swift
//  RSTTur-Test
//
//  Created by Ibragim Akaev on 04/08/2021.
//

import SwiftUI

struct TourRowView: View {
    @ObservedObject var tour: TourRowModel
    
    var body: some View {
        HStack {
            image
            VStack(alignment: .leading) {
                Text(tour.name)
                    .font(.headline)
                Text(tour.description)
                    .font(.subheadline)
                Spacer()
            }
            .padding(.all, 10.0)
            .frame(height: 120, alignment: .center)
        }
    }
    
    private var image: some View {
        Group {
            if let image = tour.tourImage {
                Image(uiImage: image)
                    .resizable()
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .onAppear { tour.fetchImage() }
            }
        }
        .frame(width: 140, height: 100)
        .cornerRadius(10)
        .padding(.all, 10.0)
    }
}
