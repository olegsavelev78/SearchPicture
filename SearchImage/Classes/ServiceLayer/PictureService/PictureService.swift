import Combine
import Moya
import Foundation
import CombineMoya

enum PictureService {
    case fetchPicture(page: Int, searchLine: String)
}

extension PictureService: TargetType {
    var params: [String: Any] {
        switch self {
        case .fetchPicture(page: let page, searchLine: let searchLine):
            return [
                "apiKey": Constants.Keys.apiKey,
                "q": searchLine,
                "page": page,
                "num": 20,
                "engine": "google"
            ]
        }
    }
    var baseURL: URL { URL(string: "https://serpapi.com")! }
    
    var path: String {
        switch self {
        case .fetchPicture:
            return "search.json"
        }
    }
    var method: Moya.Method {
        switch self {
        case .fetchPicture:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .fetchPicture: // Send no parameters
            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.queryString
            )
        }
    }
    var sampleData: Data { .init() }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}

protocol PictureService1 {
    func fetchPicture(page: Int, searchLine: String) -> AnyPublisher<Response, MoyaError>
}

final class PictureServiceImp: PictureService1 {

    private let moyaProvider = MoyaProvider<PictureService>()

    func fetchPicture(page: Int, searchLine: String = "") -> AnyPublisher<Response, MoyaError> {
        return moyaProvider.requestPublisher(.fetchPicture(page: page, searchLine: searchLine))
    }
}
