import UIKit

class DataViewController: UIViewController, UICollectionGridViewSortDelegate {
    
    var gridViewController: UICollectionGridViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridViewController = UICollectionGridViewController()
        gridViewController.setColumns(columns: ["编号","客户", "消费金额", "消费次数", "满意度"])
        gridViewController.addRow(row: ["No.01","hangge", "100", "8", "60%"])
        gridViewController.addRow(row: ["No.02","张三", "223", "16", "81%"])
        gridViewController.addRow(row: ["No.03","李四", "143", "25", "93%"])
        gridViewController.addRow(row: ["No.04","王五", "75", "2", "53%"])
        gridViewController.addRow(row: ["No.05","韩梅梅", "43", "12", "33%"])
        gridViewController.addRow(row: ["No.06","李雷", "33", "27", "45%"])
        gridViewController.addRow(row: ["No.07","王大力", "33", "22", "15%"])
        gridViewController.addRow(row: ["No.08","蝙蝠侠", "100", "8", "60%"])
        gridViewController.addRow(row: ["No.09","超人", "223", "16", "81%"])
        gridViewController.addRow(row: ["No.10","钢铁侠", "143", "25", "93%"])
        gridViewController.addRow(row: ["No.11","灭霸", "75", "2", "53%"])
        gridViewController.addRow(row: ["No.12","快银", "43", "12", "33%"])
        gridViewController.addRow(row: ["No.13","闪电侠", "33", "27", "45%"])
        gridViewController.addRow(row: ["No.14","绿箭", "33", "22", "15%"])
        gridViewController.addRow(row: ["No.15","绿巨人", "223", "16", "81%"])
        gridViewController.addRow(row: ["No.16","黑寡妇", "143", "25", "93%"])
        gridViewController.addRow(row: ["No.17","企鹅人", "75", "2", "53%"])
        gridViewController.addRow(row: ["No.18","双面人", "43", "12", "33%"])
        gridViewController.addRow(row: ["No.19","奥特曼", "33", "27", "45%"])
        gridViewController.addRow(row: ["No.20","小怪兽s", "33", "22", "15%"])
        
        gridViewController.sortDelegate = self
        view.addSubview(gridViewController.view)
    }
    
    override func viewDidLayoutSubviews() {
        gridViewController.view.frame = CGRect(x:0, y:64, width:view.frame.width,
                                               height:view.frame.height-64)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //表格排序函数
    func sort(colIndex: Int, asc: Bool, rows: [[Any]]) -> [[Any]] {
        let sortedRows = rows.sorted { (firstRow: [Any], secondRow: [Any])
            -> Bool in
            let firstRowValue = firstRow[colIndex] as! String
            let secondRowValue = secondRow[colIndex] as! String
            if colIndex == 0 || colIndex == 1 {
                //首例、姓名使用字典排序法
                if asc {
                    return firstRowValue < secondRowValue
                }
                return firstRowValue > secondRowValue
            } else if colIndex == 2 || colIndex == 3 {
                //中间两列使用数字排序
                if asc {
                    return Int(firstRowValue)! < Int(secondRowValue)!
                }
                return Int(firstRowValue)! > Int(secondRowValue)!
            }
            //最后一列数据先去掉百分号，再转成数字比较
            let firstRowValuePercent = Int(firstRowValue.substring(to:
                firstRowValue.index(before: firstRowValue.endIndex)))!
            let secondRowValuePercent = Int(secondRowValue.substring(to:
                secondRowValue.index(before: secondRowValue.endIndex)))!
            if asc {
                return firstRowValuePercent < secondRowValuePercent
            }
            return firstRowValuePercent > secondRowValuePercent
        }
        return sortedRows
    }
}
