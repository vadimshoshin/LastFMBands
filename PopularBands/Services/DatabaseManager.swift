import Foundation
import RealmSwift

protocol DatabaseManager {
    func fetchBands() -> [Band]
    func fetchBand(with id: String) -> Band?
    func fetchTracks(with bandID: String) -> [Track] 
    func store<T: Object>(items: [T])
}

final class RealmManager: DatabaseManager {
    let realm = try! Realm()
    
    func store<T: Object>(items: [T]) {
        do {
            try realm.write {
                realm.add(items)
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
    
    func fetchTracks(with bandID: String) -> [Track] {
        let predicate = NSPredicate(format: "artist.id = %@", bandID)
        return Array(realm.objects(Track.self).filter(predicate))
    }
}
