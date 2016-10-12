//
//  ViewController.swift
//  SearchMap Ottawa
//
//  Created by yu ni on 2016-10-11.
//  Copyright ©/Users/yuni/Desktop/SearchMap Ottawa/SearchMap Ottawa/ViewController.swift 2016 yu ni. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var btnHospital: UIButton!
    @IBOutlet weak var btnHotel: UIButton!
    @IBOutlet weak var btnMall: UIButton!
    
    @IBOutlet weak var btnSupermarket: UIButton!
    
    @IBOutlet weak var btnMenu: UIButton!
    
    
@IBAction func btnHospitalClick(sender: AnyObject) {
    mapView.removeAnnotations(mapView.annotations)
    searchMap("Hospital")
    
        reset()
    }
    

    
    @IBAction func btnHotelClick(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap("Hotel")
        reset()
    }
    
    
    @IBAction func btmMallClick(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap("Mall")
        reset()
    }
    
    
    @IBAction func btnSupermarket(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap("Supermarket")
        reset()
    }
    
    
    //initial location
    let initialLocation = CLLocation(latitude: 45.4235937000, longitude:-75.7009290000)
    // search range
    let searchRadius = CLLocationDistance(5000)
    
    
    
    @IBAction func btnMenuClick(sender: AnyObject) {
        
        UIView.animateWithDuration(0.1, delay: 0.05, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.btnMenu.transform = CGAffineTransformMakeRotation(0)
        
        self.btnHotel.alpha = 0.8
        self.btnHotel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5),
        CGAffineTransformMakeTranslation(-50, -25))
        
        self.btnHospital.alpha = 0.8
        self.btnHospital.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5),
                                                          CGAffineTransformMakeTranslation(-100, 30))
        
        self.btnSupermarket.alpha = 0.8
        self.btnSupermarket.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5),
                                                          CGAffineTransformMakeTranslation(80, 10))
        
        self.btnMall.alpha = 0.8
        self.btnMall.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5),
                                                          CGAffineTransformMakeTranslation(100, -50))
         }, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnMenu.alpha = 0
        self.btnHotel.alpha = 0
        self.btnHospital.alpha = 0
        self.btnSupermarket.alpha = 0
        self.btnMall.alpha = 0
        
        self.btnHospital.layer.cornerRadius = 10
        self.btnHotel.layer.cornerRadius = 10
        self.btnSupermarket.layer.cornerRadius = 10
        self.btnMall.layer.cornerRadius = 10
        self.btnMenu.layer.cornerRadius = 10
        
    
        UIView.animateWithDuration(0.1, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.btnMenu.alpha = 1
            self.btnMenu.transform = CGAffineTransformMakeRotation(0.25*3.1415927)
            }, completion: nil)
        
        searchMap("place")
        
        // create region
        let region = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, searchRadius, searchRadius)
        // set display
        mapView.setRegion(region, animated: true)
        
    }
    
    
   func reset(){
    
    UIView.animateWithDuration(0.2, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
        self.btnMenu.transform = CGAffineTransformMakeRotation(0.25*3.1415927)
        
        self.btnHotel.alpha = 0
        self.btnHotel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1),
            CGAffineTransformMakeTranslation(0, 0))
        
        self.btnHospital.alpha = 0
        self.btnHospital.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1),
            CGAffineTransformMakeTranslation(0, 0))
        
        self.btnSupermarket.alpha = 0
        self.btnSupermarket.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1),
            CGAffineTransformMakeTranslation(0, 0))
        
        self.btnMall.alpha = 0
        self.btnMall.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1),
            CGAffineTransformMakeTranslation(0, 0))
        }, completion: nil)

  }
    
    // add interested places
    func addLocation(title:String,latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MyAnnotation(coordinate: location, title: title)
        mapView.addAnnotation(annotation)
    }
    
    
       //search
    func searchMap(place:String){
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = place
        
        // search region
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center:initialLocation.coordinate, span: span)
        
        // start search and return result into array
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response:MKLocalSearchResponse?, error: NSError?) in
            for item in response!.mapItems //as![MKMapItem]
            {
                self.addLocation(item.name!, latitude: item.placemark.location!.coordinate.latitude, longitude: item.placemark.location!.coordinate.longitude)
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

