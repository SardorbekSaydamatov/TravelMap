//
//  LocationsListView.swift
//  TravelMap
//
//  Created by Sardorbek Saydamatov on 06/11/24.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject private var viewModel: LocationsViewModel
    var body: some View {
        List {
            ForEach(viewModel.locations) { location in
                Button(action: {
                    viewModel.showNextLocation(location: location)
                }, label: {
                    listRowView(location: location)
                })
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .scrollIndicators(.hidden)
        .listStyle(.plain)
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel())
}

extension LocationsListView {
    @ViewBuilder
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
