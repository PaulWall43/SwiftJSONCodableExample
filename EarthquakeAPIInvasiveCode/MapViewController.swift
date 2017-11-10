//
//  MapViewController.swift
//  EarthquakeAPIInvasiveCode
//
//  Created by Paul Wallace on 10/20/17.
//  Copyright © 2017 Paul Wallace. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SafariServices

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var currQuakeLoc: QuakeLoc!
    lazy var locationManager : CLLocationManager = {
        let lm = CLLocationManager()
        return lm
    }()
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Map", comment: "title of map view controller")
        self.navigationItem.largeTitleDisplayMode = .always
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "identifier")
//        if CLLocationManager.authorizationStatus() == .notDetermined {
//            locationManager.requestWhenInUseAuthorization()
//        } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            locationManager.startUpdatingLocation()
//        }
        
        let centerMap = CLLocationCoordinate2D(latitude: currQuakeLoc.latitude, longitude: currQuakeLoc.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: centerMap, span: span)
        self.mapView.setRegion(region, animated: true)
        let annotation:Annotation = Annotation(title: currQuakeLoc.location!, subTitle: "\(currQuakeLoc.depth)", coordinate: centerMap)
        mapView.addAnnotation(annotation)
        // Do any additional setup after loading the view.
    }
}

extension MapViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let view = MKAnnotationView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 10.0))
//        let view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "identifier")
//        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "identifier")
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: "identifier", for: annotation) as! MKMarkerAnnotationView
        view.animatesWhenAdded = true
        view.markerTintColor = UIColor.blue
        let calloutView = UIView()
//        calloutView.backgroundColor = UIColor.black
//        calloutView.translatesAutoresizingMaskIntoConstraints = false
        view.detailCalloutAccessoryView = calloutView
        view.canShowCallout = true
        
        return view
    }
    @objc
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let marker = view as! MKMarkerAnnotationView
        let button = UIButton(frame: CGRect(x:0, y:0, width: 50, height: 50))
        button.addTarget(self, action: #selector(showWebView), for: UIControlEvents.touchUpInside)
        button.backgroundColor = UIColor.blue
        button.setTitle("OK", for: .normal)
        marker.rightCalloutAccessoryView = button
//        marker.
//        marker.isHidden = true
//        guard let urlString = currQuakeWeb?.link else {return}
//        guard let url = URL(string: urlString) else {return}
//
//        let vc = SFSafariViewController(url: url)
//        self.show(vc, sender: nil)
    }
    
    @objc func showWebView(){
        let currQuakeWeb = currQuakeLoc.quakeWeb
        guard let urlString = currQuakeWeb?.link else {return}
        guard let url = URL(string: urlString) else {return}
        let vc = SFSafariViewController(url: url)
        self.show(vc, sender: nil)
    }
}
