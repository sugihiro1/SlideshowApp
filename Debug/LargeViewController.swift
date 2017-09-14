//
//  LargeViewController.swift
//  Debug
//
//  Created by 杉山尋美 on 2017/09/12.
//  Copyright © 2017年 hiromi.sugiyama. All rights reserved.
//

import UIKit

class LargeViewController: UIViewController {

  // 画像データ配列
  let imageData = ["image1.jpg","image2.jpg","image3.jpg","image4.jpg","image5.jpg"]
  
  // 画像No
  var imageDataNo: Int = 0
  
  @IBOutlet weak var imageView: UIImageView!
  

  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        displayImage(imageDataNo)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  //画像を表示する共通function
  func displayImage (_ imageDataNo:Int) {
    
    // UIImageのインスタンスを生成
    let imageDisp:UIImage = UIImage(named:imageData[imageDataNo])!
    
    // 画像をimageViewに設定
    imageView.image = imageDisp
    
    // UIImageViewのインスタンスをビューに追加
    self.view.addSubview(imageView)
    
  }

}
