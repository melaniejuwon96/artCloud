//
//  CameraViewController.swift
//  GraduateProject
//
//  Created by 유주원 on 07/11/2018.
//  Copyright © 2018 유주원. All rights reserved.
//

import UIKit
import MobileCoreServices //Swift 모든 데이터타입(미디어 등)이 정의되어 있는 헤더
import Alamofire

class CameraViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate {
    
    //카메라로 사진 찍은 후 들어갈 이미지
    @IBOutlet weak var imageView: UIImageView!
    
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage!
    var flagImageSave = false


    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigation bar 제목
        self.navigationItem.title = "ArtCloud"
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        //tool bar action 1: SCAN 2: Explore
        self.tabBarController?.delegate = self
    

    }


    // 1. 사진 촬영 기능
    @IBAction func scanClicked(_ sender: Any) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            flagImageSave = true
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
            
            
        }
        
    }
   // 2. 앨범 선택 기능
    @IBAction func photoClicked(_ sender: Any) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            flagImageSave = false
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
            
        }
    }

    // 사진 촬용 혹은 앨범에서 사진 선택할 경우 호출하는 함수
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            //사진을 가져와 captureImage 에 저장
            captureImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
            //flagImageSave 가 참이면 가져온 사진을 포토 라이브러리에 저장한다.
            if flagImageSave{
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            // imageView 변수에 촬영한 이미지 저장
            imageView.image = captureImage
        }
        //서버에 사진 업로드
        uploadImage(image: captureImage)
        self.dismiss(animated: true, completion: nil)
    
        // 결화 화면으로 이동
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "navigationVC")
        self.present(controller, animated: true, completion: nil)
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationVC") as? resultViewController
        {
            present(vc, animated: true, completion: nil)
        }
        
     
    }
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func uploadImage(image: UIImage){
        let fileName = "upload_file.jpg"
        print(fileName)
        
        var request = URLRequest(url: URL(string: "http://ec2-13-209-142-168.ap-northeast-2.compute.amazonaws.com/uploadImage.php")!)
        request.httpMethod = "POST"
        
        //파라미터 전달할 경우 사용하면 됨, php 에서 $_POST 로 받음
        let params = ["first": "ArtCloud"]
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createBody(parameters: params, boundary: boundary, data: image.jpegData(compressionQuality: 0.2)!, mimeType: "image/jpg", filename: fileName)
        
        //URLSession.shared.uploadTask(withStreamedRequest: r).resume()
        URLSession.shared.uploadTask(with: request, from: request.httpBody, completionHandler: {
            (data,response, error) -> Void in
            
            
        }).resume()
    }
    
    func createBody(parameters: [String: String], boundary: String, data: Data, mimeType: String, filename: String) ->Data{
        //let legacyBody = NSMutableData()
        var body = Data()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        for (key, value) in parameters{
            body.append(boundaryPrefix.data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        body.append(boundaryPrefix.data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        body.append(data)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--".appending(boundary.appending("--")).data(using: .utf8)!)
        
        //return legacyBody as Data
        return body
    }
}
extension NSMutableData{
    func appendString(_ string: String){
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}

