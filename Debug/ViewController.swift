//
//  ViewController.swift
//  Debug
//
//  Created by 杉山尋美 on 2017/09/11.
//  Copyright © 2017年 hiromi.sugiyama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // 画像データ配列
  let imageData = ["image1.jpg","image2.jpg","image3.jpg","image4.jpg","image5.jpg"]
  
  // 画像No
  var imageDataNo: Int = 0
  
  var timer: Timer! = nil
  
  // slideShow（自動送り）実行中か否か
  var showStarted: Bool = false

  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var showGoStop: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 起動時は１番目の画像を表示する
    displayImage(0)
    
    showGoStop.setTitle("再生", for: .normal)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
  //「進む」ボタンがクリックされた
  @IBAction func nextImage(_ sender: Any) {
    // slideShow 実行中の場合は抜ける
    if showStarted {
      return
    } else {
      showNextImage()
    }
  }
  
  // 画像Noを増やし、画像を表示する
  func showNextImage() {
    // 画像Noを一つずつ増やす
    if imageDataNo == imageData.count - 1 {
      imageDataNo = 0
    } else {
      imageDataNo += 1
    }
    
    // 画像を表示する
    displayImage(imageDataNo)
    
  }

  //「戻る」ボタンがクリックされた
  @IBAction func prevImage(_ sender: Any) {
    // slideShow 実行中の場合は抜ける
    if showStarted {
      return
    }

    // 画像Noを一つずつ減らす
    if imageDataNo == 0 {
      imageDataNo = imageData.count - 1
    } else {
      imageDataNo -= 1
    }
    
    // 画像を表示する
    displayImage(imageDataNo)

  }
  
  //「再生/停止」ボタンがクリックされた
  @IBAction func slideShow(_ sender: Any) {
    //「停止」ボタン
    if showStarted {
      self.timer.invalidate()
      self.timer = nil
      showStarted = false
      showGoStop.setTitle("再生", for: .normal)

    //「再生」ボタン
    } else {
      showStarted = true
      showGoStop.setTitle("停止", for: .normal)
      startShow()
    }
  }
  
  // slideShowの実行
  func startShow() {
    // 画像Noを増やし、画像を表示する
    showNextImage()
    
    // タイマーの生成、始動、2秒後にupdateTimerにメッセージを送る
    if self.timer == nil {
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
      }
  }
  
  //タイマー生成2秒後にメッセージを受け取る
  func updateTimer(timer: Timer) {
    //タイマーを一旦止める
    self.timer.invalidate()
    self.timer = nil
    
    // slideShowの実行を繰り返す
    startShow()
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
  

  //画像がクリックされた
  @IBAction func onTapImage(_ sender: Any) {
    // slideShow 実行中の場合はslideShowを止める
    if showStarted {
      self.timer.invalidate()
      self.timer = nil
      showStarted = false
      showGoStop.setTitle("再生", for: .normal)
    }
   
    //セグエを実行する
    performSegue(withIdentifier: "largeImageViewer", sender: nil)
  }

  //セグエの準備
  override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    let largeViewController:LargeViewController = segue.destination as! LargeViewController

    // largeViewControllerに画像Noを渡す
    largeViewController.imageDataNo = self.imageDataNo
  }
  
  //largeViewControllerからsegueを使い戻ってきた
  @IBAction func unwind(_ segue: UIStoryboardSegue){
    
  }
  
}
