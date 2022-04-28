//
//  DividerView.swift
//  Sample Apps
//
//  Created by Wind Versi on 25/4/22.
//

import SwiftUI

struct DividerView: View {
    // MARK: - Properties

    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            
            let width = geometry.frame(in: .local).width
            
            Rectangle()
                .fill(Colors.primary.color.opacity(0.1))
                .fillMaxHeight()
                .padding(.horizontal, width - (0.98 * width))
            
        } //: Geometry Reader
        .fillMaxWidth(alignment: .center)
        .frame(height: 1.2)
    }
}

struct DividerView_Previews: PreviewProvider {
    static var previews: some View {
        DividerView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.green)
    }
}
