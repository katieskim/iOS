import UIKit

/// Asynchronously loads an image from the network
/// - Parameter url: The URL to request the image from
/// - Throws: If there are network failures
/// - Returns: A valid image or `nil` if the data was not an image
func loadImage(from url: URL) async throws -> UIImage? {
    try await withCheckedThrowingContinuation { continuation in
        do {
            let data = try Data(contentsOf: url)
            continuation.resume(returning: .init(data: data))
        } catch {
            continuation.resume(throwing: error)
        }
    }
}

/// Asynchronously loads an image from the network
/// - Parameters:
///   - url: The URL to request the image from
///   - completion: Will be called on the `main` queue
func loadImage(
    from url: URL,
    completion: @escaping @Sendable (Result<UIImage?, Error>) -> Void
) {
    Task(priority: .medium) { @MainActor in
        do {
            let image = try await loadImage(from: url)
            completion(.success(image))
        } catch {
            completion(.failure(error))
        }
    }
}
