//
//  ViewController.swift
//  locTestA
//
//  Created by Jonathan Nehring on 3/25/17.
//  Copyright © 2017 Stonetip. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var labelLatVal: UILabel!
    @IBOutlet weak var labelLonVal: UILabel!
    @IBOutlet weak var labelAltVal: UILabel!
    @IBOutlet weak var labelCourseVal: UILabel!
    @IBOutlet weak var labelHeadingVal: UILabel!
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

