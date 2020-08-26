//
//  GeofencingViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/24/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class GeofencingCtrlViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    
    @IBAction func addRegion(_ sender: Any) {
        print("ADD REGION")
        guard let longPress = sender as? UILongPressGestureRecognizer else { return }
        let touchLocation = longPress.location(in: mapView)
        
        let coordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        
        let region = CLCircularRegion(center: coordinate, radius: 200, identifier: "geofence")
        
        mapView.removeOverlays(mapView.overlays)
        
        locationManager.startMonitoring(for: region)
        
        let circle = MKCircle(center: coordinate, radius: region.radius)
        
        mapView.addOverlay(circle)
        
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension GeofencingCtrlViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        mapView.showsUserLocation = true
    }
}

extension GeofencingCtrlViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        guard let circleOverlay = overlay as? MKCircle else { return MKOverlayRenderer() }
        
        
        let circleRenderer = MKCircleRenderer(circle: circleOverlay)
        
        circleRenderer.strokeColor = .red
        circleRenderer.fillColor = .red
        circleRenderer.alpha = 0.5
        return circleRenderer
        
        
    }
}

