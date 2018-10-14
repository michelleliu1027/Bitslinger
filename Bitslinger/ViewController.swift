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
    var operation = 0;
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var clear: UIButton!
    
    @IBOutlet weak var division: UIButton!
    @IBOutlet weak var multiplication: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var plus: UIButton!
    
    @IBAction func clear(_ sender: Any ){
        
            label.text = "0X0";
            clear.setTitle("AC", for: .normal)
            operation = 0;
        
    }
    
    @IBAction func operations(_ sender: UIButton) {
        
        var Str:String = label.text!;
        if( Str.count >= 2 ) {
            Str.removeFirst();
            Str.removeFirst();
        }
        if( sender.tag == 24 && doingMath == true) {
            
        
            
            numScreen = Int(Str, radix:16)!;
            
            label.text = "";
            
            if( operation == 20) {
                if( numScreen ==  0 ) {
                    label.text = "0X0";
                } else {
                    label.text = "0X" + String( previousNum / numScreen, radix: 16, uppercase: true );
                }
            } else if( operation == 21 ) {
                label.text = "0X" + String( previousNum * numScreen, radix: 16, uppercase: true );
            } else if( operation == 22 ) {
                label.text = "0X" + String( previousNum - numScreen, radix: 16, uppercase: true );
            } else if( operation == 23 ) {
                label.text = "0X" + String( previousNum + numScreen, radix: 16, uppercase: true );
            }
            
            if( division.backgroundColor == UIColor.red ) {
                division.backgroundColor = UIColor.blue;
            } else if ( multiplication.backgroundColor == UIColor.red ) {
                multiplication.backgroundColor = UIColor.blue;
            } else if ( minus.backgroundColor == UIColor.red ) {
                minus.backgroundColor = UIColor.blue;
            } else if ( plus.backgroundColor == UIColor.red ) {
                plus.backgroundColor = UIColor.blue;
            }
           
            
            return;
        } else if( sender.tag >= 20 && sender.tag <= 23){
            if( division.backgroundColor == UIColor.red ) {
                division.backgroundColor = UIColor.blue;
            } else if ( multiplication.backgroundColor == UIColor.red ) {
                multiplication.backgroundColor = UIColor.blue;
            } else if ( minus.backgroundColor == UIColor.red ) {
                minus.backgroundColor = UIColor.blue;
            } else if ( plus.backgroundColor == UIColor.red ) {
                plus.backgroundColor = UIColor.blue;
            }
            if( sender.tag == 20 ) {
                division.backgroundColor = UIColor.red;
            } else if ( sender.tag == 21 ) {
                multiplication.backgroundColor = UIColor.red;
            } else if ( sender.tag == 22 ) {
                minus.backgroundColor = UIColor.red;
            } else if ( sender.tag == 23 ) {
                plus.backgroundColor = UIColor.red;
            }
            
            if( operation != 0 ) {
                
                numScreen = Int(Str, radix:16)!;
                
                label.text = "";
                
                if( operation == 20) {
                    if( numScreen ==  0 ) {
                        label.text = "0X0";
                    } else {
                        label.text = "0X" + String( previousNum / numScreen, radix: 16, uppercase: true );
                    }
                } else if( operation == 21 ) {
                    label.text = "0X" + String( previousNum * numScreen, radix: 16, uppercase: true );
                } else if( operation == 22 ) {
                    label.text = "0X" + String( previousNum - numScreen, radix: 16, uppercase: true );
                } else if( operation == 23 ) {
                    label.text = "0X" + String( previousNum + numScreen, radix: 16, uppercase: true );
                }
                
                if( division.backgroundColor == UIColor.red ) {
                    division.backgroundColor = UIColor.blue;
                } else if ( multiplication.backgroundColor == UIColor.red ) {
                    multiplication.backgroundColor = UIColor.blue;
                } else if ( minus.backgroundColor == UIColor.red ) {
                    minus.backgroundColor = UIColor.blue;
                } else if ( plus.backgroundColor == UIColor.red ) {
                    plus.backgroundColor = UIColor.blue;
                }
                
            }
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

