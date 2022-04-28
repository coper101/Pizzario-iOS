//
//  SheetContentView.swift
//  Sample Apps
//
//  Created by Wind Versi on 25/4/22.
//

import SwiftUI
import MapKit

struct SheetContentView: View {
    // MARK: - Properties
    var locations: [Location]
    @Binding var coordinateRegion: MKCoordinateRegion
    @Binding var sheetState: SheetState

    // MARK: - Body
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 15
        ) {
            
            // HANDLE
            RoundedRectangle(cornerRadius: 10)
                .fill(Colors.primary.color.opacity(0.3))
                .frame(width: 32, height: 4.5)
                .fillMaxWidth(alignment: .center)
            
            // HEADER
            VStack(
                alignment: .leading,
                spacing: 1
            ) {
                Text("Stores")
                   .textStyle(
                       font: Fonts.helveticaBold.value,
                       size: 18
                   )
                
                Text("Found \(locations.count)")
                   .textStyle(
                       colorOpacity: 0.5,
                       size: 12
                   )
            }
            .padding(.horizontal, 14)
            
            // LOCATIONS
            ScrollView {
                
                VStack(spacing: 14) {
                    ForEach(locations) {
                        LocationRowView(
                            location: $0,
                            coordinateRegion: $coordinateRegion,
                            sheetState: $sheetState
                        )
                    }
                }
                .padding(.horizontal, 14)
                .padding(.top, 5)
            }
            .disabled(sheetState == .collapsed)
            
        }
        .padding(.top, 12)
        .padding(.bottom, 20)
        .fillMaxWidth()
        .background(
            ZStack(alignment: .topTrailing) {
                Colors.background.color
                BackgroundIllustrationsView(size: (97, 73))
                    .opacity(0.1)
                    .padding(.top, 24)
                    .offset(x: 8)
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
        .cornerRadius(
            radius: 20,
            corners: [.topLeft, .topRight]
        )
    }
}

// MARK: - Preview
struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetContentView(
            locations: locations,
            coordinateRegion: .constant(mainCoordinate),
            sheetState: .constant(.collapsed)
        )
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.green)
    }
}
