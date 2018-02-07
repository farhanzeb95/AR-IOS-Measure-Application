//
//  ViewController.swift
//  IOS-Project
//
//  Created by Farhan Zeb Malik on 30.01.18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var srscene: ARSCNView!
    var dicplan = [ARPlaneAnchor : Plan]()
    
    @IBOutlet weak var measurementlbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setsceneview()
    }
    
    func setsceneview(){
        self.srscene.delegate = self
        self.srscene.showsStatistics = true
        self.srscene.autoenablesDefaultLighting = true
        self.srscene.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        let scn = SCNScene()
        self.srscene.scene =  scn
        

    }
    var stnode: SCNNode?

    @IBAction func btn_add(_ sender: UIButton) {
        if let posit = self.ExistPlanes(){
            let node = self.nodeWithPosition(posit)
            srscene.scene.rootNode.addChildNode(node)
            stnode = node
        }

    }
    func ExistPlanes() -> SCNVector3?
    {
        let results = srscene.hitTest(view.center,
                                        types: .existingPlaneUsingExtent)
        
        if let result = results.first {
            
            let hitPos = self.positFromTrans(result.worldTransform)
            return hitPos
        }
        return nil
        
    }
    func positFromTrans(_ transform: matrix_float4x4) -> SCNVector3 {
        return SCNVector3Make(transform.columns.3.x,
                              transform.columns.3.y,
                              transform.columns.3.z)
    }
    func nodeWithPosition(_ position: SCNVector3) -> SCNNode {
        let sph = SCNSphere(radius: 0.003)
        sph.firstMaterial?.diffuse.contents = UIColor(red: 255/255.0,
                                                         green: 153/255.0,
                                                         blue: 83/255.0,
                                                         alpha: 1)
        sph.firstMaterial?.lightingModel = .constant
        sph.firstMaterial?.isDoubleSided = true
        let node = SCNNode(geometry: sph)
        node.position = position
        
        return node
    }
    //2nd Commit Ready to push
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

