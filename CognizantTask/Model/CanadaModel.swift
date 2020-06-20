//
//  CanadaModel.swift
//  CognizantTask
//
//  Created by Barath on 20/06/20.
//  Copyright © 2020 Barath. All rights reserved.
//

import Foundation

struct CanadaDataModel: Codable{
    let title: String
    let rows: [Row]
}

struct Row: Codable{
    let title, rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}
