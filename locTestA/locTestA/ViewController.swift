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
    }
    
    
    @IBAction func doStop (_ sender: Any!){
        
        print("stopping")
        
        self.locMgr.stopUpdatingHeading()
        self.updating = false
        
        labelHeadingVal.text = String(format: "%.1f", 0)
        //TODO: reset label values
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

