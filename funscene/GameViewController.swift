//
//  GameViewController.swift
//  funscene
//
//  Created by ipad_kid on 7/15/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

import ARKit

class GameViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var arSceneView: ARSCNView!
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var arSwitch: UISwitch!
    
    private var scene: SCNScene! = SCNScene(named: "main.scn")
    
    private func loadScene() {
        let mySceneView: SCNView = arSwitch.isOn ? arSceneView : sceneView
        let notMyScnView: SCNView = arSwitch.isOn ? sceneView : arSceneView
        notMyScnView.isHidden = true
        mySceneView.isHidden = false
        mySceneView.scene = notMyScnView.scene
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.scene = scene
        arSceneView.scene = scene
        loadScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if arSwitch.isOn {
            arSceneView.session.run(ARWorldTrackingSessionConfiguration())
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if arSwitch.isOn {
            arSceneView.session.pause()
        }
    }
    
    private func setBox(color: UIColor) {
        guard let box: SCNNode = scene.rootNode.childNode(withName: "box", recursively: true), let geoBox: SCNGeometry = box.geometry, let boxMaterial: SCNMaterial = geoBox.firstMaterial else { return }
        boxMaterial.diffuse.contents = color
    }
    
    @IBAction func setWhite() {
        setBox(color: .white)
    }
    
    @IBAction func setBlue() {
        setBox(color: .blue)
    }
    
    @IBAction func arSwitchHit() {
        if arSwitch.isOn {
            arSceneView.session.run(ARWorldTrackingSessionConfiguration())
        } else {
            arSceneView.session.pause()
            scene.background.contents = UIColor.darkGray
        }
        
        loadScene()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
