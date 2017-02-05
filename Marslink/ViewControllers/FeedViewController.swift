//
//  FeedViewController.swift
//  Marslink
//
//  Created by Artem on 1/30/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit
import FirebaseDatabase
import FirebaseAuth


// ////////////////// DELEG ///////////////////////
extension FeedViewController: VersusGeneratorDelegate {
    func versusDidUpdatePostsArray(generator: VersusGenerator) {
        adapter.performUpdates(animated: true, completion: nil)
    }
}
extension FeedViewController: MessagerDelegate {
    func messagerDidUpdateMessages(messager: Messager) {
        adapter.performUpdates(animated: true)
    }
}
extension FeedViewController: IGListAdapterDataSource {
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        // 1
        var items: [IGListDiffable] = generator.versusPosts as [IGListDiffable]
        /*items += posts as [IGListDiffable]
         items += messager.messages as [IGListDiffable]*/
        // 2
        return items.sorted(by: { (left: Any, right: Any) -> Bool in
            if let left = left as? DateSortable, let right = right as? DateSortable {
                return left.date > right.date
            }
            return false
        })
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return VersusSectionController()
        /* if object is Message {
         return MessageSectionController()
         } else if object is Post {
         return PostSectionController()
         } else {
         return VersusSectionController()
         } */
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
    
}
// ////////////////// FEED ///////////////////////
class FeedViewController: UIViewController {
    
    // MARK: - FIELDS
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    } ()
    
    @IBOutlet weak var collectionView: IGListCollectionView!
    
    let messager = Messager()
    let generator = VersusGenerator()
    
    var posts: [Post] = {
        var posts = [Post]()
        posts.append(Post(date: Date(timeIntervalSinceNow: -10), text: "Hello there!", name: "Cyrex"))
        posts.append(Post(date: Date(timeIntervalSinceNow: -9), text: "Go drink beer?", name: "Jared"))
        posts.append(Post(date: Date(timeIntervalSinceNow: -8), text: "Taste your fear...", name: "Kabal"))
        return posts
    }()
    
    
    // MARK: - firebase
    var ref: FIRDatabaseReference?
    var dataBaseHandle: FIRDatabaseHandle?
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        //adapter preset
        adapter.collectionView = collectionView
        adapter.dataSource = self
        //messeger delegate
        messager.delegate = self
        //generator delegate
        generator.delegate = self
        messager.connect()
        
        // MARK: - firebase
        ref = FIRDatabase.database().reference()
        dataBaseHandle = ref!.child("vs").child("posts").observe(.childAdded, with: { (snapshot) in
            let foo = snapshot.value as? [String : AnyObject]
            if let post = foo {
                if let author = post["author"] as? String,
                    let header = post["header"] as? String,
                    let _ = post["likes"] as? Int,
                    let image1 = post["pathToImage1"] as? String,
                    let image2 = post["pathToImage2"] as? String,
                    let _ = post["postID"] as? String,
                    let labelOne = post["labelOne"] as? String,
                    let labelTwo = post["labelTwo"] as? String {
                    
                    let vsPost = VersusPost(name: author, header: header, imageOne: image1, imageTwo: image2, titleOne: labelOne, titleTwo: labelTwo, date: Date(timeIntervalSinceNow: -100))
                    
                    // it should be at Versus Generator
                    self.generator.versusPosts.append(vsPost)
                    //self.adapter.performUpdates(animated: true, completion: nil)
                }
            }
        })
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
        generator.versusPosts.append(VersusPost(name: "Girl", header: "Select hottest one", imageOne: "http://www.hollywood-actors.ru/uploads/gallery/852_4.jpg", imageTwo: "http://www.kino-teatr.ru/acter/album/50275/pv_699468.jpg", titleOne: "Lips", titleTwo: "Cuttie", date: Date(timeIntervalSinceNow: 12)))
        adapter.performUpdates(animated: true, completion: nil)
    }
    
    @IBAction func tryThisFuncHaha(_ sender: UIBarButtonItem) {
        addPost()
    }
    
    @IBAction func addVersusPostButton(_ sender: UIBarButtonItem) {
        addVersus()
    }
    
}




