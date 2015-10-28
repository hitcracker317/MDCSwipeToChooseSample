//
//  ViewController.swift
//  tinderUISample
//
//  Created by 前田 晃良 on 2015/10/27.
//  Copyright (c) 2015年 A.M. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,MDCSwipeToChooseDelegate{
    
    var leftChooseCount = 0
    var rightChooseCount = 0
    var imageArray:[String] = ["image1.jpg","image2.jpg","image3.jpg","image4.jpg","image5.jpg","image6.jpg","image7","image8","image9","image10.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for image in imageArray{
            var imageString = image as! String
            var swipeImage = self.createSwipeImage(imageName: imageString)
            self.view.addSubview(swipeImage)
        }
        
        let names = ["Anna", "Alex", "Brian", "Jack"]
        for name in names {
            println("Hello, \(name)!")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //画像を生成して返すメソッド
    func createSwipeImage(#imageName:String) -> UIView{
        var options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "YES"
        options.likedColor = UIColor.redColor()
        options.nopeColor = UIColor.blueColor()
        options.nopeText = "NO"
        options.onPan = { state -> Void in
            if state.thresholdRatio == 1 && state.direction == MDCSwipeDirection.Left {
                println("Photo deleted!")
            }
        }
        
        var rect:CGRect = CGRectMake(self.view.bounds.size.width/2 - 120, self.view.bounds.size.height/2 - 150, 240, 300)
        var createSwipeImage:MDCSwipeToChooseView = MDCSwipeToChooseView(frame: rect, options: options)
        createSwipeImage.imageView.image = UIImage(named: imageName)
        createSwipeImage.imageView.contentMode = .ScaleAspectFill
        
        return createSwipeImage
    }
    
    // 左か右か決めなかったら呼ばれるメソッド
    func viewDidCancelSwipe(view: UIView) -> Void{
        println("Couldn't decide, huh?")
    }
    
    //左か右のどちらかに傾き切ったら、どちらを選択したのか確定
    func view(view: UIView, shouldBeChosenWithDirection: MDCSwipeDirection) -> Bool{
        if (shouldBeChosenWithDirection == MDCSwipeDirection.Left) {
            return true; //NO
        } else if (shouldBeChosenWithDirection == MDCSwipeDirection.Right){
            return true; //YES
        } else {
            // Snap the view back and cancel the choice.
            UIView.animateWithDuration(0.16, animations: { () -> Void in
                view.transform = CGAffineTransformIdentity
                view.center = view.superview!.center
            })
            return false;
        }
    }
    
    //左か右、どちらを選択したのか確定したら呼ばれるメソッド
    func view(view: UIView, wasChosenWithDirection: MDCSwipeDirection) -> Void{
        if wasChosenWithDirection == MDCSwipeDirection.Left {
            println("Photo deleted!")
            leftChooseCount++
        }else {
            println("Photo saved!")
            rightChooseCount++
        }
        
        if ((leftChooseCount + rightChooseCount) == imageArray.count){
            self.showResult()
        }
    }
    
    func showResult(){
        var leftChooseLabel:UILabel = UILabel(frame: CGRectMake(self.view.bounds.size.width/2 - 60, self.view.bounds.size.height/2 + 50, 120, 50))
        leftChooseLabel.text = "NO：\(leftChooseCount)"
        leftChooseLabel.textColor = UIColor.blueColor()
        leftChooseLabel.font = UIFont(name:"kevin_eleven_" , size: 30)
        leftChooseLabel.textAlignment = .Center
        self.view.addSubview(leftChooseLabel)
        
        
        var rightChooseLabel:UILabel = UILabel(frame: CGRectMake(self.view.bounds.size.width/2 - 60, self.view.bounds.size.height/2 - 250, 120, 50))
        rightChooseLabel.text = "YES：\(rightChooseCount)"
        rightChooseLabel.textColor = UIColor.redColor()
        rightChooseLabel.font = UIFont(name:"kevin_eleven_" , size: 30)
        rightChooseLabel.textAlignment = .Center
        self.view.addSubview(rightChooseLabel)
        
        //TODO：Yes,Noの選択した画像を表示したい
    }

}

