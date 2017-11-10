//
//  Annotation.swift
//  EarthquakeAPIInvasiveCode
//
//  Created by Paul Wallace on 10/20/17.
//  Copyright © 2017 Paul Wallace. All rights reserved.
//

import Foundation
import MapKit
class Annotation: NSObject {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(title: String, subTitle: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.subtitle = subTitle
        self.coordinate = coordinate
    }
}

extension Annotation: MKAnnotation {
    
}
