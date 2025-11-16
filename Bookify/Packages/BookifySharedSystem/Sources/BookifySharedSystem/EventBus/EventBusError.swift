//
//  EventBusError.swift
//  BookifySharedSystem
//
//  Created by radha chilamkurthy on 08/11/25.
//

import Foundation

public enum EventBusError: Error, LocalizedError {
    case noHandlerRegistered(String)
    public var errorDescription: String? {
        switch self {
        case .noHandlerRegistered(let t): return "No handler registered for \(t)"
        }
    }
}
