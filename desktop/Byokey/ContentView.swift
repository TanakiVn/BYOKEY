import SwiftUI
import ServiceManagement

struct ContentView: View {
    @State private var daemon = DaemonManager()

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Circle()
                    .fill(statusColor)
                    .frame(width: 10, height: 10)
                Text("Daemon: \(statusText)")
            }
            .font(.headline)

            HStack(spacing: 12) {
                Button("Enable") {
                    daemon.register()
                }
                .disabled(daemon.status == .enabled)

                Button("Disable") {
                    Task { await daemon.unregister() }
                }
                .disabled(daemon.status != .enabled)
            }

            if let error = daemon.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
                    .font(.caption)
            }
        }
        .padding(40)
        .onAppear {
            daemon.refresh()
        }
    }

    private var statusColor: Color {
        switch daemon.status {
        case .enabled: .green
        case .notRegistered: .gray
        case .notFound: .red
        case .requiresApproval: .orange
        @unknown default: .gray
        }
    }

    private var statusText: String {
        switch daemon.status {
        case .enabled: "Running"
        case .notRegistered: "Not Registered"
        case .notFound: "Not Found"
        case .requiresApproval: "Requires Approval"
        @unknown default: "Unknown"
        }
    }
}

#Preview {
    ContentView()
}
