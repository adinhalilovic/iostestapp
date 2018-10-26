//
//  StoryboardAttributes+Custom.swift
//  TestApp
//
//  Created by Mahmutović Edin on 25/10/2018.
//  Copyright © 2018 Adin Halilovic. All rights reserved.
//
import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var bgColor: String {
        get {
            return ""
        }
        set {
            backgroundColor = ColorHelper.color(from: newValue)
        }
    }
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
