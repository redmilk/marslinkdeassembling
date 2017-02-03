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
    var versusPosts: [VersusPost] = {
        var versusPosts = [VersusPost]()
        versusPosts.append(VersusPost(name: "Girl", header: "Beauty", imageOne: "1", imageTwo: "2", titleOne: "Chick", titleTwo: "Hottie", date: Date(timeIntervalSinceNow: -100)))
        versusPosts.append(VersusPost())
        return versusPosts
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
    func addVersus() {
        // add versus code
        versusPosts.append(VersusPost(name: "Girl", header: "Select hottest one", imageOne: "3", imageTwo: "4", titleOne: "Lips", titleTwo: "Cuttie", date: Date(timeIntervalSinceNow: 12)))
        adapter.performUpdates(animated: true, completion: nil)
    }
    
    @IBAction func tryThisFuncHaha(_ sender: UIBarButtonItem) {
        addPost()
    }
    
    @IBAction func addVersusPostButton(_ sender: UIBarButtonItem) {
        addVersus()
    }
    
}

extension FeedViewController: IGListAdapterDataSource {
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        // 1
        var items: [IGListDiffable] = messager.messages as [IGListDiffable]
        items += posts as [IGListDiffable]
        items += versusPosts as [IGListDiffable]
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
        } else if object is Post {
            return PostSectionController()
        } else {
            return VersusSectionController()
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
