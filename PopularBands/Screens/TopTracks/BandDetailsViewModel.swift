import UIKit

protocol BandDetailsViewModel {
    func bandName() -> String
}

class BandDetailsViewModelImpl: BandDetailsViewModel {
    let bandsManager: BandsManager
    let database: DatabaseManager
    
    weak var router: BandDetailsRouter?
    
    var selectedBandId: String!
    
    init(with dependencies: AppDependencies) {
        bandsManager = dependencies.bandsManager
        database = dependencies.databaseManager
    }
    
    func bandName() -> String {
        return selectedBandId
    }
}