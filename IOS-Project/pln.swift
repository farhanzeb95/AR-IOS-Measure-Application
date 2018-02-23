//
//  pln.swift
//  IOS-Project
//
//  Created by Farhan Zeb Malik on 06.02.18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit
import ARKit

class Plan: SCNNode {
    
    var plngeo: SCNBox?
    var anch: ARPlaneAnchor?
    init(anch: ARPlaneAnchor) {
        
		super.init()
        
		let wid = CGFloat(anch.extent.x)
        let len = CGFloat(anch.extent.z)
        let planeHeight = 0.01 as CGFloat
        self.plngeo = SCNBox(width: wid, height: planeHeight, length: len, chamferRadius: 0)
        let material = SCNMaterial()
        let image = UIImage(named: "grid")
        material.diffuse.contents = image
        let transmat = SCNMaterial()
        transmat.diffuse.contents = UIColor.white.withAlphaComponent(0.0)
        self.plngeo?.materials = [transmat, transmat, transmat, transmat, material, transmat]
        let plnNod = SCNNode(geometry: self.plngeo)
        plnNod.position = SCNVector3(0, -planeHeight/2.0 , 0)
        self.addChildNode(plnNod)
        
		setTxtureScl()
    }
    
	func updateWith(_ anch: ARPlaneAnchor) {
        
		self.plngeo?.width = CGFloat(anch.extent.x)
        self.plngeo?.length = CGFloat(anch.extent.z)
        self.position = SCNVector3(anch.center.x, 0, anch.center.z)
        
        
        setTxtureScl()
    }
    
    func setTxtureScl()
    {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
		fatalError("init(coder:) has not been implemented")
    }
}
    
    
    
    
    
    
    
    
    
    
    

    

