import ServiceManagement

@Observable
final class DaemonManager {
    private(set) var status: SMAppService.Status = .notRegistered
    private(set) var errorMessage: String?

    private var service: SMAppService {
        SMAppService.agent(plistName: "io.byokey.desktop.daemon.plist")
    }

    func refresh() {
        status = service.status
    }

    func register() {
        errorMessage = nil
        do {
            try service.register()
        } catch {
            errorMessage = error.localizedDescription
        }
        refresh()
    }

    func unregister() async {
        errorMessage = nil
        do {
            try await service.unregister()
        } catch {
            errorMessage = error.localizedDescription
        }
        refresh()
    }
}
