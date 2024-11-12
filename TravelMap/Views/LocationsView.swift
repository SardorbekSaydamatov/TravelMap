//
//  LocationsView.swift
//  TravelMap
//
//  Created by Sardorbek Saydamatov on 06/11/24.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @EnvironmentObject private var viewModel: LocationsViewModel
    let maxWidthForIpad: CGFloat = 700
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()

            
            VStack(spacing: 0) {
                header
                .padding()
                .frame(maxWidth: maxWidthForIpad)
                
                Spacer()
                
                locationsPreviewStack
            }
        }
        .sheet(item: $viewModel.sheetLocation) { location in
            LocationDetailView(location: location)
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}


extension LocationsView {
    private var header: some View {
        VStack {
            
            Button {
                viewModel.toggleLocationsList()
            } label: {
                Text(viewModel.mapLocation.name + ", " + viewModel.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(Color.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: viewModel.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "chevron.down")
                            .font(.headline)
                            .foregroundStyle(Color.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: viewModel.showLocationsList ? 180 : 0))
                    }
            }

            
            if viewModel.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations, annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMarkerView()
                    .scaleEffect(viewModel.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        viewModel.showNextLocation(location: location)
                    }
            }
        })
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(viewModel.locations) { location in
                if viewModel.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}
