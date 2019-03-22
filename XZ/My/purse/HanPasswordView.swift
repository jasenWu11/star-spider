import UIKit

class HanPasswordView: UIView,UITextFieldDelegate {
    
    typealias EntryCompleteBlock = () -> Void
    var entryCompleteBlock:EntryCompleteBlock?
    var paypass:String = ""
    var roundLayerArray = [CALayer]()
    var root : MyViewController?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        createTF()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func createTF() -> Void {
        
        let w = getWidth()
        let h = w
        
        let tf = CustomTextField.init(frame: CGRect.init(x: (self.frame.size.width - 6.0 * w)/2, y: 0, width: w * 6, height: h))
        tf.delegate = self
        tf.textColor = .clear
        tf.tintColor = .clear
        tf.layer.masksToBounds = true
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.black.cgColor
        tf.backgroundColor = UIColor.white
        tf.keyboardType = .numberPad
        self.addSubview(tf)
        
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        for  i  in 0...5 {
            
            let lineLayer = CALayer()
            lineLayer.frame = CGRect.init(x:(CGFloat(i) * w), y: 0, width: 1, height: h)
            lineLayer.backgroundColor = UIColor.black.cgColor
            tf.layer.addSublayer(lineLayer)
            
            let roundLayer = CALayer()
            roundLayer.frame = CGRect.init(x:(CGFloat(i) * w) + w * 0.25 , y: h * 0.25, width: w * 0.5, height: h * 0.5)
            roundLayer.cornerRadius = h * 0.25
            roundLayer.isHidden = true
            roundLayer.backgroundColor = UIColor.black.cgColor
            tf.layer.addSublayer(roundLayer)
            
            roundLayerArray.append(roundLayer)
        }
        
    }
    
    func getWidth() -> CGFloat {
        
        let w = (self.frame.size.width * 0.8)/6
        let h = self.frame.size.height
        if w > h {
            return h
        }
        return w
        
    }
    
    @objc func textFieldDidChange(_ textField:UITextField)
    {
        for layer in roundLayerArray {
            layer.isHidden = true
        }
        for i in 0..<(textField.text?.count)!{
            let layer = roundLayerArray[i]
            layer.isHidden = false
        }
        if textField.text?.count == 6 {//输入完毕，可以进行相关的操作
            paypass = textField.text ?? ""
            print("输入为\(paypass)")
            self.entryCompleteBlock!()
        }
    }
    
    //MARK:UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let proposeLength = (textField.text?.lengthOfBytes(using: String.Encoding.utf8))! - range.length + string.lengthOfBytes(using: String.Encoding.utf8)
        if proposeLength > 6{//输入的字符个数大于6，忽略输入，可以进行相关的操作
            return false
        }else{
            return true
        }
    }
    
}

class CustomTextField: UITextField {
    //重写canPerformAction 禁止复制粘贴弹框
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
