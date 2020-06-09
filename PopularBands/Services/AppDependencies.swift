import Foundation

struct AppDependencies {
    let networkManager: Networking
    let bandsManager: BandsManager
    
    init() {
        networkManager = NetworkManager()
        bandsManager = BandsManagerImpl(networking: networkManager)
    }
}
