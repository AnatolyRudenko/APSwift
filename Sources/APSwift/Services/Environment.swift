//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 09.06.2022.
//

import Foundation

enum Environment {
    
    static var isTest: Bool {
        isTestFlight || isDebug
    }
    
    private static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
    
    private static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
