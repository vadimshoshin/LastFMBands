import Foundation

struct AppDependencies {
    let networkManager: Networking
    let dataFetcher: DataFetcher
    let databaseManager: DatabaseManager
    
    init() {
        networkManager = NetworkManager()
        dataFetcher = DataFetcherImpl(networking: networkManager)
        databaseManager = RealmManager()
    }
}
