//
//  OrangerieARViewController.swift
//  GraduateProject
//
//  Created by 유주원 on 08/01/2019.
//  Copyright © 2019 유주원. All rights reserved.
//

import UIKit
import ARKit
import SceneKit


class OrangerieARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Tap Gesture
        addTapGestureToSceneView()
        //Add Image
        addImage()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    // ARViewController 화면에 나타나는 주요 작품들을 불러오는 함수
    func addImage(){
        let clownImage = UIImage(named: "clown")
        let clownNode = SCNNode(geometry: SCNPlane(width:0.2, height:0.2))
        clownNode.geometry?.firstMaterial?.diffuse.contents = clownImage
        clownNode.position = SCNVector3(-0.1, 0.1, -0.4)
        clownNode.name = "clown"
        sceneView.scene.rootNode.addChildNode(clownNode)
        
        let monetImage = UIImage(named: "monet")
        let monetNode = SCNNode(geometry: SCNPlane(width:0.2, height: 0.2))
        monetNode.geometry?.firstMaterial?.diffuse.contents = monetImage
        monetNode.position = SCNVector3(0.15, 0.1, -0.4)
        monetNode.name = "monet"
        sceneView.scene.rootNode.addChildNode(monetNode)
        
        let pianoImage = UIImage(named: "piano")
        let pianoNode = SCNNode(geometry: SCNPlane(width:0.2, height: 0.2))
        pianoNode.geometry?.firstMaterial?.diffuse.contents = pianoImage
        pianoNode.position = SCNVector3(0.15, -0.15, -0.4)
        pianoNode.name = "piano"
        sceneView.scene.rootNode.addChildNode(pianoNode)
        
        let womanImage = UIImage(named: "womanw")
        let womanNode = SCNNode(geometry: SCNPlane(width:0.2, height: 0.2))
        womanNode.geometry?.firstMaterial?.diffuse.contents = womanImage
        womanNode.position = SCNVector3(-0.1,-0.15,-0.4)
        womanNode.name = "woman"
        sceneView.scene.rootNode.addChildNode(womanNode)
    }
    
    
    func createTextNode(string: String, Float: Float) -> SCNNode{
        
        let text = SCNText(string: string, extrusionDepth: 0.1)
        text.font = UIFont.systemFont(ofSize: 1.0)
        text.flatness = 0.01
        text.firstMaterial?.diffuse.contents = UIColor.black
        
        let textNode = SCNNode(geometry: text)
        textNode.scale = SCNVector3(Float, Float, -0.01)
        
        return textNode
    }
    
    func addText(string: String, parent:ARSCNView, Float: Float){
        let textNode = self.createTextNode(string: string, Float: Float)
        textNode.position = SCNVector3Zero
        textNode.name = "textNode"
        parent.scene.rootNode.addChildNode(textNode)
        
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    // 정보를 원하는 사진을 클릭했을 경우, 상세 정보 표출을 위한 함수 
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else { return }
        
        if node.name == "clown"{
            let clownInfo = UIImage(named: "clownInfo")
            let clownInfoNode = SCNNode(geometry: SCNPlane(width:0.5, height:0.05))
            clownInfoNode.geometry?.firstMaterial?.diffuse.contents = clownInfo
            clownInfoNode.position = SCNVector3(0.05, 0, -0.2)
            clownInfoNode.name = "Info"
            sceneView.scene.rootNode.addChildNode(clownInfoNode)
        }
        else if node.name == "monet"{
            let monetInfo = UIImage(named: "monetInfo")
            let monetInfoNode = SCNNode(geometry: SCNPlane(width:0.5, height:0.05))
            monetInfoNode.geometry?.firstMaterial?.diffuse.contents = monetInfo
            monetInfoNode.position = SCNVector3(0.05, 0, -0.2)
            monetInfoNode.name = "Info"
            sceneView.scene.rootNode.addChildNode(monetInfoNode)
        }
        else if node.name == "piano"{
            let pianoInfo = UIImage(named: "pianoInfo")
            let pianoInfoNode = SCNNode(geometry: SCNPlane(width:0.5, height:0.05))
            pianoInfoNode.geometry?.firstMaterial?.diffuse.contents = pianoInfo
            pianoInfoNode.position = SCNVector3(0.05, 0, -0.2)
            pianoInfoNode.name = "Info"
            sceneView.scene.rootNode.addChildNode(pianoInfoNode)
            
        }
        else if node.name == "woman"{
            let womanInfo = UIImage(named: "whiteInfo")
            let womanInfoNode = SCNNode(geometry: SCNPlane(width:0.5, height:0.05))
            womanInfoNode.geometry?.firstMaterial?.diffuse.contents = womanInfo
            womanInfoNode.position = SCNVector3(0.05, 0, -0.2)
            womanInfoNode.name = "Info"
            sceneView.scene.rootNode.addChildNode(womanInfoNode)
            
        }
        else if node.name == "Info"{
            node.removeFromParentNode()
        }
    }
    


}
