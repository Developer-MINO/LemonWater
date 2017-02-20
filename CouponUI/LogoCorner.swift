//
//  LogoCorner.swift
//  MemebershipCoupon
//
//  Created by 김지섭 on 2017. 2. 8..
//  Copyright © 2017년 mino. All rights reserved.
//

import Foundation
import UIKit

private var logoCorner = false


extension UIImageView {
    @IBInspectable var logoCornerDesign : Bool {
        get {
            return logoCorner
        }
        
        set{
            logoCorner = newValue
                if logoCorner {
                    
                    self.layer.borderColor = UIColor(red: 233/255.0, green: 233/255.0, blue: 233/255.0, alpha: 1.0).cgColor
                    if UIScreen.main.bounds.width == 320 {
                        self.layer.borderWidth = 1.5
                        if self.frame.width > 100 {
                            self.layer.cornerRadius = 20
                        } else {
                            self.layer.cornerRadius = 10
                        }

                    } else {
                        self.layer.borderWidth = 2
                        if self.frame.width > 100 {
                            self.layer.cornerRadius = 25
                        } else {
                            self.layer.cornerRadius = 15
                        }
                        
                    }
                    
                } else {
                    self.layer.borderWidth = 0
                    self.layer.cornerRadius = 0
            }
        }
    }
}
