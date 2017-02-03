//
//  FeedViewController.swift
//  Marslink
//
//  Created by Artem on 1/30/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class FeedViewController: UIViewController {
    
    // MARK: - FIELDS
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    } ()
    
    @IBOutlet weak var collectionView: IGListCollectionView!
    
    let messager = Messager()
    var posts: [Post] = {
        var posts = [Post]()
        posts.append(Post(date: Date(timeIntervalSinceNow: -10), text: "Hello there!", name: "Cyrex"))
        posts.append(Post(date: Date(timeIntervalSinceNow: -9), text: "Go drink beer?", name: "Jared"))
        posts.append(Post(date: Date(timeIntervalSinceNow: -8), text: "Taste your fear...", name: "Kabal"))
        return posts
    }()
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = collectionView
        adapter.dataSource = self
        messager.delegate = self
        messager.connect()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        collectionView.backgroundColor = UIColor.black
    }
    
    func addPost() {
        posts.append(Post(date: Date(timeIntervalSinceNow: 0), text: "Hi. I'm the GList!", name: "GList"))
        adapter.performUpdates(animated: true)
    }
    @IBAction func tryThisFuncHaha(_ sender: UIBarButtonItem) {
        addPost()
    }
    
}

extension FeedViewController: IGListAdapterDataSource {
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        // 1
        var items: [IGListDiffable] = messager.messages as [IGListDiffable]
        items += posts as [IGListDiffable]
        // 2
        return items.sorted(by: { (left: Any, right: Any) -> Bool in
            if let left = left as? DateSortable, let right = right as? DateSortable {
                return left.date > right.date
            }
            return false
        })
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if object is Message {
            return MessageSectionController()
        } else {
            return PostSectionController()
        }
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
    
}

extension FeedViewController: MessagerDelegate {
    func messagerDidUpdateMessages(messager: Messager) {
        adapter.performUpdates(animated: true)
    }
}
