//
//  ARViewController.swift
//  GraduateProject
//
//  Created by 유주원 on 22/12/2018.
//  Copyright © 2018 유주원. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
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
    func addImage(){
        
        let ramImage = UIImage(named: "ram")
        let ramNode = SCNNode(geometry: SCNPlane(width:0.2, height:0.2))
        ramNode.geometry?.firstMaterial?.diffuse.contents = ramImage
        ramNode.position = SCNVector3(-0.1, 0.1, -0.4)
        ramNode.name = "ram"
        sceneView.scene.rootNode.addChildNode(ramNode)
        
        let hoaImage = UIImage(named: "hoa")
        let hoaNode = SCNNode(geometry: SCNPlane(width:0.2, height: 0.2))
        hoaNode.geometry?.firstMaterial?.diffuse.contents = hoaImage
        hoaNode.position = SCNVector3(0.15, 0.1, -0.4)
        hoaNode.name = "hoa"
        sceneView.scene.rootNode.addChildNode(hoaNode)
        
        let mummyImage = UIImage(named: "mummy")
        let mummyNode = SCNNode(geometry: SCNPlane(width:0.2, height: 0.2))
        mummyNode.geometry?.firstMaterial?.diffuse.contents = mummyImage
        mummyNode.position = SCNVector3(0.15, -0.15, -0.4)
        mummyNode.name = "mummy"
        sceneView.scene.rootNode.addChildNode(mummyNode)
        
        let koreaImage = UIImage(named: "korea")
        let koreaNode = SCNNode(geometry: SCNPlane(width:0.2, height: 0.2))
        koreaNode.geometry?.firstMaterial?.diffuse.contents = koreaImage
        koreaNode.position = SCNVector3(-0.1,-0.15,-0.4)
        koreaNode.name = "korea"
        sceneView.scene.rootNode.addChildNode(koreaNode)
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

    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else { return }
        
        if node.name == "hoa"{
            let hoaInfo = UIImage(named: "hoaInfo")
            let hoaInfoNode = SCNNode(geometry: SCNPlane(width:0.5, height:0.05))
            hoaInfoNode.geometry?.firstMaterial?.diffuse.contents = hoaInfo
            hoaInfoNode.position = SCNVector3(0.05, 0, -0.2)
            hoaInfoNode.name = "Info"
            sceneView.scene.rootNode.addChildNode(hoaInfoNode)
        }
        else if node.name == "ram"{
            let ramInfo = UIImage(named: "ramInfo")
            let ramInfoNode = SCNNode(geometry: SCNPlane(width:0.5, height:0.05))
            ramInfoNode.geometry?.firstMaterial?.diffuse.contents = ramInfo
            ramInfoNode.position = SCNVector3(0.05, 0, -0.2)
            ramInfoNode.name = "Info"
            sceneView.scene.rootNode.addChildNode(ramInfoNode)
        }
        else if node.name == "korea"{
            let koreaInfo = UIImage(named: "koreaInfo")
            let koreaInfoNode = SCNNode(geometry: SCNPlane(width:0.5, height:0.05))
            koreaInfoNode.geometry?.firstMaterial?.diffuse.contents = koreaInfo
            koreaInfoNode.position = SCNVector3(0.05, 0, -0.2)
            koreaInfoNode.name = "Info"
            sceneView.scene.rootNode.addChildNode(koreaInfoNode)
            
        }
        else if node.name == "mummy"{
            let mummyInfo = UIImage(named: "mummyInfo")
            let mummyInfoNode = SCNNode(geometry: SCNPlane(width:0.5, height:0.05))
            mummyInfoNode.geometry?.firstMaterial?.diffuse.contents = mummyInfo
            mummyInfoNode.position = SCNVector3(0.05, 0, -0.2)
            mummyInfoNode.name = "Info"
            sceneView.scene.rootNode.addChildNode(mummyInfoNode)
            
        }
        else if node.name == "Info"{
            node.removeFromParentNode()
        }
    }
    

}
