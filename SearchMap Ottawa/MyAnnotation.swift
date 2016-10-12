//
//  MyAnnotation.swift
//  SearchMap Ottawa
//
//  Created by yu ni on 2016-10-12.
//  Copyright © 2016 yu ni. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotation: NSObject,MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0,0)
    var title:String!
    
    init(coordinate:CLLocationCoordinate2D,title:String) {
        self.coordinate = coordinate
        self.title = title
    }

}
