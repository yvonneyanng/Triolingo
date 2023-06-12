import UIKit

class HeaderView: UIView {

    override init(frame: CGRect){
        super.init(frame: frame)
        self.addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("error")
    }
    
    lazy var btn: UIButton = {
        let btn = UIButton(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height))
        btn.backgroundColor = .brown
        btn.titleLabel?.textColor = UIColor.white
        btn.addTarget(self, action: #selector(onClickHeaderView), for: touchUpInside)
        return btn
    }()

    @objc func onClickHeaderView() {
        print("header view")
    }
}
