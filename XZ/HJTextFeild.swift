@IBDesignable class HJTextFeild: UITextField {
    
    @IBInspectable var leftImage: UIImage? {
        set {
            let leftImgView = UIImageView(image: newValue)
            leftImgView.contentMode = .ScaleAspectFit
            leftImgView.frame = CGRect(x: frame.height*0.1,
                                       y: frame.height*0.1,
                                       width: frame.height*0.8,
                                       height: frame.height*0.8)
            leftView = leftImgView
            leftViewMode = .Always
        }
        
        get {
            if let leftImgView = leftView as? UIImageView {
                return leftImgView.image
            }
            return nil
        }
    }
}
