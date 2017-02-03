//
//  VersusSectionController.swift
//  Marslink
//
//  Created by Artem on 2/3/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class VersusSectionController: IGListSectionController {
    var versusPost: VersusPost!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
}

extension VersusSectionController: IGListSectionType {
    func numberOfItems() -> Int {
        return 1
    }
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: collectionContext!.containerSize.height)
    }
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCellFromStoryboard(withIdentifier: "VersusCell", for: self, at: index) as! VersusCell
        cell.headerLabel.text = self.versusPost.header
        cell.titleOneLabel.text = self.versusPost.titleOne
        cell.titleTwoLabel.text = self.versusPost.titleTwo
        cell.imageOne.image = UIImage(named: self.versusPost.imageOnePath)
        cell.imageTwo.image = UIImage(named: self.versusPost.imageTwoPath)
        return cell
    }
    func didUpdate(to object: Any) {
        self.versusPost = object as? VersusPost
    }
    func didSelectItem(at index: Int) {
    }
}
