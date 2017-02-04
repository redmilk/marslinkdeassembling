//
//  VersusGenerator.swift
//  Marslink
//
//  Created by Artem on 2/4/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import Foundation

protocol VersusGeneratorDelegate: class {
    func versusDidUpdatePostsArray(generator: VersusGenerator)
}

class VersusGenerator {
    
    weak var delegate: VersusGeneratorDelegate?
    
    var versusPosts: [VersusPost] = {
        var versusPosts = [VersusPost]()
        //versusPosts.append(VersusPost(name: "Girl", header: "Beauty", imageOne: "1", imageTwo: "2", titleOne: "Chick", titleTwo: "Hottie", date: Date(timeIntervalSinceNow: -100)))
        //versusPosts.append(VersusPost())
        return versusPosts
        }() {
        didSet {
            delegate?.versusDidUpdatePostsArray(generator: self)
        }
    }
}
