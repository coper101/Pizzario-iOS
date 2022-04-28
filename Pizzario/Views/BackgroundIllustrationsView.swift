//
//  BackgroundIllustrationsView.swift
//  Sample Apps
//
//  Created by Wind Versi on 28/4/22.
//

import SwiftUI

struct BackgroundIllustrationsView: View {
    // MARK: - Properties
    var color = Colors.primary.color
    var lineWidth = 4.5
    var size: (width: CGFloat, height: CGFloat) = (width: 97, height: 73)
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            ZStack(alignment: .topLeading) {
                // TOPPINGS
                
                // Meat
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(color, lineWidth: lineWidth)
                    .frame(width: 15, height: 15)
                    .rotationEffect(.init(degrees: 22))
                    .offset(x: 3, y: height/2)
                
                // Peperonni
                Circle()
                    .strokeBorder(color, lineWidth: lineWidth)
                    .frame(width: 17, height: 17)
                    .offset(x: 15 + 5)

                // Pizza
                PizzaTriangle(color: color, size: (width: 40 - 12, height: 52 - 18))
                    .rotationEffect(.init(degrees: 45))
                    .offset(x: 15 + 5 + 17 + 4, y: height/4)
                
                // Meat
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(color, lineWidth: lineWidth)
                    .frame(width: 15, height: 15)
                    .rotationEffect(.init(degrees: 40))
                    .offset(x: width - 18, y: height - 24)

            }
            
        } //: Geometry Reader
        .frame(width: size.width, height: size.height)
    }
}

struct BackgroundIllustrationsView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundIllustrationsView()
            .previewLayout(.sizeThatFits)
            .background(Colors.background.color)

    }
}
