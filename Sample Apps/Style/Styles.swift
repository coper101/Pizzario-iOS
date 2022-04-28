//
//  Styles.swift
//  Sample Apps
//
//  Created by Wind Versi on 25/4/22.
//

import Foundation
import SwiftUI

// MARK: - Asset Helpers
enum Colors: String {
    case background = "Background"
    case primary = "Primary"
    case secondary = "Secondary"
    case tertiary = "Tertiary"
    case tertiary2 = "Tertiary2"
    var color: Color {
        Color(self.rawValue)
    }
}

enum Icons: String {
    case call = "Call"
    case back = "Back"
    var image: Image {
        Image(self.rawValue)
    }
}

enum Fonts: String {
    case helveticaBold = "Helvetica-Bold"
    case helveticaRegular = "Helvetica-Regular"
    var value: String {
        self.rawValue
    }
}

// MARK: - Text
struct CustomText: ViewModifier {
    var foregroundColor: Color
    var colorOpacity: Double
    var font: String
    var size: Int
    var maxWidth: CGFloat?
    var alignment: Alignment
    var lineLimit: Int?
    var lineSpacing: CGFloat
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(
                foregroundColor.opacity(colorOpacity)
            )
            .font(
                Font.custom(
                    font,
                    size: CGFloat(size)
                )
            )
            .frame(
                maxWidth: maxWidth,
                alignment: alignment
            )
            .lineLimit(lineLimit)
            .lineSpacing(lineSpacing)
    }
}

// MARK: - Frame
struct FrameModifier: ViewModifier {
    var maxWidth: CGFloat?
    var maxHeight: CGFloat?
    var alignment: Alignment
    
    func body(content: Content) -> some View {
        content.frame(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            alignment: alignment
        )
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {
        
        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            return Path(path.cgPath)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .clipShape(
                CornerRadiusShape(
                    radius: radius,
                    corners: corners)
            )
    }
}

var topInset: CGFloat {
    guard let window = UIApplication.shared.windows.first else {
        return 0
    }
    return window.safeAreaInsets.top
}

extension View {
    
    /// Sets the style of the Text
    ///
    /// - Parameters:
    ///   - foregroundColor: The color of the text
    ///   - font: The custom font e.g. "Arial-Bold"
    ///   - size: The font size
    ///   - maxWidth: The text will fill all the available width of its parent
    ///   - alignment: The alignment of the text relative to its width
    ///   - linelimit: Limit the text per line. Overflowing text in single line will be truncated with ...
    ///   - lineSpacing: The space between lines of text
    ///
    /// - Returns: A Text View with new Style
    func textStyle(
        foregroundColor: Color = Colors.primary.color,
        colorOpacity: Double = 1,
        font: String = Fonts.helveticaRegular.value,
        size: Int,
        maxWidth: CGFloat? = nil,
        alignment: Alignment = .leading,
        lineLimit: Int? = nil,
        lineSpacing: CGFloat = 0
    ) -> some View {
        self.modifier(
            CustomText(
                foregroundColor: foregroundColor,
                colorOpacity: colorOpacity,
                font: font,
                size: size,
                maxWidth: maxWidth,
                alignment: alignment,
                lineLimit: lineLimit,
                lineSpacing: lineSpacing
            )
        )
    }
    
    func fillMaxHeight(
        alignment: Alignment = .center
    ) -> some View {
        modifier(
            FrameModifier(
                maxWidth: nil,
                maxHeight: .infinity,
                alignment: alignment
            )
        )
    }
    
    func fillMaxWidth(
        alignment: Alignment = .center
    ) -> some View {
        modifier(
            FrameModifier(
                maxWidth: .infinity,
                maxHeight: nil,
                alignment: alignment
            )
        )
    }
    
    func fillMaxSize(
        alignment: Alignment = .center
    ) -> some View {
        modifier(
            FrameModifier(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: alignment
            )
        )
    }
    
    func cornerRadius(
        radius: CGFloat,
        corners: UIRectCorner
    ) -> some View {
        ModifiedContent(
            content: self,
            modifier:
                CornerRadiusStyle(
                    radius: radius,
                    corners: corners
                )
        )
    }
    
}



