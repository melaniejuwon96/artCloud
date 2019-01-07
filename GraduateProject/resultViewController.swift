//
//  resultViewController.swift
//  GraduateProject
//
//  Created by 유주원 on 04/12/2018.
//  Copyright © 2018 유주원. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class resultViewController: UIViewController {
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var playButton: UIButton?
    var webURL = ""
    let yame="이 사진의 정확한 배경은 밝혀지지 않았지만, 아마도 파리 서쪽에 있는 차투의 리버 세인(River Seine)을 보여주고 있을 것이다. 르누아르는 1870년대에 센느강에서 많은 '공중' 보트 장면들을 그렸다. 이 예에서, 강의 푸른색에 대한 스키프의 주황색 빛깔은 보충적인 색깔의 사용을 이용한다. 파란색과 주황색은 색상 눈금의 반대편이기 때문에 병렬로 연결되면 더 강해진다.이 사진의 정확한 배경은 밝혀지지 않았지만, 아마도 파리 서쪽에 있는 차투의 리버 세인(River Seine)을 보여주고 있을 것이다. 르누아르는 1870년대에 센느강에서 많은 '공중' 보트 장면들을 그렸다. 이 예에서, 강의 푸른색에 대한 스키프의 주황색 빛깔은 보충적인 색깔의 사용을 이용한다. 파란색과 주황색은 색깔의 반대편이기 때문에, 대각선이 되면 더 강해진다."
    
    //OUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var xTitle: UILabel!
    @IBOutlet weak var xYear: UILabel!
    @IBOutlet weak var xAuthor: UILabel!
    @IBOutlet weak var xContent: UILabel!
    @IBOutlet weak var xCopyright: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //navigation bar 제목
        self.navigationItem.title = "ArtCloud"
        let backItem = UIBarButtonItem()
    
        
        //Content Parse
        let con = parseContent()
        //print("***********************",con)
        
        //Parse the rest of the information
        guard let url = URL(string: "http://ec2-13-209-142-168.ap-northeast-2.compute.amazonaws.com/doNotDelete_JSON.php") else
        {
            return
            
        }
        let task = URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in guard let dataResponse = data, error == nil else
            {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            
            do
            {
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])

                guard let jsonArray = jsonResponse as? [[String: Any]] else
                {
                    return
                }
                // Parsing datas from web
                guard let IMGURL = jsonArray[3]["IMGURL"] as? String else {return}
                guard let Title = jsonArray[3]["Title"] as? String else {return}
                guard let Author = jsonArray[3]["Author"] as? String else {return}
                guard let Adate = jsonArray[3]["ADate"] as? String else {return}
                self.webURL = (jsonArray[3]["URL"] as? String)!
                guard let GalleryName = jsonArray[3]["GalleryName"] as? String else {return}
            
        
                // Assigning datas into the UI
                let url = URL(string: IMGURL)
                let data = try Data(contentsOf: url!)
        
                DispatchQueue.main.async{
                    self.imageView.image = UIImage(data: data)
                    self.xTitle.text = "\(Title)"
                    self.xAuthor.text = Author
                    self.xYear.text = Adate
                    self.xContent.text = self.yame
                    self.xCopyright.text = GalleryName
                }
            } catch let parsingError
            {
                print("Error", parsingError)
            }
        }
            task.resume()
    }
    @IBAction func webHost(_ sender: UIButton) {
        open(scheme: self.webURL)
        print("Hello World")
    }
    func open(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(scheme): \(success)")
                })
            } else {
                let success = UIApplication.shared.openURL(url)
                print("Open \(scheme): \(success)")
            }
        }
    }
    override func viewWillAppear(_ animted: Bool){
        super.viewWillAppear(animted)
        
        let url = URL(string: "http://ec2-13-209-142-168.ap-northeast-2.compute.amazonaws.com/TTSDir/GB/4.mp3")
        let playerItem: AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player!)
        playerLayer.frame = CGRect(x:0, y:0, width:10, height:50)
        self.view.layer.addSublayer(playerLayer)
        
        playButton = UIButton(type: UIButton.ButtonType.system) as UIButton
        let xPostion:CGFloat = 270
        let yPostion:CGFloat = 350
        let buttonWidth:CGFloat = 30
        let buttonHeight:CGFloat = 30
        
        playButton!.frame = CGRect(x: xPostion, y: yPostion, width: buttonWidth, height: buttonHeight)
        let soundImage = UIImage(named: "sound.png")
        playButton!.setImage(soundImage, for: .normal)
       // playButton!.backgroundColor = UIColor.lightGray
       // playButton!.setTitle("Play", for: UIControl.State.normal)
       // playButton!.tintColor = UIColor.black
        playButton!.addTarget(self, action: #selector(resultViewController.playSound(_:)), for: .touchUpInside)
        
        self.view.addSubview(playButton!)
    }
    

    
    //Parse Content function
    func parseContent() -> String{
        var con = ""
        guard let url = URL(string: "http://ec2-13-209-142-168.ap-northeast-2.compute.amazonaws.com/please_utf.php") else
        {
            return "Error"
            
        }
        let task = URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in guard let dataResponse = data, error == nil else
            {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            
            do
            {
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                
                guard let jsonArray = jsonResponse as? [[String: Any]] else
                {
                    return
                }
                // Parsing datas from web
                con = (jsonArray[1]["translatedText"] as? String)!
               // con = Content
                
                // Assigning datas into the UI
//                DispatchQueue.main.async{
//                    self.xContent.text = Content
//                }
            } catch let parsingError
            {
                print("Error", parsingError)
            }
        }
        task.resume()
        return con
    }
    
    @IBAction func playSound(_ sender: Any) {
        if player?.rate == 0
        {
            player!.play()
            //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
            playButton!.setTitle("Pause", for: UIControl.State.normal)
        } else {
            player!.pause()
            //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
            playButton!.setTitle("Play", for: UIControl.State.normal)
        }
        
    }
    
}
