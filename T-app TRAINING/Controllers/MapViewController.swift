//
//  MapViewController.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 9/21/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
    var closure: ((CGPoint) -> Void)?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longTabGesture = UILongPressGestureRecognizer(target: self , action: #selector(longTap(sender:)))
        
        mapView.addGestureRecognizer(longTabGesture)
    }
    
    
    @objc func longTap(sender: UIGestureRecognizer) {
        if sender.state == .began {
            mapView.removeAnnotations(mapView.annotations)
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = locationOnMap
            
            mapView.addAnnotation(annotation)
            let point = CGPoint(x: locationOnMap.latitude.rounded(2), y: locationOnMap.longitude.rounded(2))
            closure?(point)
        }
        
    }
    
}
extension Double {
    func rounded(_ number: Int) -> Double {
        let divisor = pow( 10.0, Double(number))
        return(self * divisor).rounded()/divisor
    }
}



