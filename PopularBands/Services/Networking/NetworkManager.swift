import Foundation
import Alamofire

protocol Networking {
    func getPopularBands(for country: String, completion: @escaping (Swift.Result<[Band], Error>) -> Void)
    func getTopTracks(by bandID: String, completion: @escaping (Swift.Result<[Track], Error>) -> Void)
}

struct TopBandsWrapper: Codable {
    let topartists: ArtistsWrapper
}

struct ArtistsWrapper: Codable {
    let artist: [Band]
}

struct TopTracksWrapper: Codable {
    let toptracks: TracksWrapper
}

struct TracksWrapper: Codable {
    let track: [Track]
}

class NetworkManager: Networking {
    func getPopularBands(for country: String, completion: @escaping  (Swift.Result<[Band], Error>) -> Void) {
        
        let params = [ "api_key": "e81f61890b7ff8633ca024d0faa449e7",
                        "format": "json",
                        "country": country,
                        "method": "geo.gettopartists" ]
        
        guard let request = try? APIRouter.bands(country: "Ukraine").asURLRequest(params: params) else {
            debugPrint("request creation error")
            return
        }
        
        
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let responseWrapper = try decoder.decode(TopBandsWrapper.self, from: data)
                    let artists = responseWrapper.topartists.artist
                    completion(.success(artists))
                } catch let error {
                    debugPrint("Parsing error - \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                debugPrint("error - \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func getTopTracks(by bandID: String, completion: @escaping (Swift.Result<[Track], Error>) -> Void) {
        let params = [ "api_key": "e81f61890b7ff8633ca024d0faa449e7",
                        "format": "json",
                        "mbid": bandID,
                        "method": "artist.gettoptracks" ]
        
        guard let request = try? APIRouter.topTracks(bandID: bandID).asURLRequest(params: params) else {
            debugPrint("request creation error")
            return
        }
        
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let responseWrapper = try decoder.decode(TopTracksWrapper.self, from: data)
                    let tracks = responseWrapper.toptracks.track
                    completion(.success(tracks))
                } catch let error {
                    debugPrint("Parsing error - \(error)")
                    completion(.failure(error))
                }
                
                
            case .failure(let error):
                debugPrint("tracks fetching error - \(error)")
                completion(.failure(error))
            }
        }
    }
}
