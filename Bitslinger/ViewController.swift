//
//  ViewController.swift
//  Bitslinger
//
//  Created by Michelle on 2018/10/13.
//  Copyright © 2018 JAY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numScreen:Int = 0;
    var previousNum:Int = 0;
    var doingMath = false;
    var lastOp = false;
    var operation = 23;
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var clear: UIButton!
    
    @IBOutlet weak var division: UIButton!
    @IBOutlet weak var multiplication: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var plus: UIButton!
    
    @IBAction func clear(_ sender: Any ){
        
            label.text = "0X0";
            clear.setTitle("AC", for: .normal)
        
    }
    
    @IBAction func operations(_ sender: UIButton) {
        
        var Str:String = label.text!;
        if( sender.tag == 24 && doingMath == true) {
            
            if( Str.count >= 2 ) {
                Str.removeFirst();
                Str.removeFirst();
            }
            
            numScreen = Int(Str, radix:16)!;
            
            label.text = "";
            
            if( operation == 20) {
                label.text = "0X" + String( previousNum / numScreen, radix: 16, uppercase: true );
            } else if( operation == 21 ) {
                label.text = "0X" + String( previousNum * numScreen, radix: 16, uppercase: true );
            } else if( operation == 22 ) {
                label.text = "0X" + String( previousNum - numScreen, radix: 16, uppercase: true );
            } else if( operation == 23 ) {
                label.text = "0X" + String( previousNum + numScreen, radix: 16, uppercase: true );
            }
            
            doingMath = false;
            return;
        } else if( sender.tag >= 20 && sender.tag <= 23){
            operation = sender.tag;
            
            if( Str.count >= 2 ) {
                Str.removeFirst();
                Str.removeFirst();
            }
            
            previousNum = Int(Str, radix:16)!;
            
            doingMath = true;
            lastOp = true;
            
        }
    }
    @IBAction func numbers(_ sender: UIButton) {
        var newStr:String = "";
        
        if( label.text!.count == 18 ) {
            // Play negative sound
            return
        }
    
        
        if( label.text == "0X0" || label.text == "" || (doingMath == true && lastOp == true)) {
            label.text = "0X";
            clear.setTitle("C", for: .normal)
            
            if( lastOp == true ) {
            lastOp = false;
            }
        }
        
        if( sender.tag <= 16 && sender.tag >= 2 ) {
            newStr = label.text! + String(sender.tag-1, radix:16).uppercased();
        }
        else {
            if( sender.tag  == 17 || sender.tag == 1 ) {
                if(label.text != "0X0" && label.text != "0X" ) {
                    if( sender.tag == 17 ) {
                        newStr =  label.text! + "00";
                    } else {
                        newStr =  label.text! + "0";
                    }
                    
                } else if( label.text == "0X" ){
                    newStr = "0X0";
                } else {
                    return
                }
            }
            else if( sender.tag == 18 ) {
                newStr =  label.text! + String(255, radix:16).uppercased();
            }
        }
        label.text = newStr;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

