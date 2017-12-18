//
//  ViewController.swift
//  wifidemo
//
//  Created by Dark Bears on 04/12/17.
//  Copyright © 2017 Dark Bear. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    var isProfileCreated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnCreateProfileTouched(_ sender: Any) {
        let btn = sender as! UIButton
//        btn.scaleDown()
        
        UIView.beginAnimations("ScaleButton", context: nil)
        UIView.setAnimationDuration(0.2)
        btn.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
        UIView.commitAnimations()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }

    @IBAction func btnCreateProfileTapped(_ sender: Any) {
        let btn = sender as! UIButton
//        btn.scaleUp()
        
        UIView.beginAnimations("ScaleButton", context: nil)
        UIView.setAnimationDuration(0.2)
        btn.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        UIView.commitAnimations()
        
        isProfileCreated = ConfigProfileCreator.generateMobileConfigProfile(with: "WiPi3", password: "wiifizone", autoJoin: true, hiddenNetwork: true, withDuration: 0)
//        if isProfileCreated {
//            btnInstallProfile.isEnabled = true
//        }
//        else {
//            btnInstallProfile.isEnabled = false
//        }
    }
    
    @IBAction func btnInstallProfileTapped(_ sender: Any) {
        weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
        print("\((appDelegate?._httpServer.port())!)")
        
        if isProfileCreated {
            if Float(UIDevice.current.systemVersion) ?? 0.0 < 10.0 {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open((URL(string: "http://localhost:\((appDelegate?._httpServer.port())!)/profile.mobileconfig"))!, options: [String : Any](), completionHandler: {(_ success: Bool) -> Void in
                        print("Profile URL Loaded.")
                    })
                } else {
                    // Fallback on earlier versions
                    print("\((appDelegate?._httpServer.port())!)")
                    print("http://localhost:\((appDelegate?._httpServer.port())!)/profile.mobileconfig")
                    UIApplication.shared.openURL((URL(string: "http://localhost:\((appDelegate?._httpServer.port())!)/profile.mobileconfig"))!)
                }
            }
            else {
                UIApplication.shared.openURL((URL(string: "http://localhost:\((appDelegate?._httpServer.port())!)/profile.mobileconfig"))!)
            }
        }
        else {
            print("Error generating profile")
        }
    }
}

extension UIButton {
    
    func scaleDown() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 1.0
        pulse.toValue = 0.70
//        pulse.autoreverses = true
        //pulse.repeatCount = 1
        //pulse.initialVelocity = 0.5
        //pulse.damping = 1.0
    
        layer.add(pulse, forKey: "scale")
    }
    
    func scaleUp() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.70
        pulse.toValue = 1.0
        //        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
}
