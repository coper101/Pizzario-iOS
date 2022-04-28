//
//  Locations.swift
//  Sample Apps
//
//  Created by Wind Versi on 26/4/22.
//

import Foundation
import MapKit

let locations: [Location] = [
    .init(
        branchName: "West",
        address1: "Emerald Street",
        address2: "#2-02",
        distance: 3,
        status: .open,
        seatsPercentage: 20,
        coordinates: .init(latitude: 40.78642, longitude: -74.07714),
        animationProps: .init(delay: 1, degreesToMove: -15, pizzaSize: (31, 40))
    ),
    .init(
        branchName: "North",
        address1: "Holland Road",
        address2: "#01-12",
        distance: 9,
        status: .open,
        seatsPercentage: 60,
        coordinates: .init(latitude: 40.79421, longitude: -74.06325),
        animationProps: .init(delay: 2, degreesToMove: 15, pizzaSize: (24, 30))
    ),
    .init(
        branchName: "South",
        address1: "Beach Road",
        address2: "#01-11",
        distance: 23,
        status: .close,
        coordinates: .init(latitude: 40.78039, longitude: -74.07009),
        animationProps: .init(delay: 1, degreesToMove: -15, pizzaSize: (31, 40))
    ),
    .init(
        branchName: "East",
        address1: "Emerald Street",
        address2: "#08-23",
        distance: 32,
        status: .open,
        seatsPercentage: 20,
        coordinates: .init(latitude: 40.78360, longitude: -74.06138),
        animationProps: .init(delay: 2, degreesToMove: 15, pizzaSize: (24, 30))
    ),
    .init(
        branchName: "North South",
        address1: "Flower Street",
        address2: "#05-23",
        distance: 50,
        status: .open,
        seatsPercentage: 60,
        animationProps: .init(delay: 1, degreesToMove: -15, pizzaSize: (24, 30))
    )
]

let mainCoordinate: MKCoordinateRegion =
    .init(
        center: locations[0].coordinates,
        span: .init(
            latitudeDelta: 0.04,
            longitudeDelta: 0.04
        )
    )
