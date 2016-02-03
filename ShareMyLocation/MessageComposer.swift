//
//  MessageComposer.swift
//  ShareMyLocation
//
//  Created by Vikash Loomba on 2/2/16.
//  Copyright © 2016 Loomba Apps. All rights reserved.
//

import Foundation
import MessageUI
import CoreLocation

class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
    let mapURL = "http://maps.apple.com/?";
    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController(location: CLLocation) -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self
        //  Make sure to set this property to self, so that the controller can be dismissed!
        messageComposeVC.body = "\(mapURL)+q=My+Location&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)";
        return messageComposeVC
    }
    
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
