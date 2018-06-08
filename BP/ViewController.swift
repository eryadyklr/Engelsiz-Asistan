//
//  ViewController.swift
//  BP
//
//  Created by Yasin Turpcu on 7.03.2018.
//  Copyright © 2018 Yasin Turpcu. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController , SFSpeechRecognizerDelegate{
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    @IBOutlet weak var TextViewReco: UITextView!
    @IBOutlet weak var SiriBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapped(_ sender: Any) {
        
    }
    
}

