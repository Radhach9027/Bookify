public enum BookifyTelemetry {

    private static var dispatcher: TelemetryDispatcher?
    private static var isConfigured = false

    public static func configure(_ configuration: TelemetryConfiguration) {
        guard !isConfigured else {
            #if DEBUG
            assertionFailure("⚠️ BookifyTelemetry is already configured.")
            #endif
            return
        }

        dispatcher = TelemetryDispatcher(configuration: configuration)
        isConfigured = true
    }

    public static func track(_ event: any TelemetryEvent) {
        guard let dispatcher else {
            #if DEBUG
            assertionFailure("⚠️ BookifyTelemetry is not configured.")
            #endif
            return
        }

        dispatcher.track(event)
    }
}
