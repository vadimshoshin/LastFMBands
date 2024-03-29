import UIKit

protocol BandsViewModel {
    var onBandsLoaded: (() -> Void)? { get set }
    var onCountryChanged: (() -> Void)? { get set }
    func fetchBands()
    
    var numberOfItems: Int { get }
    func bandModel(at index: Int) -> BandCellModel
    var selectedCountry: String { get set }
    func processCountrySelection(selectedCountry: String)
    func processItemSelection(at index: Int)
}

class BandsViewModelImpl: BandsViewModel {
    let dataFetcher: DataFetcher
    let database: DatabaseManager
    
    weak var router: BandsRouter?
    
    var selectedCountry: String = "Ukraine" {
        didSet {
            onCountryChanged?()
            fetchBands()
        }
    }
    
    var onCountryChanged: (() -> Void)?
    var onBandsLoaded: (() -> Void)?
    
    var bands: [Band] = []
    
    init(with dependencies: AppDependencies) {
        dataFetcher = dependencies.dataFetcher
        database = dependencies.databaseManager
    }
    
    var numberOfItems: Int {
        return bands.count
    }
    
    func fetchBands() {
        dataFetcher.fetchBands(for: selectedCountry) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let bands):
                let sorted = bands.sorted(by: { $0.name ?? "" < $1.name ?? "" })
                self.bands = sorted
                self.onBandsLoaded?()
                self.database.store(items: sorted)
                
                let fetchedBands = self.database.fetchBands()
                debugPrint("local bands - \(fetchedBands)")
                
            case .failure(let error):
                let bands  = self.database.fetchBands()
                let sorted = bands.sorted(by: { $0.name ?? "" < $1.name ?? "" })
                self.bands = sorted
                self.onBandsLoaded?()
                debugPrint(error)
            }
        }
    }
    
    func bandModel(at index: Int) -> BandCellModel {
        let band = bands[index]
        let bandImageURL = bandImageUrl(band)
        return BandCellModel(bandName: band.name ?? "", bandImageURL: bandImageURL, listeners: band.listeners ?? "")
    }
    
    private func bandImageUrl(_ band: Band) -> String {
        
        let imagesList = band.artistPhoto
        return imagesList.first?.url ?? ""
    }
    
    func processCountrySelection(selectedCountry: String) {
        self.selectedCountry = selectedCountry
    }
    
    func processItemSelection(at index: Int) {
        let selectedBand = bands[index]
        let bandID = selectedBand.mbid
        router?.showDetailsScreen(for: bandID ?? "")
    }
}
