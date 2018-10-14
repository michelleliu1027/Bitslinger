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
        firstOp.backgroundColor = UIColor(hexString: "#abc7e4");
        secondOp.backgroundColor = UIColor(hexString: "#abc7e4");
        thirdOp.backgroundColor = UIColor(hexString: "#abc7e4");
        fourthOp.backgroundColor = UIColor(hexString: "#abc7e4");
    }
    
    // Function to clear
    @IBAction func clear(_ sender: Any ){
        label.text = DEFSTR;
        clear.setTitle(AC, for: .normal)
        
        startNew = true;
        previousNum = 0;
        operation = 0;
        cleared = true;
        
        firstOp.backgroundColor = UIColor(hexString: "#abc7e4");
        secondOp.backgroundColor = UIColor(hexString: "#abc7e4");
        thirdOp.backgroundColor = UIColor(hexString: "#abc7e4");
        fourthOp.backgroundColor = UIColor(hexString: "#abc7e4");
    }
    
    @IBAction func operations(_ sender: UIButton) {
        
        var str = label.text!;
        str.removeFirst();
        str.removeFirst();
        
        if (operation == 0){
            previousNum = Int( str, radix:HEX )!;
        }
        else{
            numScreen = Int( str, radix:HEX )!;
        }
        
        // Display result
        if( sender.tag >= 20 && sender.tag <= 24) {
            if( bitwise == false ) {
            switch operation {
            case 20:
                if( numScreen ==  0 ) {
                    label.text = DEFSTR;
                } else {
                    label.text = PREFIX + String( previousNum / numScreen, radix: HEX, uppercase: true );
                }
                firstOp.backgroundColor = UIColor(hexString: "#abc7e4");
            case 21:
                 label.text = PREFIX + String( previousNum * numScreen, radix: HEX, uppercase: true );
                 secondOp.backgroundColor = UIColor(hexString: "#abc7e4");
            case 22:
                 label.text = PREFIX + String( previousNum - numScreen, radix: HEX, uppercase: true );
                 thirdOp.backgroundColor = UIColor(hexString: "#abc7e4");
            case 23:
                 label.text = PREFIX + String( previousNum + numScreen, radix: HEX, uppercase: true );
                 fourthOp.backgroundColor = UIColor(hexString: "#abc7e4");
            case 24:
                    operation = 0;
            default:
                cleared = false;
                }
            }
            else if( bitwise == true ) {
                switch operation {
                case 20:
                    label.text = PREFIX + String( previousNum & numScreen, radix: HEX, uppercase: true );
                    firstOp.backgroundColor = UIColor(hexString: "#abc7e4");
                case 21:
                    label.text = PREFIX + String( previousNum | numScreen, radix: HEX, uppercase: true );
                    secondOp.backgroundColor = UIColor(hexString: "#abc7e4");
                case 22:
                    label.text = PREFIX + String( ~(previousNum | numScreen ), radix: HEX, uppercase: true );
                    thirdOp.backgroundColor = UIColor(hexString: "#abc7e4");
                case 23:
                    label.text = PREFIX + String( previousNum ^ numScreen, radix: HEX, uppercase: true );
                    fourthOp.backgroundColor = UIColor(hexString: "#abc7e4");
                case 24:
                    operation = 0;
                default:
                    cleared = false;
                
            }
        }
        }
        
        startNew = true;
        
        // Check if operation is =
        if( sender.tag == 24) {
            operation = 0;
        } else if( sender.tag >= 20 && sender.tag <= 23){
            operation = sender.tag;
            switch operation {
            case 20:
                firstOp.backgroundColor = UIColor(hexString: "#6dace4");
            case 21:
                 secondOp.backgroundColor = UIColor(hexString: "#6dace4");
            case 22:
                thirdOp.backgroundColor = UIColor(hexString: "#6dace4");
            case 23:
                fourthOp.backgroundColor = UIColor(hexString: "#6dace4");
            default:
                cleared = false;
                
            }
        }
        str = label.text!;
        str.removeFirst();
        str.removeFirst();
        previousNum = Int(str, radix:HEX)!;
        
        cleared = false;
    }
    
    @IBAction func numbers(_ sender: UIButton) {
         label.adjustsFontSizeToFitWidth = true;
        // Check if number is maximum
        if( label.text!.count == 18 ) {
            // Play negative sound
            return;
        }
        
        if( cleared ){
            var str = label.text!;
            str.removeFirst();
            str.removeFirst();
            previousNum = Int( str, radix:HEX )!;
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
        if( Int(str, radix:HEX) == 0) {
            label.text = DEFSTR;
            startNew = true;
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

