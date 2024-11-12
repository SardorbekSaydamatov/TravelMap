//
//  TravelMapApp.swift
//  TravelMap
//
//  Created by Sardorbek Saydamatov on 06/11/24.
//

import SwiftUI

@main
struct TravelMapApp: App {
    
    @StateObject private var viewModel = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(viewModel)
        }
    }
}
