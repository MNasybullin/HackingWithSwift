//
//  ViewController.swift
//  Project16
//
//  Created by Stomach Diego on 9/26/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "https://en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "https://en.wikipedia.org/wiki/Washington,_D.C.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(typeMap))

    }
    
    @objc func typeMap() {
        let ac = UIAlertController(title: "Change map type", message: nil , preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: {(alert: UIAlertAction!) in self.mapView.mapType = .hybrid}))
        ac.addAction(UIAlertAction(title: "Hybrid Flyover", style: .default, handler: {(alert: UIAlertAction!) in self.mapView.mapType = .hybridFlyover}))
        ac.addAction(UIAlertAction(title: "Muted Standard", style: .default, handler: {(alert: UIAlertAction!) in self.mapView.mapType = .mutedStandard}))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: {(alert: UIAlertAction!) in self.mapView.mapType = .satellite}))
        ac.addAction(UIAlertAction(title: "Satellite Flyover", style: .default, handler: {(alert: UIAlertAction!) in self.mapView.mapType = .satelliteFlyover}))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: {(alert: UIAlertAction!) in self.mapView.mapType = .standard}))
        
        present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is Capital else { return nil }

        let identifier = "Capital"
        var view = MKPinAnnotationView()
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as! MKPinAnnotationView? {
            view = annotationView
            view.annotation = annotation
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            view.rightCalloutAccessoryView = btn
        }
        view.pinTintColor = UIColor.init(red: 1, green: 0.75, blue: 0, alpha: 1)
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let vc = DetailViewController()
        vc.infoURL = capital.info
        navigationController?.pushViewController(vc, animated: true)
    }

}

