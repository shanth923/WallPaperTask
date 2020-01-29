//
//  ViewController.swift
//  WallPaperTask
//
//  Created by Vadde Narendra on 1/28/20.
//  Copyright © 2020 Vadde Narendra. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(pageControllerOutlet.currentPage == 0){
        
        return liveImages.count
        }
        else if(pageControllerOutlet.currentPage == 1)
        
            {
               return staticImages.count
            }
        return trendingImages.count
        
    }
        func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
    //        if(collectionView.tag == 2){
    //        return CGSize(width: 100, height: 100)
    //        }
    //        else if(collectionView.tag == 4){
    //        return CGSize(width: 200, height: 200)
    //        }
    //        else
    //        {
           
            return CGSize(width: 200 , height: 200)
            
            //}
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "abc", for: indexPath)
        
        var imageView = UIImageView(image: staticImages[indexPath.item])
     imageView.frame = CGRect(x: 0, y: 0, width:200, height: 200)
        if(pageControllerOutlet.currentPage == 0){
        
        imageView.image = liveImages[indexPath.item]
        }
        if(pageControllerOutlet.currentPage == 1){
        
        imageView.image = staticImages[indexPath.item]
        }
        if(pageControllerOutlet.currentPage == 2){
        
        imageView.image = trendingImages[indexPath.item]
        }
        
//        cell.contentView.addSubview(wallPaperImages)
        
        cell.contentView.addSubview(imageView)
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        
        
        
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    @IBOutlet weak var pageControllerOutlet: UIPageControl!
    
    var flowLayout = UICollectionViewFlowLayout()
    
    
    
    @IBAction func pageController(_ sender: Any) {
        
        collectionView.reloadData()
        
        
        
        
        
    }
    var data:[String:Any]!
    
    var liveImages = [UIImage]()
    var staticImages = [UIImage]()
    var trendingImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .vertical
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        apReq()
        fetchData()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "abc")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
 
    func fetchData(){
        
        data = apReq()
        
        let respondData = data["responseData"] as! [String:Any]
        
       
            
        let wallPaerData = respondData["wallpaper"] as! [[String:Any]]
        
        
        for i in wallPaerData{
            if(i["name"] as! String == "Live Wallpaper"){
                let dta2 = i["data"] as! [[String:Any]]
                
                for t in dta2{
                    
                    
                    let imagesStringData = t["vIPhoneWallpaperThumbImage"] as! String
                
                let imageURL = URL(string: imagesStringData)
                
                
                do{
                   let imageData = try Data(contentsOf: imageURL!)
                    
                   let uiImages = UIImage(data: imageData)
                    liveImages.append(uiImages!)
                    
                }
                catch{
                    
                    print("images not getting")
                }
                
            }
            }
            
            else if (i["name"] as! String == "Static Wallpaper"){
                let dta2 = i["data"] as! [[String:Any]]
                
                for t in dta2{
                    
                    
                    let imagesStringData = t["vIPhoneWallpaperThumbImage"] as! String
                    
                    let imageURL = URL(string: imagesStringData)
                    
                    
                    do{
                        let imageData = try Data(contentsOf: imageURL!)
                        
                        let uiImages = UIImage(data: imageData)
                        staticImages.append(uiImages!)
                        
                    }
                    catch{
                        
                        print("images not getting")
                    }
                    
                }
            }
            else {
                let dta2 = i["data"] as! [[String:Any]]
                
                for t in dta2{
                    
                    
                    let imagesStringData = t["vIPhoneWallpaperThumbImage"] as! String
                    
                    let imageURL = URL(string: imagesStringData)
                    
                    
                    do{
                        let imageData = try Data(contentsOf: imageURL!)
                        
                        let uiImages = UIImage(data: imageData)
                        trendingImages.append(uiImages!)
                        
                    }
                    catch{
                        
                        print("images not getting")
                    }
                    
                }
                
                
                
            }
            
            
            
        }
        
        
        
        
        
//        for i in wallPaerData{
//
//
//
//            if (i["name"] as! String == "Live%20Wallpaper"){
//
//
//                print(i["data"] as! [String:Any])
//
//            }
//
//
//        }
        
       
        
     
        
    }
    
    
    
   
    
    
    func apReq()-> [String:Any]{
        
        
        var responseData:[String:Any]!
        let request = "http://dev2.spaceo.in/project/WallpaperApp/code/api/v1/common"
        
        var urlReq = URLRequest(url: URL(string: request)!)
        urlReq.httpMethod = "GET"
//        let parameters = "nonce=123456&timestamp=123456&token=8d7323a8cedca2664f13a9ed4a7d6e51ee9b36878500a793545d9324e838aa3b&Authorization=31148159982e99ce8bf825f35e3a473d"
        urlReq.setValue("123456", forHTTPHeaderField: "nonce")
        urlReq.setValue("123456", forHTTPHeaderField: "timestamp")
        urlReq.setValue("8d7323a8cedca2664f13a9ed4a7d6e51ee9b36878500a793545d9324e838aa3b", forHTTPHeaderField: "token")
        urlReq.setValue("31148159982e99ce8bf825f35e3a473d", forHTTPHeaderField: "Authorization")
        
//        urlReq.httpBody = parameters.data(using: String.Encoding.utf8)
        
        let dataTask = URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            
            do{
                
                 responseData = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                
                print(response)
            }
            catch{
                
                print("something went wrong")
                
            }
           
        }
        dataTask.resume()
        
        while responseData == nil {
            
        }
        
        DBManager.shared.wholeData = responseData!
       return responseData
    }
    
    

}

