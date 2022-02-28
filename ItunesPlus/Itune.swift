//
//  Itunes.swift
//  ItunesPlus
//
//  Created by iYezan on 27/02/2022.
//

import Foundation

//struct Itune {
//    let name: String
//    let artistName: String
//}
//
//
//extension Itune {
//    static let mockData = [
//        Itune(name: "iOS Job interview questions", artistName: "Yezan")
//    ]
//}

struct StoreItem: Codable {
    var name: String
    var artist: String
    var kind: String
    var artworkURL: URL
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case artist = "artistName"
        case kind
        case artworkURL = "artworkUrl100"
        case description
    }
    
    enum AdditionalKeys: String, CodingKey {
        case longDescription
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try values.decode(String.self, forKey: CodingKeys.name)
        self.artist = try values.decode(String.self, forKey: CodingKeys.artist)
        self.kind = try values.decode(String.self, forKey: CodingKeys.kind)
        self.artworkURL = try values.decode(URL.self, forKey: CodingKeys.artworkURL)
        
        if let description = try? values.decode(String.self, forKey: CodingKeys.description) {
            self.description = description
        } else {
            let additionalValues = try decoder.container(keyedBy: AdditionalKeys.self)
            self.description = (try? additionalValues.decode(String.self, forKey: AdditionalKeys.longDescription)) ?? ""
        }
    }
}
struct StoreItems: Codable {
    let results: [StoreItem]
}
