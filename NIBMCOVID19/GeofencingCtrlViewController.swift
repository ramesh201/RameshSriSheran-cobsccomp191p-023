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

class GeofencingCtrlViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var personList = [GeoPersons]()
    //let annotation = ColorPointAnnotation(pinColor: UIColor.blueColor())
    var fillColor: UIColor = .orange
    var borderColor: UIColor = .blue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var person = GeoPersons(title: "String011", subtitle: "String012",latitude: 6.906530,longitude: 79.870740)
        personList.append(person)
        person = GeoPersons(title: "String021", subtitle: "String022",latitude: 6.906500,longitude: 79.870740)
        personList.append(person)
        person = GeoPersons(title: "My", subtitle: "Location",latitude: 6.906555,longitude: 79.870740)
        personList.append(person)
        
        //print(personList[1].title)
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        //6.906555, 79.870740
        let nibm = CLLocation(latitude: 6.906555, longitude: 79.870740)
        let regionRadius: CLLocationDistance = 5.0
        
        let region = MKCoordinateRegion(center: nibm.coordinate,latitudinalMeters: regionRadius,longitudinalMeters: regionRadius)
        
        mapView.setRegion(region,animated: true)
        mapView.delegate = self
        
        var pin : CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(personList[2].latitude1), CLLocationDegrees(personList[2].longitude1))
        var annotation = MKPointAnnotation()
        annotation.coordinate = pin
        annotation.title = personList[2].title1// "NIBM Colombo"
        annotation.subtitle = personList[2].subtitle1// "Colombo 07"
        
        
        var annot2 = MKAnnotationView()
        annot2.image = UIImage(named: "first")
        //annotation. = annotation
        
        self.mapView.addAnnotation(annotation) //as! MKAnnotation as! MKAnnotation as! MKAnnotation as! MKAnnotation
        fillColor = .red
        borderColor = .blue
        
        mapView.addOverlay(MKCircle(center: pin, radius: regionRadius))
        self.mapView.selectAnnotation(annotation, animated: false)
        
        for  i in stride(from: 0, to: personList.count-1, by: 1) {
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
            
            fillColor = .yellow
            borderColor = .green
            mapView.addOverlay(MKCircle(center: pin, radius: regionRadius))
            
            
         }
        
            
            
        }
    
    
    /*func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      mapView.showsUserLocation = (status == .authorizedAlways)
    }*/
    /*
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        /*if let location = locations.first {
            let span = makecoor(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }*/
    }
 */
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        
        for  i in stride(from: 0, to: mapView.annotations.count, by: 1) {
            
            mapView.tintColor = UIColor.white
            print(mapView.annotations[i].title!! , mapView.annotations[i].title == "My" , mapView.tintColor == UIColor.green)
        }
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.image = UIImage(systemName: "person.circle.fill")
        print(mapView.selectedAnnotations.description)
        print(mapView.annotations[0].title!! , mapView.annotations[0].title == "My" , mapView.tintColor == UIColor.green)
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.image = UIImage(systemName: "person.circle.fill")
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
      //return nil
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if overlay is MKCircle {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.lineWidth = 1.0
        circleRenderer.strokeColor = .blue
        //var fillColor: UIColor = .orange
        circleRenderer.fillColor = fillColor.withAlphaComponent(0.4)
        return circleRenderer
      }
      return MKOverlayRenderer(overlay: overlay)
    }
   
    /*func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {

      return .blue
    }*/
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

           if locations.first != nil {
               print("location:: (location)")
           }

       }

}

extension GeofencingCtrlViewController : MKMapViewDelegate {
    /*func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orangeColor()
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPointZero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "car"), forState: .Normal)
        button.addTarget(self, action: "getDirections", forControlEvents: .TouchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }*/
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Delegate")
        /*if let location = locations.first {
            let span = makecoor(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }*/
    }
}

extension GeofencingCtrlViewController : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            //locationManager.requestLocation()
        }
    }

   /* func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if locations.first != nil {
            print("location:: (location)")
        }

    }*/

}
