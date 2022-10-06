//
//  ShiftsVCModel.swift
//  DemoHomeBase
//

class ShiftsVCModel {
    //MARK: - Read json file Method
    func readJSONFromFile<T: Decodable>(fileName: String, type: T.Type) -> T? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
}
// MARK: - UITableViewDataSource,UITableViewDelegate methods

extension ShiftsVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrShiftData.count
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.kShiftCell, for: indexPath) as? ShiftCell
        else { fatalError("xib does not exists") }
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        cell.configure(self.arrShiftData[indexPath.section])
        return cell
    }
    
}

