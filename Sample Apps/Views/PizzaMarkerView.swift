//
//  PizzaMarkerView.swift
//  Sample Apps
//
//  Created by Wind Versi on 27/4/22.
//

import SwiftUI

struct PizzaTriangle: View {
    // MARK: - Properties
    var color: Color
    var size: (width: CGFloat, height: CGFloat)
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let width = size.width
            let height = size.height

            Path { path in
                path.move(to: .init(x: 0, y: 0))
                path.addLine(to: .init(x: width, y: 0))
                path.addLine(to: .init(x: width/2, y: height))
                path.addLine(to: .init(x: 0, y: 0))
            }
            .stroke(
                color,
                style:
                    StrokeStyle(
                        lineWidth: 6,
                        lineCap: .round,
                        lineJoin: .round
                    )
            )
        }
        .frame(
            width: size.width,
            height: size.height
        )
    }
}


struct PizzaMarkerView: View {
    // MARK: - Properties
    var location = Location()
    // 180 angle reverses the triangle
    // + angle to move left
    // - angle to move right
    @State var degrees = 0.0
    @State var shadowOpacity = 0.0
    
    var pizzaSize: (width: CGFloat, height: CGFloat) {
        location.animationProps.pizzaSize
    }

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // Layer 1: LAND MARKER
            Circle()
                .fill(Colors.tertiary2.color)
                .frame(width: 13, height: 13)
                .overlay(
                    Circle()
                        .stroke(
                            Colors.background.color,
                            lineWidth: 2
                        )
                )
            
            // Layer 2: STORE INDICATOR
            PizzaTriangle(
                color: Colors.secondary.color,
                size: (pizzaSize.width, pizzaSize.height)
            )
                .rotationEffect(.init(degrees: degrees), anchor: .bottom)
                .padding(.bottom, 13)
                .shadow(
                    color: Colors.secondary.color.opacity(shadowOpacity),
                    radius: 5,
                    x: 0,
                    y: 2
                )
                .animation(
                    .linear(duration: 2)
                        .repeatForever(autoreverses: true)
                )
            
        } //: ZStack
        .onAppear {
            withAnimation(
                .linear.delay(location.animationProps.delay)
            ) {
                degrees += location.animationProps.degreesToMove
                shadowOpacity = 0.5
            }
        }
    }
}

// MARK: - Preview
struct PizzaMarkerView_Previews: PreviewProvider {
    static var previews: some View {
        PizzaMarkerView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray)
    }
}
