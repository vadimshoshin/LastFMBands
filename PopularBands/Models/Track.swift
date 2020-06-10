import RealmSwift

class Track: Object, Codable {
    @objc dynamic var name: String
    @objc dynamic var id: String
    @objc dynamic var playcount: String
    let images: Set<ImageObject>?
    @objc dynamic var artist: Band?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id = "mbid"
        case images = "image"
        case playcount
        case artist
    }
}
