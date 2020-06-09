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
    let bandsManager: BandsManager
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
        bandsManager = dependencies.bandsManager
        database = dependencies.databaseManager
    }
    
    var numberOfItems: Int {
        return bands.count
    }
    
    func fetchBands() {
        bandsManager.fetchBands(for: selectedCountry) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let bands):
                let sorted = bands.sorted(by: { $0.name < $1.name })
                self.bands = sorted
                self.onBandsLoaded?()
                self.database.storeBands(sorted)
                
            case .failure(let error):
                let bands  = self.database.fetchBands()
                let sorted = bands.sorted(by: { $0.name < $1.name })
                self.bands = sorted
                self.onBandsLoaded?()
                debugPrint(error)
            }
        }
    }
    
    func bandModel(at index: Int) -> BandCellModel {
        let band = bands[index]
        let bandImageURL = bandImageUrl(band)
        return BandCellModel(bandName: band.name, bandImageURL: bandImageURL, listeners: band.listeners)
    }
    
    private func bandImageUrl(_ band: Band) -> String {
        let bandImages = Array(band.images)
        for image in bandImages {
            if image.size == "large" || image.size == "medium" {
                return image.url
            }
        }
        return bandImages.first?.url ?? ""
    }
    
    func processCountrySelection(selectedCountry: String) {
        self.selectedCountry = selectedCountry
    }
    
    func processItemSelection(at index: Int) {
        let selectedBand = bands[index]
        let bandID = selectedBand.id
        router?.showDetailsScreen(for: bandID)
    }
}
