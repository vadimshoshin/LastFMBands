import Foundation

protocol DataFetcher {
    func fetchBands(for country: String, completion: @escaping (Result<[Band], Error>) -> Void)
    func fetchTracks(by bandID: String, completion: @escaping (Result<[Track], Error>) -> Void)
}

struct DataFetcherImpl: DataFetcher {
    let networking: Networking
    let database: DatabaseManager

    init(networking: Networking, database: DatabaseManager) {
        self.networking = networking
        self.database = database
    }
    
    func fetchBands(for country: String, completion: @escaping (Result<[Band], Error>) -> Void) {
        
        if Reachability.status {
            networking.getPopularBands(for: country, completion: completion)
        } else {
            let bands = database.fetchBands()
            completion(.success(bands))
        }
    }
    
    func fetchTracks(by bandID: String, completion: @escaping (Result<[Track], Error>) -> Void) {
        if Reachability.status {
            networking.getTopTracks(by: bandID, completion: completion)
        } else {
            let tracks = database.fetchTracks(with: bandID)
            completion(.success(tracks))
        }
    }
}
