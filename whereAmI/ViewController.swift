//
//  ViewController.swift
//  whereAmI
//
//  Created by Kaylan Smith on 7/2/16.
//  Copyright © 2016 Kaylan Smith. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager!
    
    @IBOutlet var latitudeLabel: UILabel!    
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy - kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        print(locations)
        
        var userLocation:CLLocation = locations[0]
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        
        self.courseLabel.text = "\(userLocation.course)"
        
        self.speedLabel.text = "\(userLocation.speed)"
        
        self.altitudeLabel.text = "\(userLocation.altitude)"
        
        // for address:
        // geocoding is process of going from place name to coordinates, 
        // reverse is going from latitude/longitude to an address
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler:  { (placemarks, error) -> Void in
            
            // first check for error
            
            if (error != nil) {
                
                print(error)
                
            } else {
            
                if placemarks!.count > 0 {
                    // create a placemark
                    //  testing to see if we can convert the first return in an array (location)
                    let p = (placemarks![0])
                        
                    if (p.subThoroughfare != nil) {
                        
                        let subThoroughFare = p.subThoroughfare
                
                        self.addressLabel.text = "\(subThoroughFare) \(p.thoroughfare) \n \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.postalCode) \n \(p.country)"
                        
                    }
                        
                    
                    
                }
            
            }
            
        })
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

