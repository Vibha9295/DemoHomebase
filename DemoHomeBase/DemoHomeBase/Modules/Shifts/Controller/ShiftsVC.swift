//
//  ViewController.swift
//  DemoHomeBase

class ShiftsVC: UIViewController {
    
    //MARK: - UITableView Outlet
    @IBOutlet weak var tblShifts: UITableView!
    
    //MARK: - Variable Declaration
    private lazy var shiftsVCModel = {
        ShiftsVCModel()
    }()
    
    var arrContent = [Shift]()
    var arrShiftData = [[String:AnyObject]]()
    var arrEmplyoee = [String]()
    var arrRole = [String]()
    var arrColor = [String]()
    
    
    //MARK: - ViewController Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        initViewModel()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        retrieveData()
    }
    
    //MARK: - Initialization Method
    private func initialization() {
        tblShifts.tableFooterView = UIView()
        tblShifts.register(ShiftCell.nib, forCellReuseIdentifier: CellIdentifiers.kShiftCell)
    }
    
    func initViewModel() {
        var arrResult : ShiftModel?
        arrResult = shiftsVCModel.readJSONFromFile(fileName: "Shifts", type: ShiftModel.self)
        self.arrContent = arrResult?.shifts ?? [Shift]()
        for i in arrContent{
            self.arrEmplyoee.append(i.name)
            self.arrRole.append(i.role)
            self.arrColor.append(i.color.rawValue)
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataName.kDatabaseName)
        do {
            let result = try managedContext.fetch(fetchRequest)
            print(result)
            if result.count > 0{
                print("found")
            }else{
                print("not found")
                insertUpdateData()
            }
            
        } catch {
            print("Failed")
        }
        
    }
    //MARK: - Core data Methods
    
    func insertUpdateData(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        for i in self.arrContent{
            let newNote = ShiftDetail(context: managedContext)
            newNote.setValue(i.name, forKey: ConstantsKeys.kName)
            newNote.setValue(i.role, forKey: ConstantsKeys.kRole)
            newNote.setValue(i.startDate, forKey: ConstantsKeys.kStartDate)
            newNote.setValue(i.endDate, forKey: ConstantsKeys.kEndDate)
            newNote.setValue(i.color.rawValue, forKey: ConstantsKeys.kColor)
            do {
                try managedContext.save()
            } catch _ {
            }
        }
        
    }
    
    func retrieveData() {
        arrShiftData.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataName.kDatabaseName)
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                var obj = [String:AnyObject]()
                obj[ConstantsKeys.kName] = data.value(forKey: ConstantsKeys.kName) as AnyObject
                obj[ConstantsKeys.kRole] = data.value(forKey: ConstantsKeys.kRole) as AnyObject
                obj[ConstantsKeys.kStartDate] = data.value(forKey: ConstantsKeys.kStartDate) as AnyObject
                obj[ConstantsKeys.kEndDate] = data.value(forKey: ConstantsKeys.kEndDate) as AnyObject
                obj[ConstantsKeys.kColor] = data.value(forKey: ConstantsKeys.kColor) as AnyObject
                
                arrShiftData.append(obj)
            }
            
            arrShiftData.sort { (firstItem, secondItem) -> Bool in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = DateAndTimeFormatString.strDateFormate_yyyyMMddhhmmss
                if let dateAString = firstItem[ConstantsKeys.kStartDate] as? String,
                    let dateBString = secondItem[ConstantsKeys.kStartDate] as? String,
                   let dateA = dateFormatter.date(from: dateAString.components(separatedBy: "-").dropLast().joined(separator: "-")),
                    let dateB = dateFormatter.date(from: dateBString.components(separatedBy: "-").dropLast().joined(separator: "-")){
                    return dateA.compare(dateB) == .orderedDescending
                }
                return false
            }
            tblShifts.reloadData()
            
        } catch {
            
            print("Failed")
        }
    }
    
    //MARK: - UIButton Action Method
    
    @IBAction func btnAddShiftAct(_ sender: Any) {
        let objCreateShiftVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateShiftVC") as! CreateShiftVC
        objCreateShiftVC.arrEmplyoee = Array(Set(self.arrEmplyoee))
        objCreateShiftVC.arrRole = Array(Set(self.arrRole))
        objCreateShiftVC.arrColor = Array(Set(self.arrColor))
        
        self.navigationController?.pushViewController(objCreateShiftVC, animated: true)
    }
    
}


