import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidRequest
    case invalidResponse
    case decodingError(DecodingError)
    case serverError(code: Int, message: String)
    case networkError(Error)
    case noInternetConnection
    case timeoutError
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidRequest:
            return "Invalid request"
        case .invalidResponse:
            return "Invalid response from server"
        case let .decodingError(error):
            return "Failed to decode response: \(error.localizedDescription)"
        case let .serverError(code, message):
            return "Server error (\(code)): \(message)"
        case let .networkError(error):
            return "Network error: \(error.localizedDescription)"
        case .noInternetConnection:
            return "No internet connection"
        case .timeoutError:
            return "Request timeout"
        case .unknown:
            return "Unknown error"
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .noInternetConnection:
            return "Please check your internet connection and try again."
        case .timeoutError:
            return "The request took too long. Please try again."
        case .serverError(let code, _) where code >= 500:
            return "The server is having issues. Please try again later."
        default:
            return "Please try again."
        }
    }
}
