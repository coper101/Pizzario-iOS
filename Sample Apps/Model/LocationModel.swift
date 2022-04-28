//
//  LocationMode.swift
//  Sample Apps
//
//  Created by Wind Versi on 28/4/22.
//

import Foundation
import MapKit

struct Location: Identifiable {
    var id = UUID().uuidString
    var branchName = "Branch Name"
    var address1 = "Street Name"
    var address2 = "Unit No."
    var distance: Int = 0
    var status = Status.open
    var seatsPercentage: CGFloat = 0
    var coordinates: CLLocationCoordinate2D = .init(
        latitude: 40.764051,
        longitude: -74.075571
    )
    var animationProps: AnimationProps =
        .init(
            delay: 0,
            degreesToMove: 0,
            pizzaSize: (width: 31, height: 40)
        )
}

struct AnimationProps {
    var delay: Double
    var degreesToMove: Double
    var pizzaSize: (width: CGFloat, height: CGFloat)
}
