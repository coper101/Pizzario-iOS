//
//  LocationRowView.swift
//  Sample Apps
//
//  Created by Wind Versi on 25/4/22.
//

import SwiftUI
import MapKit

enum Status: String {
    case open = "OPEN"
    case close = "CLOSE"
    
    var title: String {
        self.rawValue
    }
    
    var color: Color {
        switch self {
        case .open:
            return Colors.secondary.color
        case .close:
            return Colors.tertiary.color
        }
    }
}

struct LocationRowView: View {
    // MARK: - Properties
    var location = Location()
    @Binding var coordinateRegion: MKCoordinateRegion
    @Binding var sheetState: SheetState
    
    var isDisabledCall: Bool {
        location.status == .close
    }
    
    var callColor: Color {
        Colors.primary.color
            .opacity(isDisabledCall ? 0.2 : 1)
    }
    
    var content: some View {
        VStack(spacing: 0) {
            
            // MARK: - Row 1: Content
            HStack(spacing: 0) {
                
                // MARK: LEFT Col:
                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {
                    
                    // Row 1: BRANCH NAME
                    Text(location.branchName)
                        .textStyle(
                            font: Fonts.helveticaBold.value,
                            size: 21
                        )
                    
                    // Row 2: ADDRESS 1 & 2
                    HStack(spacing: 3) {
                        
                        Text(location.address1)
                            .textStyle(size: 16)

                        Text("  |  ")
                            .textStyle(colorOpacity: 0.2, size: 16)
                        
                        Text(location.address2)
                            .textStyle(size: 14)

                    }
                    .fillMaxWidth(alignment: .leading)
                    
                    // Row 3: DISTANCE
                    Text("\(location.distance) km")
                        .textStyle(size: 12)
                    
                    Spacer()
                    
                    // Row 4: SEAT AVAILABILITY
                    SeatAvailabilityLevelView(
                        location: location
                    )
                    
                    
                } //: VStack
                .padding(.vertical, 5)
                .fillMaxSize(alignment: .leading)
                
                // MARK: RIGHT Col:
                VStack(
                    alignment: .trailing,
                    spacing: 23
                ) {
                    
                    // Row 1: STATUS
                    Text(location.status.title)
                        .textStyle(
                            foregroundColor: location.status.color,
                            size: 16
                        )
                        .shadow(
                            color: location.status.color.opacity(0.3),
                            radius: 10,
                            x: 0,
                            y: 1
                        )
                    
                    // Row 2: CALL BUTTON
                    Button(action: {}) {
                        
                        VStack(spacing: 0) {

                            // Row 1:
                            Icons.call.image
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(callColor)
                                .frame(width: 18, height: 18)
                            
                            // Row 2:
                            Text("Call")
                                .textStyle(
                                    foregroundColor: callColor,
                                    size: 12
                                )
                                .padding(.top, 8)
                            
                        } //: VStack
                        
                    } //: Button
                    .frame(width: 43)
                    .disabled(isDisabledCall)
                    
                } //: VStack
                .frame(width: 80, alignment: .trailing)
                .fillMaxHeight()
                
            } //: HStack
            .fillMaxWidth()
            .frame(height: 108)
            
            // MARK: - Row 2:
            Spacer()
            
            // MARK: - Row 3: Divider
            DividerView()
            
        } //: VStack
        .frame(height: 126)
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: didTapItemRow) {
            content
        }
        .disabled(false)
    }
    
    // MARK: Functions
    func didTapItemRow() {
        // show map if sheet is fully expanded
        if sheetState == .expanded {
            sheetState = .collapsed
        }
        // go to the store location
        withAnimation {
            coordinateRegion.center = location.coordinates
            coordinateRegion.span = .init(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        }
    }
}

// MARK: - Preview
struct LocationRowView_Previews: PreviewProvider {
    static var previews: some View {
        LocationRowView(
            coordinateRegion: .constant(mainCoordinate),
            sheetState: .constant(.collapsed)
        )
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Open")
            .padding()
            .background(Colors.background.color)
        
        LocationRowView(
            location: Location(status: .close),
            coordinateRegion: .constant(mainCoordinate),
            sheetState: .constant(.collapsed)
        )
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Close")
            .padding()
            .background(Colors.background.color)
    }
}
