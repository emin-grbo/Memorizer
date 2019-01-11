//
//  MemoryViewController.swift
//  Memorizer
//
//  Created by Emin Roblack on 1/9/19.
//  Copyright © 2019 emiN Roblack. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!
  var item: MemoryItem!
  var blankCounter = 0
  
  let visibleText: [NSAttributedString.Key: Any] = [
    .font: UIFont(name: "Georgia", size: 28)!,
    .foregroundColor: UIColor.black
  ]
  
  let invisibleText: [NSAttributedString.Key: Any] = [
    .font: UIFont(name: "Georgia", size: 28)!,
    .foregroundColor: UIColor.clear,
    .strikethroughStyle: 1,
    .strikethroughColor: UIColor.black
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(item != nil, "You must provide a memory item before showing the VC")
    textView.attributedText = showText(for: item)
    
    let tapReckognizer = UITapGestureRecognizer(target: self, action: #selector(wordsTapped))
    textView.addGestureRecognizer(tapReckognizer)
  }
  
  
  
  //MARK:- Formatting the text to be removed ------------------------------------------------
  func showText(for memoryItem: MemoryItem) -> NSAttributedString {
    let words = memoryItem.text.components(separatedBy: " ")
    let output = NSMutableAttributedString()
    
    let space = NSAttributedString(string: " ", attributes: visibleText)
    
    for (index, word) in words.enumerated() {
      if index < blankCounter {
        let attributedWord = NSAttributedString(string: word, attributes: visibleText)
        output.append(attributedWord)
      } else {
        // Removing punctuation
        var strippedWord = word
        var punctuation: String?
        
        if ".,".contains(word.last!) {
          punctuation = String(strippedWord.removeLast())
        }
        
        let attributedWord = NSAttributedString(string: strippedWord, attributes: invisibleText)
        output.append(attributedWord)
        
        if let symbol = punctuation {
          let attributedPunctuacion = NSAttributedString(string: symbol, attributes: visibleText)
          output.append(attributedPunctuacion)
        }
        
      }
      output.append(space)
    }
    return output
  }
  //------------------------------------------------------------------------

  
  
  //MARK:- Function that gets triggered on a tap ----------------------------
  @objc func wordsTapped() {
    blankCounter += 1
    textView.attributedText = showText(for: item)
  }
  //------------------------------------------------------------------------


}
