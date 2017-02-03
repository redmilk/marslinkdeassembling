//
//  VersusPost.swift
//  Marslink
//
//  Created by Artem on 2/3/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import Foundation

class VersusPost: NSObject, DateSortable {
    
    let name: String
    let header: String
    let imageOnePath: String
    let imageTwoPath: String
    let titleOne: String
    let titleTwo: String
    let date: Date
    
    init(name: String = "Default",
         header: String = "Default Header",
         imageOne: String = "1.png",
         imageTwo: String = "2.png",
         titleOne: String = "Default One",
         titleTwo: String = "Default Two",
         date: Date = Date(timeIntervalSinceNow: 0)) {
        
        self.name = name
        self.header = header
        self.imageOnePath = imageOne
        self.imageTwoPath = imageTwo
        self.titleOne = titleOne
        self.titleTwo = titleTwo
        self.date = date
    }
}
