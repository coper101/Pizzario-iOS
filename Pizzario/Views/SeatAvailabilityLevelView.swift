//
//  SeatAvailabilityLevelView.swift
//  Sample Apps
//
//  Created by Wind Versi on 25/4/22.
//

import SwiftUI

struct SeatAvailabilityLevelView: View {
    // MARK: - Properties
    @State var percentage: CGFloat = 0
    var location = Location()
    
    var labelTitle: String {
        location.status == .close ?
            "NA" :
            "\(Int(percentage))% Seats Available"
    }

    // MARK: - Body
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 9
        ) {
            
            // MARK: - Row 1: Indicator
            ZStack {
                
                // Layer 1:
                RoundedRectangle(cornerRadius: 10)
                    .fill(Colors.primary.color.opacity(0.2))
                    .fillMaxSize()
                
                // Layer 2:
                GeometryReader { reader in
                    
                    let width = reader.frame(in: .local).width
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Colors.primary.color)
                        .frame(width: (percentage / 100) * width)
                        .fillMaxHeight()
                        .animation(.linear(duration: 1.5), value: percentage)
                }
                .fillMaxSize()
                
            }
            .frame(width: 131, height: 5)
            
            // MARK: - Row 2: Label
            Text(labelTitle)
                .textStyle(
                    colorOpacity: 0.5,
                    size: 12
                )

        } //: ZStack
        .onAppear {
            withAnimation {
                percentage = location.seatsPercentage
            }
        }
    }
}

// MARK: - Preview
struct SeatAvailabilityLevelView_Previews: PreviewProvider {
    static var previews: some View {
        
        SeatAvailabilityLevelView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Colors.background.color)
    }
}
