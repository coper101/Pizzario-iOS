//
//  PizzarioApp.swift
//  Sample Apps
//
//  Created by Wind Versi on 25/4/22.
//

import SwiftUI
import MapKit

struct PizzarioApp: View {
    // MARK: - Properties
    @State var sheetState: SheetState = .collapsed
    @State var coordinateRegion = mainCoordinate

    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            
            let navBarHeight: CGFloat = 50
            let height = geometry.size.height - (navBarHeight + 10) - topInset
            
            PersistentBottomSheet(
                minSheetHeight: height * 0.5,
                sheetHeight: height,
                sheetState: $sheetState,
                sheetContent: {
                    // CONTENT
                    SheetContentView(
                        locations: locations,
                        coordinateRegion: $coordinateRegion,
                        sheetState: $sheetState
                    )
                },
                backContent: {
                    // MAP
                    Map(
                        coordinateRegion: $coordinateRegion,
                        annotationItems: locations
                    ) { location in
                        MapAnnotation(coordinate: location.coordinates) {
                            PizzaMarkerView(
                                location: location
                            )
                        }
                    }
                },
                topContent: {
                    // NAV BAR
                    NavigationBarView(
                        title: "Pizzario",
                        action: {}
                    )
                        .padding(.top, topInset)
                }
            )
        }
        .ignoresSafeArea(.container, edges: .all)
        .fillMaxSize()
        .preferredColorScheme(.dark)
     }
}

// MARK: - Preview
struct PizzarioApp_Previews: PreviewProvider {
    static var previews: some View {
        PizzarioApp()
            .previewLayout(.sizeThatFits)
    }
}
