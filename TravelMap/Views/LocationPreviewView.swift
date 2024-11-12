//
//  LocationPreviewView.swift
//  TravelMap
//
//  Created by Sardorbek Saydamatov on 06/11/24.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    
    let location: Location
    var body: some View {			
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection	
                titleSection
            }
            
            VStack {
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ZStack {
//        Color.green
//            .ignoresSafeArea()
        LocationPreviewView(location: LocationsDataService.locations.first!)
    }
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack {
            if let imageNames = location.imageNames.first {
                Image(imageNames)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
        }
        .padding(6)
        .background(.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            viewModel.sheetLocation = location
        } label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            viewModel.nextButtonTapped()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
                .foregroundStyle(Color.primary)
        }
        .buttonStyle(.bordered)
    }
}
