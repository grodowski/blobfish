//
//  UserAlertMessages.swift
//  Happy Blobfish
//
//  Created by Lukasz on 21/03/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Foundation
import Cocoa

protocol UserAlertMessages {
    func showFailureModal(title: String, description: String)
}

extension NSViewController: UserAlertMessages {
    func showFailureModal(title: String, description: String) {
        let alert = NSAlert.init()
        alert.messageText = title
        alert.informativeText = description
        alert.runModal()
    }
}