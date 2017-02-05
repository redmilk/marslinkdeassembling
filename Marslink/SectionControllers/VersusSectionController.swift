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
        return CGSize(width: collectionContext!.containerSize.width, height: 186.0)
    }
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCellFromStoryboard(withIdentifier: "VersusCell", for: self, at: index) as! VersusCell
        cell.headerLabel.text = self.versusPost.header
        cell.titleOneLabel.text = self.versusPost.titleOne
        cell.titleTwoLabel.text = self.versusPost.titleTwo
        cell.headerLabel.text = self.versusPost.header
        cell.imageOne.sd_setImage(with: URL(string: self.versusPost.imageOnePath), placeholderImage: UIImage(named: "photoalbum"), options: [.avoidAutoSetImage, .progressiveDownload])
        
        cell.imageTwo.sd_setImage(with: URL(string: self.versusPost.imageTwoPath), placeholderImage: UIImage(named: "photoalbum"), options: [.avoidAutoSetImage, .progressiveDownload])
        
        return cell
    }
    func didUpdate(to object: Any) {
        self.versusPost = object as? VersusPost
    }
    func didSelectItem(at index: Int) {
    }
}
