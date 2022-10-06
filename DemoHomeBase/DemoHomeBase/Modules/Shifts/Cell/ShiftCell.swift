//
//  ShiftCell.swift
//  DemoHomeBase


class ShiftCell: UITableViewCell {
    
    //MARK: - UILabel Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblShiftTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!

    //MARK: - UIView Outlets
    @IBOutlet weak var vwShiftColor: UIView!

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    //MARK: - Cell Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(_ item: Any?) {
        guard let model = item as? [String:AnyObject] else { return }
        let strDateWithoutLastWord = model[ConstantsKeys.kStartDate]?.components(separatedBy: "-").dropLast().joined(separator: " ")
        let strDateLastWord = model[ConstantsKeys.kEndDate]?.components(separatedBy: "-").dropLast().joined(separator: " ")
        lblName.text = "\(model[ConstantsKeys.kName] as? String ?? "") (\(model[ConstantsKeys.kRole] as? String ?? ""))"
        lblDate.text = "\(strDateWithoutLastWord?.toDate()?.stringValueForDay() ?? "") \(strDateWithoutLastWord?.toDate()?.stringValueForDate() ?? "")"
        lblShiftTime.text = "\(strDateWithoutLastWord?.toDate()?.stringValueStartTime() ?? "")-\(strDateLastWord?.toDate()?.stringValueForTime() ?? "")"
        self.vwShiftColor.backgroundColor = UIColor.colorWith(name: model[ConstantsKeys.kColor] as! String) ?? .blue
    }
}

