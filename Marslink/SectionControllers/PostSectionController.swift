//
//  PostSectionController.swift
//  Marslink
//
//  Created by Artem on 2/2/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class PostSectionController: IGListSectionController {
    
    var post: Post!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
}


extension PostSectionController: IGListSectionType {
    func numberOfItems() -> Int {
        return 1
    }
    func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        return MessageCell.cellSize(width: context.containerSize.width, text: self.post.text)
    }
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCellFromStoryboard(withIdentifier: "PostCell", for: self, at: index) as! PostCell
        cell.textLabel.text = self.post.text
        return cell
    }
    func didUpdate(to object: Any) {
        self.post = object as? Post
    }
    
    func didSelectItem(at index: Int) {
    }
}
