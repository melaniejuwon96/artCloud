//
//  CameraViewController.swift
//  GraduateProject
//
//  Created by 유주원 on 07/11/2018.
//  Copyright © 2018 유주원. All rights reserved.
//

import UIKit
import MobileCoreServices //Swift 모든 데이터타입(미디어 등)이 정의되어 있는 헤더

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



    @IBAction func scanClicked(_ sender: Any) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            flagImageSave = true
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
            
            
        }
        
    }
   
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

//    @IBAction func exploreClicked(_ sender: Any) {
//    }


    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        print(mediaType)
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            //사진을 가져와 captureImage 에 저장
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            //flagImageSave 가 참이면 가져온 사진을 포토 라이브러리에 저장한다.
            if flagImageSave{
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            imageView.image = captureImage
        }
        self.dismiss(animated: true, completion: nil)
        
        //After dismissing -- openCV func()----
        //After openCV -- segue to resultViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "navigationVC")
        self.present(controller, animated: true, completion: nil)
        
        // Safe Present
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationVC") as? resultViewController
        {
            present(vc, animated: true, completion: nil)
        }
     
    }
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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
