//
//  ConfigProfileCreator.swift
//  wifidemo
//
//  Created by Dark Bears on 04/12/17.
//  Copyright © 2017 Dark Bear. All rights reserved.
//

import UIKit

class ConfigProfileCreator {
    class func generateMobileConfigProfile(_ strName: String) -> Bool {
        //    NSFileManager *fileManager = [NSFileManager defaultManager];
        let strWiFiUUID: String = UUID().uuidString
        let dictPayloadContent = NSDictionary.init(objects:([true, "WPA", false, false, "DarkBe@rs", "Configures Wi-Fi settings", "Wi-Fi", "com.apple.wifi.managed.\(strWiFiUUID)", "com.apple.wifi.managed", strWiFiUUID, 1, "None", "DBWSG", false, false]  as! [NSCopying]) , forKeys: (["AutoJoin", "EncryptionType", "HIDDEN_NETWORK", "IsHotspot", "Password", "PayloadDescription", "PayloadDisplayName", "PayloadIdentifier", "PayloadType", "PayloadUUID", "PayloadVersion", "ProxyType", "SSID_STR", "ServiceProviderRoamingEnabled", "_UsingHotspot20"] as NSCopying) as! [NSCopying])
        let arrPayloadContents = [dictPayloadContent]
        let strCommonUUID: String = UUID().uuidString
        let dictWiFiPayloadContent = NSDictionary.init(objects:(["Configuration", 1, "com.dbw.ConfigProfileDemo.\(strCommonUUID)", strCommonUUID, "MY New Profile", "Press \"Install\" to get WiFi access.", "DARK BEARS", arrPayloadContents, 30] as! [NSCopying]), forKeys: (["PayloadType", "PayloadVersion", "PayloadIdentifier", "PayloadUUID", "PayloadDisplayName", "PayloadDescription", "PayloadOrganization", "PayloadContent", "DurationUntilRemoval"] as [NSCopying]))
        let isFileWritten: Bool = dictWiFiPayloadContent.write(toFile: ConfigProfileCreator.strProfilePath(), atomically: true)
        if isFileWritten {
            print("Profile created successfully")
            return true
        }
        else {
            print("Failed to create Profile")
            return false
        }
    }
    
    class func generateMobileConfigProfile(with strSSID: String, password strPassword: String, autoJoin isAutoJoin: Bool, hiddenNetwork isHiddenNetwork: Bool, withDuration duration: Int) -> Bool {
        let strWiFiUUID: String = UUID().uuidString
        let dictPayloadContent = NSDictionary.init(objects:([isAutoJoin, "WPA", isHiddenNetwork, false, strPassword, "Configures Wi-Fi settings", "Wi-Fi", "com.apple.wifi.managed.\(strWiFiUUID)", "com.apple.wifi.managed", strWiFiUUID, 1, "None", strSSID, false, false]) as! [NSCopying], forKeys: (["AutoJoin", "EncryptionType" as NSCopying, "HIDDEN_NETWORK", "IsHotspot", "Password", "PayloadDescription", "PayloadDisplayName", "PayloadIdentifier", "PayloadType", "PayloadUUID", "PayloadVersion", "ProxyType", "SSID_STR", "ServiceProviderRoamingEnabled", "_UsingHotspot20"]) as! [NSCopying])
        let arrPayloadContents = [dictPayloadContent]
        let strCommonUUID: String = UUID().uuidString
        var dictWiFiPayloadContent: NSDictionary
        if duration == 0 {
            dictWiFiPayloadContent = NSDictionary.init(objects: (["Configuration", 1, "com.dbw.ConfigProfileDemo.\(strCommonUUID)", strCommonUUID, "MY New Profile", "Press \"Install\" to get WiFi access.", "DARK BEARS", arrPayloadContents])  as! [NSCopying], forKeys: (["PayloadType", "PayloadVersion", "PayloadIdentifier", "PayloadUUID", "PayloadDisplayName", "PayloadDescription", "PayloadOrganization", "PayloadContent"]) as [NSCopying])
        }
        else {
            dictWiFiPayloadContent = NSDictionary.init(objects: (["Configuration", 1, "com.dbw.ConfigProfileDemo.\(strCommonUUID)", strCommonUUID, "MY New Profile", "Press \"Install\" to get WiFi access.", "DARK BEARS", arrPayloadContents, duration]) as! [NSCopying], forKeys: ["PayloadType", "PayloadVersion", "PayloadIdentifier", "PayloadUUID", "PayloadDisplayName", "PayloadDescription", "PayloadOrganization", "PayloadContent", "DurationUntilRemoval"] as [NSCopying])
        }
        let isFileWritten: Bool = dictWiFiPayloadContent.write(toFile: ConfigProfileCreator.strProfilePath(), atomically: true)
        if isFileWritten {
            print("Profile created successfully")
            return true
        }
        else {
            print("Failed to create Profile")
            return false
        }
    }
    
    class func strProfilePath() -> String {
        let documentsDirectory: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        let path: String = URL(fileURLWithPath: documentsDirectory).appendingPathComponent("profile.mobileconfig").absoluteString
        let path: String =  documentsDirectory.appending("/profile.mobileconfig")
        print("\(path)")
        return path
    }
    
}
