import Foundation

struct AppDependencies {
    let networkManager: Networking
    let dataFetcher: DataFetcher
    let databaseManager: DatabaseManager
    
    init() {
        networkManager = NetworkManager()
        databaseManager = RealmManager()
        dataFetcher = DataFetcherImpl(networking: networkManager, database: databaseManager)
    }
}
