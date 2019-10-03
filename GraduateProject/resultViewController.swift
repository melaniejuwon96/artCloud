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
import SwiftSoup

class resultViewController: UIViewController {
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var playButton: UIButton?
    var webURL = ""
    var content: String?
    var record: String?
    var please: String?
    
    //OUTLETS
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var xTitle: UILabel!
    @IBOutlet weak var xYear: UILabel!
    @IBOutlet weak var xAuthor: UILabel!
    @IBOutlet weak var xCopyright: UILabel!
    @IBOutlet weak var xContent: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation bar 제목
        self.navigationItem.title = "ArtCloud"
        let backItem = UIBarButtonItem()
        
        //parse the content
        guard let translate = URL(string: "http://ec2-13-209-142-168.ap-northeast-2.compute.amazonaws.com/translate.php")else{
            print("Error: url doesn't seem to be a valid URL")
            return
        }
        do{
            let myHTMLString = try String(contentsOf: translate, encoding: .utf8)
            print("\(myHTMLString)")
            content = "\(myHTMLString)"
        } catch let error{
            print("Error: \(error)")
        }
        
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
                // 웹 서버에서 결과 파싱
                guard let IMGURL = jsonArray[0]["IMGURL"] as? String else {return}
                guard let Title = jsonArray[0]["Title"] as? String else {return}
                guard let Author = jsonArray[0]["Author"] as? String else {return}
                guard let Adate = jsonArray[0]["ADate"] as? String else {return}
                self.webURL = (jsonArray[0]["URL"] as? String)!
                guard let GalleryName = jsonArray[0]["GalleryName"] as? String else {return}
                // 만약 결과가 NULL 이라면 'No Data' 출력
                if(IMGURL == "" || Title == "" || Author == "" || Adate == "" || GalleryName == ""){
                    print("NO DATA")
                }
    
                else {
                    // 사용자가 촬영한 사진이 맞는지 AlertDialog 를 통해 한번 더 검증을 받는다.
                    let imageUrl = URL(string: IMGURL)
                    let imgData = try Data(contentsOf: imageUrl!)
                    
                    var imageView = UIImageView(frame: CGRect(x:100, y:50, width: 70, height: 70))
                    imageView.image = UIImage(data: imgData)
                    
                    let alertController = UIAlertController(title: "찾으신 그림인가요?", message:
                        "\n\n\n\n", preferredStyle: UIAlertController.Style.alert)
                    //'네'라면 결과 화면을 보여준다.
                    alertController.addAction(UIAlertAction(title: "네", style: UIAlertAction.Style.default,handler: nil))
                    //'아니요'라면 Google Image Search Engine으로 이동
                    alertController.addAction(UIAlertAction(title: "아니요", style: UIAlertAction.Style.default, handler: {action in
                        //go take picture again
                        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cameraView") as? CameraViewController
                        {
                            self.present(vc, animated: true, completion: nil)
                        }
                        
                        guard let url = URL(string: "https://www.google.co.kr/imghp?hl=ko") else {return}
                        UIApplication.shared.open(url)
                        
                    }))
                    alertController.view.addSubview(imageView)
                    
                    self.present(alertController, animated: true, completion: nil)
        
                    // Assigning datas into the UI
                    let url = URL(string: IMGURL)
                    let data = try Data(contentsOf: url!)
            
                    DispatchQueue.main.async{
                        self.imageView.image = UIImage(data: data)
                        self.xTitle.text = "\(Title)"
                        self.xAuthor.text = Author
                        self.xYear.text = Adate
                        self.xCopyright.text = "©"+GalleryName
                        self.xContent.text = self.content
                    }
                }
            } catch let parsingError
            {
                print("Error", parsingError)
            }
        }
            task.resume()
    }
    //---------------------------------------------END OF viewDidLoad()---------------------------------------------------//
    @IBAction func webHost(_ sender: UIButton) {
        open(scheme: self.webURL)
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
        
        
        //parse the content
        guard let speech = URL(string: "http://ec2-13-209-142-168.ap-northeast-2.compute.amazonaws.com/execPythonSIFT.php")else{
            print("Error: url doesn't seem to be a valid URL")
            return
        }
        do{
            let myHTMLString = try String(contentsOf: speech, encoding: .utf8)
            record = myHTMLString
        } catch let error{
            print("Error: \(error)")
        }
        please = String(record!)
        if(String(please![please!.startIndex]) == "9"){
            guard let url = URL(string: "https://www.google.co.kr/imghp?hl=ko") else {return}
            UIApplication.shared.open(url)
            
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainViewController") as? ViewController{
                self.present(vc, animated: true, completion: nil)
            }
        }
        else{
            let url = URL(string: "http://ec2-13-209-142-168.ap-northeast-2.compute.amazonaws.com/TTSDir/GB/"+String(please![please!.startIndex])+".mp3")
            if(url == nil){
                print("NO RECORD")
            }
            else{
                print(url)
                let playerItem: AVPlayerItem = AVPlayerItem(url: url!)
                player = AVPlayer(playerItem: playerItem)
                
                let playerLayer = AVPlayerLayer(player: player!)
                playerLayer.frame = CGRect(x:0, y:0, width:10, height:50)
                self.view.layer.addSublayer(playerLayer)
                
                playButton = UIButton(type: UIButton.ButtonType.system) as UIButton
                let xPostion:CGFloat = 400
                let yPostion:CGFloat = 400
                let buttonWidth:CGFloat = 30
                let buttonHeight:CGFloat = 30
                
                playButton!.frame = CGRect(x: xPostion, y: yPostion, width: buttonWidth, height: buttonHeight)
                let soundImage = UIImage(named: "sound.png")
                playButton!.setImage(soundImage, for: .normal)
                playButton!.addTarget(self, action: #selector(resultViewController.playSound(_:)), for: .touchUpInside)
                
                self.view.addSubview(playButton!)
            }
        }
    }
    
    
    @IBAction func playSound(_ sender: Any) {
        if player?.rate == 0
        {
            player!.play()
            playButton!.setTitle("Pause", for: UIControl.State.normal)
        } else {
            player!.pause()
            playButton!.setTitle("Play", for: UIControl.State.normal)
        }
    }
}
