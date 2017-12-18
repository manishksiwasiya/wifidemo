//
//  AppDelegate.swift
//  wifidemo
//
//  Created by Dark Bears on 04/12/17.
//  Copyright © 2017 Dark Bear. All rights reserved.
//

import UIKit
import CocoaHTTPServer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var _httpServer: HTTPServer!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        startServer()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func startServer() {
        // Create server using our custom MyHTTPServer class
        _httpServer = HTTPServer.init()
        
        // Tell the server to broadcast its presence via Bonjour.
        // This allows browsers such as Safari to automatically discover our service.
        _httpServer.setType("_http._tcp.")
        
        // Normally there's no need to run our server on any specific port.
        // Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
        // However, for easy testing you may want force a certain port so you can just hit the refresh button.
        _httpServer.setPort(12345)
        
        // Serve files from documents directory
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        _httpServer.setDocumentRoot(documentsDirectory)
        
        if _httpServer.isRunning() {
            _httpServer.stop()
        }
        let error: NSError!
        
        do {
            try _httpServer.start()
            print("Started HTTP Server on port \(_httpServer.listeningPort())")
//            } else {
//                startServer()
//            }
        } catch {
            startServer()
            print(error)
        }
    }
}

/*- (void)startServer
    {
 
        
        // Serve files from documents directory
        
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        [_httpServer setDocumentRoot:documentsDirectory];
        
        if (_httpServer.isRunning) [_httpServer stop];
        
        NSError *error;
        if([_httpServer start:&error])
        {
            NSLog(@"Started HTTP Server on port %hu", [_httpServer listeningPort]);
        }
        else
        {
            NSLog(@"Error starting HTTP Server: %@", error);
            // Probably should add an escape - but in practice never loops more than twice (bug filed on GitHub https://github.com/robbiehanson/CocoaHTTPServer/issues/88)
            [self startServer];
        }
}*/
