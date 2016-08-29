//
//  ViewController.swift
//  SocketTimeFeed
//
//  Created by Albin on 27/08/16.
//  Copyright © 2016 Albin. All rights reserved.
//

import UIKit
import SocketIOClientSwift
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    
    var locationManager = CLLocationManager()
    @IBOutlet weak var statusLabel: UILabel!
    
    var sendCount = 1
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.151.97:3000")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        self.socket.connect()
        
        socket.emit("send", "\((locationManager.location?.coordinate.latitude)!),\((locationManager.location?.coordinate.longitude)!)")
        
        statusLabel.text = " Location send : 1"
        
        NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: #selector(ViewController.sendLocation), userInfo: nil, repeats: true)
        
    }
    
    func sendLocation(){
        if (CLLocationManager.locationServicesEnabled())
        {
            sendCount = sendCount + 1
            socket.emit("send", "\((locationManager.location?.coordinate.latitude)!),\((locationManager.location?.coordinate.longitude)!)")
            statusLabel.text = " Location send : \(sendCount)"
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations.last! as CLLocation
        print(location)
        
    }
    
    
    
    
    
    
    
}

