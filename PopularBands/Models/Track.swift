import RealmSwift

class Track: Object, Codable {
    @objc dynamic var name: String?
    @objc dynamic var id: String?
    @objc dynamic var playcount: String?
    
    var images = List<ArtistImage>()
    @objc dynamic var artist: ArtistPromt?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id = "mbid"
        case images = "image"
        case playcount
        case artist
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class ArtistPromt: Object, Codable {
    @objc dynamic var name: String?
    @objc dynamic var mbid: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case mbid
    }
}
