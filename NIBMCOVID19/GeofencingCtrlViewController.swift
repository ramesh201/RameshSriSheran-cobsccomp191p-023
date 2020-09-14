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
import GeoFire

class  GeoPersons{
    
    enum EventType: String {
      case onEntry = "On Entry"
      case onExit = "On Exit"
    }
    
    /*enum CodingKeys: String, CodingKey {
      case latitude, longitude, radius, identifier, note, eventType
    }*/
    
    /*var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance = 0.0
    var identifier: String = ""
    var note: String = ""
    var eventType: EventType
    */
    
    var title1: String?
    var subtitle1: String?
    var latitude1: CGFloat
    var longitude1: CGFloat
    
    init(title: String , subtitle: String,latitude: CGFloat,longitude: CGFloat){
        title1 = title
        subtitle1 = subtitle
        latitude1 = latitude
        longitude1 = longitude
    }
    
}

class Annotation: NSObject, MKAnnotation
{
var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
var custom_image: Bool = true
    var color = MKPinAnnotationView.purplePinColor()
}

class GeofencingCtrlViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var personList = [GeoPersons]()
    //let annotation = ColorPointAnnotation(pinColor: UIColor.blueColor())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var person = GeoPersons(title: "String011", subtitle: "String012",latitude: 6.906530,longitude: 79.870740)
        personList.append(person)
        person = GeoPersons(title: "String021", subtitle: "String022",latitude: 6.906550,longitude: 79.870740)
        personList.append(person)
        
        //print(personList[1].title)
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        //6.906555, 79.870740
        let nibm = CLLocation(latitude: 6.906555, longitude: 79.870740)
        let regionRadius: CLLocationDistance = 5.0
        
        let region = MKCoordinateRegion(center: nibm.coordinate,latitudinalMeters: regionRadius,longitudinalMeters: regionRadius)
        
        mapView.setRegion(region,animated: true)
        mapView.delegate = self
        
        for  i in stride(from: 0, to: personList.count, by: 1) {
            var pin : CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(personList[i].latitude1), CLLocationDegrees(personList[i].longitude1))  //(personList[i].latitude1, personList[i].longitude1)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = pin
        annotation.title = personList[i].title1// "NIBM Colombo"
        annotation.subtitle = personList[i].subtitle1// "Colombo 07"
            
            let reuseId = "pin"
            var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            
            let anAnnotation = annotation as? Annotation
                
            
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView.pinTintColor =  anAnnotation?.color
            // MKPinAnnotationColor(rawValue: anAnnotation?.color as! MKPinAnnotationColor.RawValue) ?? default value
            anView = pinView
            
        self.mapView.addAnnotation(annotation)
            
            
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      mapView.showsUserLocation = (status == .authorizedAlways)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      let identifier = "myGeotification"
      //if annotation is Geotification {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
          annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
          annotationView?.canShowCallout = true
            //let colorPointAnnotation = annotation as! ColorPointAnnotation
            //annotationView?.pinTintColor = colorPointAnnotation.pinColor

          let removeButton = UIButton(type: .custom)
          removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
          removeButton.setImage(UIImage(named: "first")!, for: .normal)
          annotationView?.leftCalloutAccessoryView = removeButton
        } else {
          annotationView?.annotation = annotation
        }
        return annotationView
      //}
      return nil
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if overlay is MKCircle {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.lineWidth = 1.0
        circleRenderer.strokeColor = .purple
        circleRenderer.fillColor = UIColor.purple.withAlphaComponent(0.4)
        return circleRenderer
      }
      return MKOverlayRenderer(overlay: overlay)
    }
   
    /*func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {

      return .blue
    }*/
    
}
