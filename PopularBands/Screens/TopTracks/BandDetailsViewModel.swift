import UIKit

protocol BandDetailsViewModel {
    var onDataUpdated: (() -> Void)? { get set } 
    func bandName() -> String
    func fetchData()
}

class BandDetailsViewModelImpl: BandDetailsViewModel {
    let bandsManager: BandsManager
    let database: DatabaseManager
    
    weak var router: BandDetailsRouter?
    
    var selectedBandId: String!
    
    var onDataUpdated: (() -> Void)?
    
    init(with dependencies: AppDependencies) {
        bandsManager = dependencies.bandsManager
        database = dependencies.databaseManager
    }
    
    func bandName() -> String {
        guard let band = database.fetchBand(with: selectedBandId) else {
            return ""
        }
        
        return band.name
    }
    
    func fetchData() {
        bandsManager.fetchTracks(by: selectedBandId) { result in
            switch result {
            case .success(let tracks):
                debugPrint("received tracks - \(tracks)")
            case .failure(let error):
                debugPrint("fetching error - \(error)")
            }
        }
    }
}
