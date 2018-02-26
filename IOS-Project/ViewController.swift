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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setsess()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        srscene.session.pause()
    }
    func setsess()
    {
        let conf = ARWorldTrackingConfiguration()
        conf.planeDetection = .horizontal
        self.srscene.session.run(conf)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    var line_node: SCNNode?
    func renderer(_ renderer: SCNSceneRenderer,
                  updateAtTime time: TimeInterval) {
        
        DispatchQueue.main.async {
            
            guard let currentPosition = self.ExistPlanes(),
                let start = self.stnode else {
                    return
            }
            self.line_node?.removeFromParentNode()
            self.line_node = self.getDrawnLineFrom(pos1: currentPosition,
                                                   toPos2: start.position)
            self.srscene.scene.rootNode.addChildNode(self.line_node!)
            let desc = self.getDistStriBew(pos1: currentPosition,
                                                    pos2: start.position)
            DispatchQueue.main.async {
                self.measurementlbl.text = desc

        }
}
    
}
    func getDrawnLineFrom(pos1: SCNVector3,
                          toPos2: SCNVector3) -> SCNNode {
        
        let line = linfrm(vector: pos1, toVector: toPos2)
        let lineInBetween1 = SCNNode(geometry: line)
        return lineInBetween1
    }
    func linfrm(vector vector1: SCNVector3,
                  toVector vector2: SCNVector3) -> SCNGeometry {
        
        let indices: [Int32] = [0, 1]
        let source = SCNGeometrySource(vertices: [vector1, vector2])
        let element = SCNGeometryElement(indices: indices,
                                         primitiveType: .line)
        return SCNGeometry(sources: [source], elements: [element])
    }
    func getDistStriBew(pos1: SCNVector3?,
                                 pos2: SCNVector3?) -> String {
        
        if pos1 == nil || pos2 == nil {
            return "0"
        }
       
}



