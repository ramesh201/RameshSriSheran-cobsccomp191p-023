//
//  SafeActionViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 9/13/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit

class SafeActionViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBAction func btnBack(_ sender: Any) {
        _ = self.dismiss(animated: true)
        
    }
    
    var imageList: [String] = ["fightcorona.jpg","Handwashing.jpg","wearmask.jpg","avoidcrowded.jpg"]
    var headings: [String] = ["Stay Safe","Clean Yourself","Wear a mask","Avoid Crowded"]
    var subHeadings: [String] = ["Stay safe and control","When and how to wash your hands","Cover your face & protect","First think about yourself"]
    var frame = CGRect.zero
    
    let imagelist = ["img1.jpg", "photo1.jpg", "photo3.jpg", "photo4.jpg", "photo5.jpg"]
    
    var sliderImagesArray = NSMutableArray()
    
       //var scrollView = UIScrollView()

       //var pageControl : UIPageControl = UIPageControl(frame:CGRect(x: 50, y: 300, width: 200, height: 50))

       var yPosition:CGFloat = 0
       var scrollViewContentSize:CGFloat=0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Safe Actions")
        
        sliderImagesArray = ["https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080","https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080", "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080"]
            scrollView.delegate = self
        //for i in 0..<sliderImagesArray.count {
              //  var imageView : UIImageView
               // let xOrigin = self.scrollView.frame.size.width * CGFloat(i)
                
            
            
            /*imageView = UIImageView(frame: CGRect(x: xOrigin, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height))
                imageView.isUserInteractionEnabled = true
                let urlStr = sliderImagesArray.object(at: i)
                print(scrollView,imageView, urlStr)
            imageView.af_se(with: URL(string: urlStr as! String), placeholderImage: UIImage(named: "placeholder.png"))
            imageView .contentMode = UIView.ContentMode.scaleToFill
                self.scrollView.addSubview(imageView)
            */
            
            for  i in stride(from: 0, to: imageList.count, by: 1) {
                    var frame = CGRect.zero
                    frame.origin.x = self.scrollView.frame.size.width * CGFloat(i)
                    frame.origin.y = 0
                    frame.size = self.scrollView.frame.size
                    self.scrollView.isPagingEnabled = true

                    
                    
                    let myImageView = UIImageView(frame: frame)
                    //let myImageView:UIImageView = UIImageView()
                    myImageView.image = UIImage(named: imageList[i])
                    myImageView.contentMode = UIView.ContentMode.scaleAspectFit
                    myImageView.frame = frame
                    //myImageView.size

                    /*let imgView = UIImageView(frame: frame)
                    imgView.image = UIImage(systemName: movies[i])
                    */
                    //scrollView.addSubview(imgView)
                    scrollView.addSubview(myImageView)
                
                let safeActionHeading = UILabel()
                //let myImageView:UIImageView = UIImageView()
                safeActionHeading.text = headings[i]
                safeActionHeading.textColor = UIColor.white
                safeActionHeading.frame = frame
                //safeActionHeading.frame.origin.x = self.scrollView.frame.size.width * 10
                safeActionHeading.frame.origin.y = 220
                scrollView.addSubview(safeActionHeading)
                
                let safeActionSubHeading = UILabel()
                //let myImageView:UIImageView = UIImageView()
                safeActionSubHeading.text = subHeadings[i]
                safeActionSubHeading.textColor = UIColor.white
                safeActionSubHeading.font.withSize(1)
                safeActionSubHeading.frame = frame
                //safeActionHeading.frame.origin.x = self.scrollView.frame.size.width * 10
                safeActionSubHeading.frame.origin.y = 250
                scrollView.addSubview(safeActionSubHeading)
                
                }

                
        
            /*let urlStr = sliderImagesArray.object(at: i)
            getImageFromWeb(urlStr as! String) { (image) in
                if let image = image {
                    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
                    imageView.image = image
                    //self.view.addSubview(imageView)
                    self.scrollView.addSubview(imageView)
                } // if you use an Else statement, it will be in background
            }
            */
            
            //}
            self.scrollView.isPagingEnabled = true
            self.scrollView.bounces = false
            self.scrollView.showsVerticalScrollIndicator = false
            self.scrollView.showsHorizontalScrollIndicator = false
            self.scrollView.contentSize = CGSize(width:
            self.scrollView.frame.size.width * CGFloat(imageList.count), height: self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)

            self.pageControl.numberOfPages = imageList.count
            self.pageControl.currentPage = 0
            self.pageControl.tintColor = UIColor.red
            self.pageControl.pageIndicatorTintColor = UIColor.black
            self.pageControl.currentPageIndicatorTintColor = UIColor.blue
        
    }
    
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FirstViewController {
            
            print(destination)
            /*destination.lblHeader = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!].SettingSubtitle*/
            //destination.settingObj = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!]
            
            //tblSettingList.deselectRow(at: tblSettingList.indexPathForSelectedRow!, animated: true)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
