//
//  ViewController.swift
//  MailDemo
//
//  Created by zjajgyy on 2016/11/29.
//  Copyright © 2016年 zjajgyy. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var body: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        subject.delegate = self
        body.delegate = self
    }

    @IBAction func sendMail(_ sender: Any) {
        var picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        picker.setSubject(subject.text!)
        //picker.setSubject(subject.text)
        picker.setMessageBody(body.text, isHTML: true)
        
        //presentViewController(picker, animated: true, completion: nil)
        present(picker, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 1
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        //dismissViewControllerAnimated(true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
    // UITextFieldDelegate
    
    // 2
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    // UITextViewDelegate
    
    // 3
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        body.text = textView.text
        
        if text == "\n" {
            textView.resignFirstResponder()
            
            return false
        }
        
        return true
    }


}

