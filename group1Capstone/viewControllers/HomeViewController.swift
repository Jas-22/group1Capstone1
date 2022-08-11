//
//  HomeViewController.swift
//  group1Capstone
//
//  Created by Jazz Stephan on 08/08/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let images = [
    UIImage(named: "1.jpeg")!,
    UIImage(named: "2.jpeg")!,
    UIImage(named: "3.jpeg")!,
    UIImage(named: "4.jpeg")!,
    UIImage(named: "5.jpeg")!,
    UIImage(named: "6.jpeg")!,
    UIImage(named: "7.jpeg")!,
    ]
    
    var imageView1: [UIImageView] = []
    
    struct Card {
    var id:Int
    var image:UIImage
    var title:String
    }
    
    var card:[Card] = []
    
    var index = 0;
    @IBOutlet var imageView: UIImageView!
    var scrollImageTimer: Timer!

    @IBOutlet var cardStack1: UIStackView!
    @IBOutlet var scrollView1: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBAction func pagination(_ sender: Any) {
        
        imageView.image = images[pageControl.currentPage]
        index = pageControl.currentPage
        scrollImageTimer.invalidate()
        setTimer()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        imageView.image = images[index]
        imageView.contentMode = .scaleAspectFill
        setTimer()
        
//        cardStack1.distribution = .fillProportionally
        createCards()
        
//        scrollView1.addSubview(cardStack1)
        // Do any additional setup after loading the view.
    }
    
    
    func setTimer() {
    scrollImageTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }

    @objc func moveToNextPage() {
    
        
        index = index < 6 ? index + 1 : 0;
        imageView.image = images[index]
        pageControl.currentPage = index

    }
    
    func createCards(){
        
        for i in 0..<7{
            imageView1.append(UIImageView(frame: CGRect(x: 0, y:0,width:188.6, height:100)))

            imageView1[i].image = images[i]
            imageView1[i].contentMode = .scaleAspectFit
            imageView1[i].layer.cornerRadius = 18

            let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
                            imageView1[i].addGestureRecognizer(tapGR)
            imageView1[i].isUserInteractionEnabled = true
            cardStack1.addArrangedSubview(imageView1[i])
        }
    }
    
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
            if sender.state == .ended {
                    print("UIImageView tapped")
//
                
               
//                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationDetailsViewController") as! LocationDetailsViewController
                 
//                self.navigationController?.pushViewController(nextViewController, animated: true)
                
//                self.present(nextViewController, animated: true)
//
            }
    }
    


}
