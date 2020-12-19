//
//  Meme.swift
//  MemeEditor
//
//  Created by Ataias Pereira Reis on 30/11/20.
//

import Foundation
import UIKit
import CryptoKit

struct Meme: Codable, Equatable, Identifiable {
    var id = Date()
    let topText: String
    let bottomText: String
    let original: UIImageD
    let memed: UIImageD

    static func == (lhs: Meme, rhs: Meme) -> Bool {
        return lhs.topText == rhs.topText && lhs.bottomText == rhs.bottomText && lhs.original == rhs.original
    }
}

extension Meme {
    init(topText: String, bottomText: String, original: UIImage, memed: UIImage) {
        self.init(topText: topText, bottomText: bottomText, original: UIImageD(image: original), memed: UIImageD(image: memed))
    }
}

struct UIImageD: Codable, Equatable {
    let image: UIImage

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let data = try container.decode(Data.self)

        let image = UIImage(data: data)!
        self.init(image: image)
    }

    init(image: UIImage) {
        self.image = image
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let data = image.pngData()!
        try container.encode(data)
    }
}

