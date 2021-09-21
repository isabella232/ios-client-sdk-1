//
//  ViewController.swift
//  Share
//
//  Created by George Sealy on 21/06/21.
//

import UIKit
import ReplayKit
import BJNClientSDK

class ViewController: UIViewController {

    var meetingService: MeetingService!
    var contentShareService: ContentShareServiceProtocol!
    
    var pickerView: UIView?
    
    override func viewDidLoad() {
        
        // Set the parameters for content share.
        let contentShareParameters = BJNContentShareParameters(
            // If this is true, then we will have to call `contentShareService.confirmScreenShare()`
            // to confirm that we want to take over another participants screen share,
            // if this is false then we will always take it over without asking.
            requireConfirmationBeforeHijacking: false,
            
            // This will provide a message that will be used by the broadcast extension when it stops to display an alert to the user.
            // You can customise the message based on the stop reason, and availability before the broadcast was stopped.
            messageProvider: { stopReason, availability in
                return "Content Sharing has stopped due to \(stopReason.rawValue), the availability before stopping was \(availability.rawValue)"
        })
            
        // Initialize the SDK with these parameters *before* accessing any of the services.
        BlueJeansSDK.initialize(contentShareParameters: contentShareParameters, is5x5GalleryLayoutEnabled: false)
        
        // Assign the required services
        meetingService = BlueJeansSDK.meetingService
        contentShareService = meetingService.contentShareService
        
        // Add the RPSystemBroadcastPickerView, which can be used to initiate screen share
        addRPSystemBroadcastPickerView()
        
        // Hide or show the picker based on the availability,
        // out of meeting this will be nil. So the picker will start off hidden.
        hideOrShowPicker()
        
        // Watch the observables in the contentShareService, the changes in these could be used to drive state, or provide alerts to the user.
        contentShareService.contentShareAvailability.onChange { [unowned self] in
            // If availability changes, we should show or hide the picker based on this.
            hideOrShowPicker()
            NSLog("[SHARE] availability: \(String(describing: self.contentShareService.contentShareAvailability.value))")
        }
        
        contentShareService.contentShareExtensionStatus.onChange { [unowned self] in
            NSLog("[SHARE] extensionStatus: \(String(describing: self.contentShareService.contentShareExtensionStatus.value))")
        }
        
        contentShareService.contentShareStopReason.onChange { [unowned self] in
            NSLog("[SHARE] stopReason: \(String(describing: self.contentShareService.contentShareStopReason.value))")
        }
        
        self.view.backgroundColor = .orange
        NSLog("[SHARE] joining")
        
        // TODO: Fill in your own meeting ID and passocde here
        meetingService.join(meetingID: "", passcode: "", displayName: "John Doe") { [unowned self] meetingJoinResult in
            
            if meetingJoinResult == .success {
                NSLog("[SHARE] Join meeting: Success")
                self.view.backgroundColor = .darkGray
            } else {
                NSLog("[SHARE] Join meeting Failed: \(meetingJoinResult.rawValue)")
                self.view.backgroundColor = .red
            }
            
        }
    }
    
    func hideOrShowPicker() {
        let availability = self.contentShareService.contentShareAvailability.value

        switch availability {
        case .available, .hijackingAvailable:
            // If content share is available, show the picker
            pickerView?.isHidden = false
            pickerView?.isUserInteractionEnabled = true
        default:
            // Otherwise hide the picker
            pickerView?.isHidden = true
            pickerView?.isUserInteractionEnabled = false
        }
    }

    func addRPSystemBroadcastPickerView() {
        
        guard self.pickerView == nil else { return }
        
        let pickerViewDiameter: CGFloat = 44
        let pickerView = RPSystemBroadcastPickerView(frame: CGRect(x: 0, y: 0,
                                                                   width: pickerViewDiameter,
                                                                   height: pickerViewDiameter))
        // TODO: Replace this with your own Broadcast Extension bundle identifier
        pickerView.preferredExtension = "com.youruniqueid.share.broadcastExtension"

        // Microphone audio is passed through the main application instead of
        // the broadcast extension.
        pickerView.showsMicrophoneButton = false
        
        view.addSubview(pickerView)

        // Setup layout constraints
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.widthAnchor.constraint(equalToConstant: pickerViewDiameter).isActive = true
        pickerView.heightAnchor.constraint(equalToConstant: pickerViewDiameter).isActive = true
        pickerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
        self.pickerView = pickerView
    }
}

