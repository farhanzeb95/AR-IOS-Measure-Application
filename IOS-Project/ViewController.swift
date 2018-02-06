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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

