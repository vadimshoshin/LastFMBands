import Alamofire

enum APIRouter {
    
    private static let baseURL = URL(string: "https://ws.audioscrobbler.com/2.0/")!
    
    case bands(country: String)
    case topTracks(bandID: String)
    
    private var method: String {
        switch self {
        case .bands, .topTracks:
            return "GET"
        }
    }
    
    func asURLRequest(params: Parameters? = nil) throws -> URLRequest {
        let url = APIRouter.baseURL
        var urlRequest = URLRequest(url: url)

        do {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
            urlRequest.httpMethod = method
            return urlRequest
        } catch let error {
            debugPrint(error)
            return urlRequest
        }
    }
}
