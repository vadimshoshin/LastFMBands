import UIKit

protocol BandDetailsViewModel {
    var onDataUpdated: (() -> Void)? { get set } 
    func bandName() -> String
    func fetchData()
    func bandImageUrl(completion: @escaping (String) -> Void)
    var onBandSetup: (() -> Void)? { get set }
}

class BandDetailsViewModelImpl: BandDetailsViewModel {
    let dataFetcher: DataFetcher
    let database: DatabaseManager
    
    weak var router: BandDetailsRouter?
    
    var selectedBandId: String! {
        didSet {
            onBandSetup?()
        }
    }
    
    var onDataUpdated: (() -> Void)?
    var onBandSetup: (() -> Void)?
    var topTracks: [Track] = []
    
    init(with dependencies: AppDependencies) {
        dataFetcher = dependencies.dataFetcher
        database = dependencies.databaseManager
    }
    
    func bandName() -> String {
        guard let band = database.fetchBand(with: selectedBandId) else {
            return ""
        }
        
        return band.name ?? ""
    }
    
    func bandImageUrl(completion: @escaping (String) -> Void) {
        guard let band = database.fetchBand(with: selectedBandId) else {
            return
        }
        
        let imagesList = band.artistPhoto
        let topResolution = imagesList.first(where: {$0.size == "extralarge"} )
        completion(topResolution?.url ?? "")
    }
    
    func fetchData() {
        dataFetcher.fetchTracks(by: selectedBandId) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let tracks):
                debugPrint("received tracks - \(tracks)")
                let sortedTracks = tracks.sorted(by: { $0.name < $1.name })
                self.topTracks = sortedTracks
                self.database.store(items: sortedTracks)

            case .failure(let error):
                let tracks  = self.database.fetchTracks(with: self.selectedBandId)
                let sorted = tracks.sorted(by: { $0.name < $1.name })
                self.topTracks = sorted
                self.onDataUpdated?()
                debugPrint("fetching error - \(error)")
                
            }
        }
    }
}
