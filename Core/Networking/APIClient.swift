import Foundation
import Alamofire

actor APIClient {
    static let shared = APIClient()

    let baseURL: URL
    private var defaultHeaders: HTTPHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]

    init(baseURL: String = "https://api.example.com") {
        self.baseURL = URL(string: baseURL) ?? URL(fileURLWithPath: "")
    }

    func setAuthorizationToken(_ token: String) {
        defaultHeaders["Authorization"] = "Bearer \(token)"
    }

    func request<T: Decodable>(
        _ endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        encoding: ParameterEncoding = JSONEncoding.default
    ) async throws -> T {
        let url = baseURL.appendingPathComponent(endpoint)

        #if DEBUG
        print("[APIClient] Request: \(method.rawValue) \(url.absoluteString)")
        if let parameters = parameters {
            print("[APIClient] Parameters: \(parameters)")
        }
        #endif

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: defaultHeaders
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case let .success(value):
                    #if DEBUG
                    print("[APIClient] Success: \(endpoint)")
                    #endif
                    continuation.resume(returning: value)

                case let .failure(error):
                    #if DEBUG
                    print("[APIClient] Error: \(error.localizedDescription)")
                    #endif
                    let networkError = self.mapError(error, response: response.response)
                    continuation.resume(throwing: networkError)
                }
            }
        }
    }

    func requestData(
        _ endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil
    ) async throws -> Data {
        let url = baseURL.appendingPathComponent(endpoint)

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: method,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: defaultHeaders
            )
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(data):
                    continuation.resume(returning: data)

                case let .failure(error):
                    let networkError = self.mapError(error, response: response.response)
                    continuation.resume(throwing: networkError)
                }
            }
        }
    }

    private func mapError(_ error: AFError, response: HTTPURLResponse?) -> NetworkError {
        if let statusCode = response?.statusCode, statusCode >= 400 {
            return .serverError(code: statusCode, message: "HTTP \(statusCode)")
        }

        switch error {
        case .sessionDeinitialized:
            return .networkError(error)
        case .invalidURL:
            return .invalidURL
        case .parameterEncodingFailed:
            return .invalidRequest
        case .responseSerializationFailed:
            return .invalidResponse
        case .requestRetryFailed:
            return .networkError(error)
        case .sessionTaskFailed(let error):
            if (error as NSError).code == NSURLErrorTimedOut {
                return .timeoutError
            }
            if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                return .noInternetConnection
            }
            return .networkError(error)
        case .responseValidationFailed:
            return .invalidResponse
        case .requestAdaptationFailed:
            return .invalidRequest
        case .createUploadableFailed:
            return .invalidRequest
        case .createURLRequestFailed:
            return .invalidURL
        case .downloadedFileMoveFailed:
            return .networkError(error)
        case .multipartEncodingFailed:
            return .invalidRequest
        case .requestCancelled:
            return .unknown
        case .explicitlyCancelled:
            return .unknown
        @unknown default:
            return .unknown
        }
    }
}

// MARK: - Codable Models

struct APIResponse<T: Codable>: Codable {
    let success: Bool
    let data: T?
    let message: String?
    let error: String?
}
