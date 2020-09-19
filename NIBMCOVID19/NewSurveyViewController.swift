//
//  NewSurveyViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 9/13/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit

class NewSurveyViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var movies: [String] = [ "coronaSurvey1.jpg","coronaSurvey2.png","coronaSurvey3.jpg","coronaSurvey4.jpg"]

    var frame = CGRect.zero
    
    let imagelist = ["img1.jpg", "photo1.jpg", "photo3.jpg", "photo4.jpg", "photo5.jpg"]
    
    //var sliderImagesArray = NSMutableArray()
    
       //var scrollView = UIScrollView()

       //var pageControl : UIPageControl = UIPageControl(frame:CGRect(x: 50, y: 300, width: 200, height: 50))

       var yPosition:CGFloat = 0
       var scrollViewContentSize:CGFloat=0;
    
    /*override func viewDidLoad() {
        super.viewDidLoad()
print("new survey")
        
        pageControl.numberOfPages = movies.count
        setupScreens()

        scrollView.delegate = self
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*sliderImagesArray = ["https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080","https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080", "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080"]
 */
            scrollView.delegate = self
        //for i in 0..<movies.count {
                //var imageView : UIImageView
                //let xOrigin = self.scrollView.frame.size.width * CGFloat(i)
                
            
            
            /*imageView = UIImageView(frame: CGRect(x: xOrigin, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height))
                imageView.isUserInteractionEnabled = true
                let urlStr = sliderImagesArray.object(at: i)
                print(scrollView,imageView, urlStr)
            imageView.af_se(with: URL(string: urlStr as! String), placeholderImage: UIImage(named: "placeholder.png"))
            imageView .contentMode = UIView.ContentMode.scaleToFill
                self.scrollView.addSubview(imageView)
            */
            
            for  i in stride(from: 0, to: movies.count, by: 1) {
                    var frame = CGRect.zero
                    frame.origin.x = self.scrollView.frame.size.width * CGFloat(i)
                    frame.origin.y = 0
                    frame.size = self.scrollView.frame.size
                    self.scrollView.isPagingEnabled = true

                    
                    
                    let myImageView = UIImageView(frame: frame)
                    //let myImageView:UIImageView = UIImageView()
                    myImageView.image = UIImage(named: movies[i])
                    myImageView.contentMode = UIView.ContentMode.scaleAspectFit
                    myImageView.frame = frame
                    //myImageView.size

                    /*let imgView = UIImageView(frame: frame)
                    imgView.image = UIImage(systemName: movies[i])
                    */
                    //scrollView.addSubview(imgView)
                    scrollView.addSubview(myImageView)
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
            self.scrollView.frame.size.width * CGFloat(movies.count), height: self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)

            self.pageControl.numberOfPages = movies.count
            self.pageControl.currentPage = 0
            self.pageControl.tintColor = UIColor.red
            self.pageControl.pageIndicatorTintColor = UIColor.black
            self.pageControl.currentPageIndicatorTintColor = UIColor.blue
        
    }
    
     func getImageFromWeb(_ urlString: String, closure: @escaping (UIImage?) -> ()) {
            guard let url = URL(string: urlString) else {
    return closure(nil)
            }
            let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    print("error: \(String(describing: error))")
                    return closure(nil)
                }
                guard response != nil else {
                    print("no response")
                    return closure(nil)
                }
                guard data != nil else {
                    print("no data")
                    return closure(nil)
                }
                DispatchQueue.main.async {
                    closure(UIImage(data: data!))
                }
            }; task.resume()
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
        //scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
scrollView.contentSize = CGSize(width: (self.view.frame.width * CGFloat(movies.count)), height: 300)
        
        configurePageControl()

        scrollView.delegate = self
        self.view.addSubview(scrollView)
        for  i in stride(from: 0, to: movies.count, by: 1) {
            var frame = CGRect.zero
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(i)
            frame.origin.y = 0
            frame.size = self.scrollView.frame.size
            self.scrollView.isPagingEnabled = true

            
            
            let myImageView = UIImageView(frame: frame)
            //let myImageView:UIImageView = UIImageView()
            myImageView.image = UIImage(named: movies[i])
            myImageView.contentMode = UIView.ContentMode.scaleAspectFit
            myImageView.frame = frame
            //myImageView.size

            /*let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(systemName: movies[i])
            */
            //scrollView.addSubview(imgView)
            scrollView.addSubview(myImageView)
        }

        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(imagelist.count), height: self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: Selector(("changePage:")), for: UIControl.Event.valueChanged)
        // Do any additional setup after loading the view.
    }
    */
    
    
    /*func setupScreens() {
        for index in 0..<movies.count {
            // 1.
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            // 2.
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(systemName: movies[index])

            self.scrollView.addSubview(imgView)
        }

        // 3.
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(movies.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    */
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = imagelist.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.green
        self.view.addSubview(pageControl)

    }

    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    /*@objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
 */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
