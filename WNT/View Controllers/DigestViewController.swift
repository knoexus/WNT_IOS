//
//  DigestViewController.swift
//  WNT
//
//  Created by AD on 13/12/2019.
//  Copyright © 2019 AD. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import WebKit
import PDFKit

class DigestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var z: Array<String> = []
    
    var zImages: [UIImage] = []
        
//    let digests = ["first", "second"]
    
//    let digestsImages: [UIImage] = [
//        UIImage(named: "first")!,
//        UIImage(named: "second")!
//    ]
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDigests(completion: changeVal)
        collectionView.dataSource = self
        collectionView.delegate = self

        
//        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//        layout.minimumInteritemSpacing = 5
//        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.size.height/3)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    private func setupCollectionViewItemSize(){
        if collectionViewFlowLayout == nil {
            let numberOfItemPerRow: CGFloat = 2
            let lineSpacing: CGFloat = 5
            let interItemSpacing: CGFloat = 5
            
            let width = (collectionView.frame.width - (numberOfItemPerRow - 1) * interItemSpacing) / numberOfItemPerRow
            let height = width
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return z.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.digestLabel.text = z[indexPath.item]
        cell.digestImageView.image = zImages[indexPath.item]
        cell.accessibilityLabel = z[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("registered")
        let pdfName = z[indexPath.item]
//        if let url = Bundle.main.url(forResource: pdfName, withExtension: "pdf") {
//            let webView = UIWebView(frame: self.view.frame)
//            let urlRequest = URLRequest(url: url)
//            webView.loadRequest(urlRequest as URLRequest)
//            webView.scalesPageToFit = true
//            let pdfVC = UIViewController()
//            pdfVC.view.addSubview(webView)
//            pdfVC.title = "Your Digest"
//            self.navigationController?.pushViewController(pdfVC, animated: true)
//        }
        if let url = Bundle.main.url(forResource: pdfName, withExtension: "pdf") {
            let pdfVC = UIViewController()
            pdfVC.title = "Your Digest"
            self.navigationController?.pushViewController(pdfVC, animated: true)
            let webView = WKWebView()
            webView.frame = self.view.frame
            
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest as URLRequest)
            //webView.scalesLargeContentImage
            pdfVC.view.addSubview(webView)
        }
    }
    
    private func fetchDigests(completion: @escaping (Array<String>) -> Void){
        guard let user = Auth.auth().currentUser?.uid else { return; }
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: user)
            .getDocuments { (snapshot, error) in
                let k = Array(snapshot!.documents[0].data())
                for item in k {
                    if item.key == "digests" {
                        let m = item.value as! Array<String>
                        completion(m)
                    }
                }
        }
    }
    
    private func changeVal(params: Array<String>){
        DispatchQueue.main.async {
            self.z = params
            self.zImages = params.map(self.toUIImage)
            self.collectionView.reloadData()
        }
    }
    
    private func toUIImage(_ x:String) -> UIImage{
        return UIImage(named: x)!
    }

}
