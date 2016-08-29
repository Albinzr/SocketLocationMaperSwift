//
//  ViewController.swift
//  FindLocation
//
//  Created by Albin on 29/08/16.
//  Copyright © 2016 Albin. All rights reserved.
//

import UIKit
import MapKit
import SocketIOClientSwift

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.151.97:3000")!)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        socket.on("new") { (dataArray, socketAck) -> Void in
            
            print(dataArray)
            let location = dataArray[0]["location"] as! String
            
            var locationArray = location.characters.split{$0 == ","}.map(String.init)
 
            
            self.map.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(CLLocationDegrees(locationArray[0])!,CLLocationDegrees(locationArray[1])!), MKCoordinateSpanMake(0.1, 0.1)), animated: false)
            
            let annotation = MKPointAnnotation()
            var locationCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(locationArray[0])!, CLLocationDegrees(locationArray[1])!)
            annotation.coordinate = locationCoordinate
            self.map.addAnnotation(annotation)
            
            
            
        }
        socket.connect()
        
        

        
    }




}

