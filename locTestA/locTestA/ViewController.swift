//
//  ViewController.swift
//  locTestA
//
//  Created by Jonathan Nehring on 3/25/17.
//  Copyright © 2017 Stonetip. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    enum GeoMath{
        static let radian: Float = Float(180/M_PI)
        static let metersToFeet = 3.28084
    }
    
    
    @IBOutlet weak var labelLatVal: UILabel!
    @IBOutlet weak var labelLonVal: UILabel!
    @IBOutlet weak var labelAltVal: UILabel!
    @IBOutlet weak var labelCourseVal: UILabel!
    @IBOutlet weak var labelHeadingVal: UILabel!
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    
    
    let locMgr = CLLocationManager()
    var updating = false
    
    
    @IBAction func doStart (_ sender: Any!){
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // you have 2 choice
            // 1. requestAlwaysAuthorization
            // 2. requestWhenInUseAuthorization
            self.locMgr.requestWhenInUseAuthorization()
        }
        
        
        guard CLLocationManager.headingAvailable() else {
            
            print("No hardware found")
            return
        } // no hardware (Note: remove or modify once lat/lon is used too
        
        if self.updating {return}
        if self.locMgr.delegate == nil { self.locMgr.delegate = self }
        
        print("starting")
        
        self.locMgr.headingFilter = 1
        self.locMgr.headingOrientation = .portrait
        self.updating = true
        
        self.locMgr.startUpdatingHeading()
        
        self.locMgr.desiredAccuracy = kCLLocationAccuracyBest // The accuracy of the location data
        self.locMgr.distanceFilter = 1 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
        self.locMgr.startUpdatingLocation()
    }
    
    
    @IBAction func doStop (_ sender: Any!){
        
        print("stopping")
        
        self.locMgr.stopUpdatingHeading()
        self.locMgr.stopUpdatingLocation()
        self.updating = false
        
        labelHeadingVal.text = String(format: "%.1f", 0)
        labelLatVal.text = String(format: "%.6f", 0)
        labelLonVal.text = String(format: "%.6f", 0)
        labelAltVal.text = String(format: "%.f", 0)
        labelCourseVal.text = String(format: "%.1f", 0)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        self.doStop(nil)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        var currentHeading = newHeading.magneticHeading
        
        let trueHeading = newHeading.trueHeading // - 1 if no location info
        
        print("ch: \(currentHeading) th: \(trueHeading)")
        
        if trueHeading > 0 {
            
            currentHeading = trueHeading
        }
        
        labelHeadingVal.text = String(format: "%.1f", currentHeading)
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let alt = location.altitude
        let course = location.course
        
        labelLatVal.text = String(format: "%.6f", lat)
        labelLonVal.text = String(format: "%.6f", lon)
        labelAltVal.text = String(format: "%.f", alt * GeoMath.metersToFeet)
        labelCourseVal.text = String(format: "%.1f", course)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

