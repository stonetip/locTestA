//
//  CompassClass.swift
//  locTestA
//
//  Created by Jonathan Nehring on 3/26/17.
//  Copyright © 2017 Stonetip. All rights reserved.
//

import UIKit

@IBDesignable
class CompassClass: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        CompassRose.drawCanvas1()
    }
 

}
