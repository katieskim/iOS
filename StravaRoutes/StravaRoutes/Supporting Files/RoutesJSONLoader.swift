import Foundation

struct RoutesJSONLoader {
    /// Loads in a list of routes
    /// - Throws: If there's an error fetching, or reading the data, or if there's no data
    /// - Returns: `Data` that represents a list of routes
    func loadData() async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            load(completionHandler: continuation.resume(with:))
        }
    }

    /// Loads in a list of routes
    /// - Parameter completionHandler: May be called on any queue
    func load(
        completionHandler: @escaping (Result<Data, LoadingError>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async {
            switch try? loadBundleData(forResource: "routes", ofType: "json") {
            case let .some(data):
                completionHandler(.success(data))
            case .none:
                completionHandler(.failure(LoadingError()))
            }
        }
    }

    struct LoadingError: Error {}
}

private func loadBundleData(
    forResource resource: String,
    ofType type: String
) throws -> Data? {
    try Bundle.main.path(forResource: resource, ofType: type)
        .map(URL.init(fileURLWithPath:))
        .map { try Data(contentsOf: $0) }
}
