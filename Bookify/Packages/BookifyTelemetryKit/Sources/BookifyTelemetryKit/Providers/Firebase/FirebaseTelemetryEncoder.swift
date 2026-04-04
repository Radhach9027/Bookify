//
//  FirebaseTelemetryEncoder.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

public struct FirebaseTelemetryEncoder {
    private let eventNameMapper: FirebaseEventNameMapping
    private let parameterMapper: FirebaseParameterMapping
    private let contextInclusionPolicy: FirebaseContextInclusionPolicy

    public init(
        eventNameMapper: FirebaseEventNameMapping = DefaultFirebaseEventNameMapper(),
        parameterMapper: FirebaseParameterMapping = DefaultFirebaseParameterMapper(),
        contextInclusionPolicy: FirebaseContextInclusionPolicy = .none
    ) {
        self.eventNameMapper = eventNameMapper
        self.parameterMapper = parameterMapper
        self.contextInclusionPolicy = contextInclusionPolicy
    }

    public func encode(
        event: any TelemetryEvent,
        context: TelemetryContext
    ) -> FirebaseTelemetryPayload {
        let mappedEventName = eventNameMapper.map(event.name)
        var mappedParameters = parameterMapper.map(event.parameters)

        let contextParameters = encodeContext(context)
        if !contextParameters.isEmpty {
            mappedParameters.merge(contextParameters) { current, _ in current }
        }

        return FirebaseTelemetryPayload(
            eventName: mappedEventName,
            parameters: mappedParameters
        )
    }

    private func encodeContext(_ context: TelemetryContext) -> [String: Any] {
        switch contextInclusionPolicy {
        case .none:
            return [:]

        case .defaultFields:
            var result: [String: Any] = [:]

            let rawContext: [String: String] = [
                "app_name": context.appName,
                "app_version": context.appVersion,
                "build_number": context.buildNumber,
                "platform": context.platform,
                "environment": context.environment
            ]

            for (key, value) in rawContext {
                let normalizedKey = key.normalizedFirebaseName(maxLength: 40)
                guard !normalizedKey.isEmpty else { continue }
                result[normalizedKey] = value
            }

            return result
        }
    }
}
