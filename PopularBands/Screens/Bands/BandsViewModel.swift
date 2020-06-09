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
        self.bandsManager = dependencies.bandsManager
    }
    
    var numberOfItems: Int {
        return bands.count
    }
    
    func fetchBands() {
        bandsManager.fetchBands(for: selectedCountry) { [weak self] result in
            switch result {
            case .success(let bands):
                let sorted = bands.sorted(by: { $0.name < $1.name })
                self?.bands = sorted
                self?.onBandsLoaded?()
                for band in bands {
                    debugPrint(band.name)
                }
            case .failure(let error):
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
        
    }
}
