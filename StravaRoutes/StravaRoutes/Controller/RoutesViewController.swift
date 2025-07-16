import SwiftUI

class RoutesViewController: ObservableObject {
    @Published var routes: [Route] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let routeService = RoutesJSONLoader()

    @MainActor
    func fetchRoutes() async throws {
        isLoading = true
        errorMessage = nil

        let data = try await routeService.loadData()

        do {
            let decodedData = try JSONDecoder().decode([Route].self, from: data)
            self.routes = decodedData
            isLoading = false
        } catch let jsonError {
            errorMessage = "Could not decode data: \(jsonError)"
            isLoading = false
        }
    }
}
