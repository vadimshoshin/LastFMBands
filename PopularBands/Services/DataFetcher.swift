import Foundation

protocol DataFetcher {
    func fetchBands(for country: String, completion: @escaping (Result<[Band], Error>) -> Void)
    func fetchTracks(by bandID: String, completion: @escaping (Result<[Track], Error>) -> Void)
}

struct DataFetcherImpl: DataFetcher {
    let networking: Networking

    init(networking: Networking) {
        self.networking = networking
    }
    
    func fetchBands(for country: String, completion: @escaping (Result<[Band], Error>) -> Void) {
        networking.getPopularBands(for: country) { result in
            switch result {
            case .success(let bands):
                completion(.success(bands))
                
            case .failure(let error):
                debugPrint("bands fetching error - \(error)")
            }
        }
    }
    
    func fetchTracks(by bandID: String, completion: @escaping (Result<[Track], Error>) -> Void) {
        networking.getTopTracks(by: bandID, completion: completion)
    }
    
}
