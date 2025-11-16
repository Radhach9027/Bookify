//
//  ContractReader.swift
//  BookifyDomainKit
//
//  Created by radha chilamkurthy on 10/11/25.
//
import Foundation
import BookifySharedSystem

enum ContractLoader {
    
    static func load<T: Decodable>(
        _ name: String,
        ext: String = "json",
        subdir: String? = nil
    ) throws -> T {
        
        #if SWIFT_PACKAGE
        let bundle = Bundle.module
        #else
        let bundle = Bundle.main
        #endif
        
        return try bundle.decodeJSON(
            T.self,
            named: name,
            withExtension: ext,
            subdirectory: subdir
        )
    }
}

