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
    var operation = 0;
    
    var bitwise = false;
    var startNew = true;
    var cleared = true;
    
    // Calculator Display
    @IBOutlet weak var label: UILabel!
    
    // AC/C button
    @IBOutlet weak var clear: UIButton!
    
    @IBOutlet weak var basic: UIButton!
    @IBOutlet weak var bit: UIButton!
    
    // Four operations
    @IBOutlet weak var firstOp: UIButton!
    @IBOutlet weak var secondOp: UIButton!
    @IBOutlet weak var thirdOp: UIButton!
    @IBOutlet weak var fourthOp: UIButton!
    
    @IBAction func changeMode(_ sender: UIButton) {
        if( sender.tag == BITWISE ) {
            bitwise = true;
            
            basic.backgroundColor = UIColor(hexString: "#bbdafa")
            bit.backgroundColor = UIColor(hexString: "#abc7d4")
            
            firstOp.setTitle(AND, for: .normal);
            secondOp.setTitle(OR, for: .normal);
            thirdOp.setTitle(NOR, for: .normal);
            fourthOp.setTitle(XOR, for: .normal);
        } else if( sender.tag == BASIC ) {
            bitwise = false;
            
            bit.backgroundColor = UIColor(hexString: "#bbdafa")
            basic.backgroundColor = UIColor(hexString: "#abc7d4")
            
            firstOp.setTitle(DIVIDE, for: .normal);
            secondOp.setTitle(MULTIPLY, for: .normal);
            thirdOp.setTitle(MINUS, for: .normal);
            fourthOp.setTitle(PLUS, for: .normal);
        }
    }
    
    // Function to clear
    @IBAction func clear(_ sender: Any ){
        label.text = DEFSTR;
        clear.setTitle(AC, for: .normal)
        
        startNew = true;
        previousNum = 0;
        operation = 0;
        cleared = true;
    }
    
    @IBAction func operations(_ sender: UIButton) {
        
        var str = label.text!;
        str.removeFirst();
        str.removeFirst();
        
        if (operation == 0){
            previousNum = Int( str, radix:16 )!;
        }
        else{
            numScreen = Int( str, radix:16 )!;
        }
        
        if( sender.tag == 24) {
            
            if( operation == 20) {
                if( numScreen ==  0 ) {
                    label.text = "0X0";
                } else {
                    label.text = PREFIX + String( previousNum / numScreen, radix: 16, uppercase: true );
                }
            } else if( operation == 21 ) {
                label.text = PREFIX + String( previousNum * numScreen, radix: 16, uppercase: true );
            } else if( operation == 22 ) {
                label.text = PREFIX + String( previousNum - numScreen, radix: 16, uppercase: true );
            } else if( operation == 23 ) {
                label.text = PREFIX + String( previousNum + numScreen, radix: 16, uppercase: true );
            }
            
            if( firstOp.backgroundColor == UIColor.red ) {
                firstOp.backgroundColor = UIColor.blue;
            } else if ( secondOp.backgroundColor == UIColor.red ) {
                secondOp.backgroundColor = UIColor.blue;
            } else if ( thirdOp.backgroundColor == UIColor.red ) {
                thirdOp.backgroundColor = UIColor.blue;
            } else if ( fourthOp.backgroundColor == UIColor.red ) {
                fourthOp.backgroundColor = UIColor.blue;
            }
            startNew = true;
            operation = 0;
        } else if( sender.tag >= 20 && sender.tag <= 23){
            if( operation == 20) {
                if( numScreen ==  0 ) {
                    label.text = "0X0";
                } else {
                    label.text = PREFIX + String( previousNum / numScreen, radix: 16, uppercase: true );
                }
            } else if( operation == 21 ) {
                label.text = PREFIX + String( previousNum * numScreen, radix: 16, uppercase: true );
            } else if( operation == 22 ) {
                label.text = PREFIX + String( previousNum - numScreen, radix: 16, uppercase: true );
            } else if( operation == 23 ) {
                label.text = PREFIX + String( previousNum + numScreen, radix: 16, uppercase: true );
            }
            if( firstOp.backgroundColor == UIColor.red ) {
                firstOp.backgroundColor = UIColor.blue;
            } else if ( secondOp.backgroundColor == UIColor.red ) {
                secondOp.backgroundColor = UIColor.blue;
            } else if ( thirdOp.backgroundColor == UIColor.red ) {
                thirdOp.backgroundColor = UIColor.blue;
            } else if ( fourthOp.backgroundColor == UIColor.red ) {
                fourthOp.backgroundColor = UIColor.blue;
            }
            if( sender.tag == 20 ) {
                firstOp.backgroundColor = UIColor.red;
            } else if ( sender.tag == 21 ) {
                secondOp.backgroundColor = UIColor.red;
            } else if ( sender.tag == 22 ) {
                thirdOp.backgroundColor = UIColor.red;
            } else if ( sender.tag == 23 ) {
                fourthOp.backgroundColor = UIColor.red;
            }
            startNew = true;
            operation = sender.tag;
        }
        str = label.text!;
        str.removeFirst();
        str.removeFirst();
        previousNum = Int(str, radix:16)!;
        cleared = false;
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        
        // Check if number is maximum
        if( label.text!.count == 18 ) {
            // Play negative sound
            return
        }
        
        if( cleared ){
            var str = label.text!;
            str.removeFirst();
            str.removeFirst();
            previousNum = Int( str, radix:16 )!;
        }

        // Check if new number will be entered
        if( startNew == true ) {
            label.text = PREFIX + sender.title(for: .normal)!;
    
            clear.setTitle(C, for: .normal);
            startNew = false;
        } else {
            label.text = label.text! + sender.title(for: .normal)!;
        }
        
        var str = label.text!;
        str.removeFirst();
        str.removeFirst();
        
        // Check if number is 0
        if( Int(str, radix:16) == 0) {
            label.text = DEFSTR;
            startNew = true;
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

