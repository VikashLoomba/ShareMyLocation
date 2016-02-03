//
//  ViewController.swift
//  ShareMyLocation
//
//  Created by Vikash Loomba on 2/2/16.
//  Copyright © 2016 Loomba Apps. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Contacts

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    //Apple Maps URL to send text
    
    //Message Composer
    let messageComposer = MessageComposer();
    //location manager
    let locationManager : CLLocationManager = CLLocationManager();
    //Label
    @IBOutlet weak var locationLat: UILabel!
    @IBOutlet weak var locationLong: UILabel!
    //MapView
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestAlwaysAuthorization();
        
        mapView.delegate = self;
        mapView.showsCompass = true;
        mapView.showsUserLocation = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {

    }
    
    //Pressed the locate me button
    @IBAction func didPressLocateMe(sender: UIButton) {
        setMap();
        let locateHelper = LocationManager();
        guard let coordinates: CLLocationCoordinate2D = locateHelper.getCurrentLocation(self.locationManager).coordinate else {
            //Alert user of something, debug
            print("Error, could not get coordinates");
        }
        locationLat.text = "Latitude: \(coordinates.latitude)";
        locationLong.text = "Longitude: \(coordinates.longitude)";
    }
    
    //Pressed the SMS button
    @IBAction func didPressSMSButton(sender: UIButton) {
        if let location: CLLocation = locationManager.location! {
            if(messageComposer.canSendText()){
                let messageComposeVC = messageComposer.configuredMessageComposeViewController(location);
                presentViewController(messageComposeVC, animated: true, completion: nil)
            } else {
                // Let the user know if his/her device isn't able to send text messages
                let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
                errorAlert.show()
            }
            
        }
    }
    
    //Sets the map region
    func setMap(){
        let locateHelper = LocationManager();
        guard let coordinates: CLLocationCoordinate2D = locateHelper.getCurrentLocation(self.locationManager).coordinate else {
            //Alert user of something, debug
            print("Error, could not get coordinates");
        }
        let latitude: CLLocationDegrees = coordinates.latitude;
        let longitude: CLLocationDegrees = coordinates.longitude;
        let latDelta:CLLocationDegrees = 0.05
        
        let lonDelta:CLLocationDegrees = 0.05
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.Authorized {
            setMap();
        }
    }
    


}

