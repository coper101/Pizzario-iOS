//
//  NavigationBarView.swift
//  Sample Apps
//
//  Created by Wind Versi on 25/4/22.
//

import SwiftUI

struct NavigationBarView: View {
    // MARK: - Properties
    var title: String = "Title"
    var action: () -> Void = {}
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 21) {
            
            // Col 1: Back Button
            Button(action: {}) {
                Circle()
                    .fill(Colors.background.color)
                    .frame(width: 38, height: 38)
                    .overlay(
                        Icons.back.image
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Colors.primary.color)
                            .scaledToFit()
                            .padding(.vertical, 11)
                            .padding(.leading, 11)
                            .padding(.trailing, 13)
                )
            }
            
            // Col 2: Title
            Text(title)
                .textStyle(
                    font: Fonts.helveticaBold.value,
                    size: 24
                )
            
            // Col 3:
            Spacer()
            
        } //: HStack
        .padding(.horizontal, 21)
        .frame(height: 50)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.green)
    }
}
