//
//  ContactUsViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/23/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit
import MapKit
import Foundation

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}



class ContactUsViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var btnMap: UIButton!
    @IBAction func mapBtn(_ sender: Any) {
        
        mapView.mapType = .standard
        
        
    }
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func btnResetMap(_ sender: UIButton) {
        viewDidLoad()
        
    }
    
    var constants = Constants()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Contact Us")
        //6.906449, 79.870615
        let nibm = CLLocation(latitude: constants.nibmLatitude, longitude: constants.nibmLongitude)
        let regionRadius: CLLocationDistance = 100.0
        
        let region = MKCoordinateRegion(center: nibm.coordinate,latitudinalMeters: regionRadius,longitudinalMeters: regionRadius)
        
        mapView.setRegion(region,animated: true)
        mapView.delegate = self
        
        var pin : CLLocationCoordinate2D = CLLocationCoordinate2DMake(constants.nibmLatitude, constants.nibmLongitude)
        var annotation = MKPointAnnotation()
        annotation.coordinate = pin
        annotation.title = "NIBM Colombo"
        self.mapView.addAnnotation(annotation)
        
    }
    
   /* extension ContactUsViewController: MKMapViewDelegate
    {
        func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
            print("rendering ....")
        }
    }
    */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
      }
}
