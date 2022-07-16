//
//  PictureModel.swift
//  SearchImage
//
//  Created by Олег Савельев on 14.07.2022.
//

import UIKit

struct PictureData: Codable {
    var imagesResults: [PictureModel]
    
    enum CodingKeys: String, CodingKey {
        case imagesResults = "images_results"
    }
}

struct PictureModel: Codable {
    var position: Int = .init()
    var thumbnail: String = .init()
    var title: String = .init()
    var original: String = .init()
    var link: String = .init()
    
    init() {}
}
