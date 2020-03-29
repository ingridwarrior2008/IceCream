//
//  IceCreamModel.swift
//  IceCreamParlorChallenge
//
//  Created by Cris on 29/03/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation

enum IceCreamType: String {
    case popsicle
    case froyo
    case sundae
    case cone
    case none
    
    var imageName: String {
        switch self {
        case .popsicle:
            return "popsicle_img"
        case .froyo:
            return "froyo_img"
        case .sundae:
            return "ice_cream_img"
        case .cone:
            return "cone_img"
        case .none:
            return ""
        }
    }
}

struct IceCreamModel: Decodable, Hashable {
    var nameTitle: String
    var nameSubTitle: String
    var color: String
    var price: String
    var type: IceCreamType = .none
    
    var iceCreamName: String {
        return nameTitle + " " + nameSubTitle
    }
    
    enum CodingKeys: String, CodingKey {
        case nameTitle = "name1"
        case nameSubTitle = "name2"
        case color = "bg_color"
        case type = "type"
        case price = "price"
    }
    
    init(from decoder: Decoder) throws {
        let decode = try decoder.container(keyedBy: CodingKeys.self)
        nameTitle = try decode.decodeIfPresent(String.self, forKey: .nameTitle) ?? ""
        nameSubTitle = try decode.decodeIfPresent(String.self, forKey: .nameSubTitle) ?? ""
        color = try decode.decodeIfPresent(String.self, forKey: .color) ?? ""
        price = try decode.decodeIfPresent(String.self, forKey: .price) ?? ""
        let icecreamType = try decode.decodeIfPresent(String.self, forKey: .type) ?? ""
        type = IceCreamType(rawValue: icecreamType) ?? .none
    }
}

/*
 Example response from the URL
 [{"name1":"Ranunculaceae","name2":"Fuscia","price":"$1.34","bg_color":"#1cc732","type":"popsicle"},{"name1":"Poaceae","name2":"Orange","price":"$3.40","bg_color":"#9e0bfc","type":"popsicle"},{"name1":"Brassicaceae","name2":"Indigo","price":"$2.43","bg_color":"#766f95","type":"cone"},{"name1":"Amaranthaceae","name2":"Red","price":"$4.13","bg_color":"#e50bec","type":"froyo"},{"name1":"Iridaceae","name2":"Fuscia","price":"$2.61","bg_color":"#3eb6de","type":"popsicle"},{"name1":"Loasaceae","name2":"Crimson","price":"$0.32","bg_color":"#aada8a","type":"froyo"},{"name1":"Caryophyllaceae","name2":"Puce","price":"$3.11","bg_color":"#2d9ca5","type":"sundae"},{"name1":"Alismataceae","name2":"Turquoise","price":"$2.86","bg_color":"#2df868","type":"froyo"},{"name1":"Malvaceae","name2":"Pink","price":"$0.58","bg_color":"#0d3c72","type":"sundae"},{"name1":"Liliaceae","name2":"Yellow","price":"$1.55","bg_color":"#f4e39e","type":"froyo"},{"name1":"Ophioglossaceae","name2":"Fuscia","price":"$3.15","bg_color":"#a3352e","type":"sundae"},{"name1":"Bacidiaceae","name2":"Indigo","price":"$2.84","bg_color":"#5a666f","type":"cone"},{"name1":"Rosaceae","name2":"Khaki","price":"$1.59","bg_color":"#c18559","type":"popsicle"},{"name1":"Hymeneliaceae","name2":"Pink","price":"$1.22","bg_color":"#d8c517","type":"cone"},{"name1":"Ericaceae","name2":"Khaki","price":"$2.96","bg_color":"#8e8bd9","type":"sundae"},{"name1":"Asteraceae","name2":"Crimson","price":"$0.76","bg_color":"#13ef8f","type":"cone"},{"name1":"Campanulaceae","name2":"Green","price":"$4.91","bg_color":"#fd6efa","type":"froyo"},{"name1":"Chenopodiaceae","name2":"Yellow","price":"$1.62","bg_color":"#9907c9","type":"popsicle"},{"name1":"Asteraceae","name2":"Aquamarine","price":"$1.92","bg_color":"#5e7f97","type":"sundae"},{"name1":"Lamiaceae","name2":"Blue","price":"$3.71","bg_color":"#6491f2","type":"cone"},{"name1":"Oleaceae","name2":"Violet","price":"$0.85","bg_color":"#785853","type":"sundae"},{"name1":"Asteraceae","name2":"Purple","price":"$3.58","bg_color":"#f39552","type":"froyo"},{"name1":"Nyctaginaceae","name2":"Puce","price":"$1.70","bg_color":"#567fb1","type":"popsicle"},{"name1":"Onagraceae","name2":"Crimson","price":"$2.37","bg_color":"#ebbc74","type":"froyo"},{"name1":"Convolvulaceae","name2":"Teal","price":"$3.57","bg_color":"#7c4355","type":"popsicle"}]
 */
