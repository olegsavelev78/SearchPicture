import Combine
import Moya
import Foundation
import CombineMoya

enum SizeType: Int {
    case initial, large, medium, smale
    
    var description: String? {
        switch self {
        case .large:
            return "l"
        case .medium:
            return "m"
        case .smale:
            return "i"
        default: return nil
        }
    }
}

enum CountryType: Int {
    case initial, china, usa, russia
    
    var description: String? {
        switch self {
        case .china:
            return "cn"
        case .usa:
            return "us"
        case .russia:
            return "ru"
        default: return nil
        }
    }
}

enum LanguageType: Int {
    case initial, russian, armenian, english
    
    var description: String? {
        switch self {
        case .russian:
            return "ru"
        case .armenian:
            return "hy"
        case .english:
            return "en"
        default: return nil
        }
    }
}

enum LocationAPI {
    case fetchPicture(page: Int,
                      searchLine: String,
                      country: CountryType? = nil,
                      language: LanguageType? = nil,
                      size: SizeType? = nil)
}

extension LocationAPI: TargetType {
    var params: [String: Any] {
        switch self {
        case let .fetchPicture(page,
                               searchLine,
                               country,
                               language,
                               size):
            var params: [String: Any] = [:]
            params = [
                "api_key": Constants.Keys.apiKey,
                "q": searchLine,
                "ijn" : page,
                "tbm": "isch",
                "google_domain": "google.com",
                "tbs": "google.com",
            ]
            if let country = country {
                params["gl"] = country.description
            }
            
            if let language = language {
                params["hl"] = language.description
            }
            
            if let size = size {
                params["ic"] = size.description
            }
            
            debugPrint(params)
            return params
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
        case .fetchPicture:
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

protocol PictureService {
    func fetchPicture(page: Int,
                      searchLine: String,
                      country: CountryType?,
                      language: LanguageType?,
                      size: SizeType?) -> AnyPublisher<PictureData, MoyaError>
}

final class PictureServiceImp: PictureService {
    
    let moyaProvider = MoyaProvider<LocationAPI>()

    func fetchPicture(page: Int,
                      searchLine: String,
                      country: CountryType?,
                      language: LanguageType?,
                      size: SizeType?) -> AnyPublisher<PictureData, MoyaError> {
        return moyaProvider.requestPublisher(
            .fetchPicture(page: page,
                          searchLine: searchLine,
                          country: country, language: language,
                          size: size))
        .map(PictureData.self)
    }
}
