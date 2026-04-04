//
//  FirebaseTelemetryProvider.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

/*
 
TODO: Use when u have FirebaseAnalytics implemented
 import Foundation
 import FirebaseAnalytics

 public struct FirebaseTelemetryProvider: TelemetryProvider {
     private let encoder: FirebaseTelemetryEncoder

     public init(
         encoder: FirebaseTelemetryEncoder = FirebaseTelemetryEncoder()
     ) {
         self.encoder = encoder
     }

     public func track(event: any TelemetryEvent, context: TelemetryContext) {
         let payload = encoder.encode(event: event, context: context)

         guard !payload.eventName.isEmpty else {
             #if DEBUG
             assertionFailure("Firebase event name cannot be empty.")
             #endif
             return
         }

         Analytics.logEvent(payload.eventName, parameters: payload.parameters)
     }
 }
*/
