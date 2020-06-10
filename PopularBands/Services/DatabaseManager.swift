import Foundation
import RealmSwift

protocol DatabaseManager {
    func storeBands(_ bands: [Band])
    func fetchBands() -> [Band]
    func fetchBand(with id: String) -> Band?
}

final class RealmManager: DatabaseManager {
    let realm = try! Realm()
    
    func storeBands(_ bands: [Band]) {
        do {
            try realm.write {
                realm.add(bands)
            }
        } catch let error {
            debugPrint("Database storing error - \(error)")
        }
    }
    
    func fetchBands() -> [Band] {
        let bandsResult = realm.objects(Band.self)
        return Array(bandsResult)
    }
    
    func fetchBand(with id: String) -> Band? {
        let predicate = NSPredicate(format: "id = %@", id)
        let result = Array(realm.objects(Band.self).filter(predicate))
        return result.first
    }
}
