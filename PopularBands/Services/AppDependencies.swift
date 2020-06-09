import Foundation

struct AppDependencies {
    let networkManager: Networking
    let bandsManager: BandsManager
    let databaseManager: DatabaseManager
    
    init() {
        networkManager = NetworkManager()
        bandsManager = BandsManagerImpl(networking: networkManager)
        databaseManager = RealmManager()
    }
}
