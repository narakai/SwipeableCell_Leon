//
//  ViewController.swift
//  SwipeableCell_Leon
//
//  Created by lai leon on 2017/9/12.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit

let YHRect = UIScreen.main.bounds
let YHHeight = YHRect.size.height
let YHWidth = YHRect.size.width

class ViewController: UIViewController {

    var datas = [CellModel]()
    let tableView: UITableView = {
        let tableView = UITableView(frame: YHRect, style: .plain)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    let reuseIdentifer = String(describing: CustomCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }


    private func setupView() {
        for index in 0...20 {
            datas.append(CellModel(imageName: String(index % 3 + 1), title: "第\(index + 1)行"))
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: reuseIdentifer)
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! CustomCell
        cell.buildInterface(model: datas[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //实现该方法,并返回数据，就会开启cell的左划功能
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "删除", handler: {
            (action, index) in
            print("删除")
            let alert = UIAlertController(title: "是否删除?", message: "删除了就没有了哟！", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                tableView.reloadRows(at: [indexPath], with: .fade)
            })
            let delete = UIAlertAction(title: "确定", style: .destructive, handler: { (action) in
                self.datas.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
            alert.addAction(cancel)
            alert.addAction(delete)
            self.present(alert, animated: true, completion: nil)
        })
        delete.backgroundColor = .black

        let edit = UITableViewRowAction(style: .normal, title: "编辑", handler: {
            (action, index) in
            print("编辑")
            let alert = UIAlertController(title: "修改名称", message: "随便改！", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                tableView.reloadRows(at: [indexPath], with: .fade)
            })
            let delete = UIAlertAction(title: "确定", style: .destructive, handler: { (action) in
                self.datas[indexPath.row].title = (alert.textFields?.first?.text)!
                tableView.reloadRows(at: [indexPath], with: .fade)
            })
            alert.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "输入新的名称！"
                textField.text = self.datas[indexPath.row].title
                textField.clearButtonMode = .whileEditing
            })
            alert.addAction(cancel)
            alert.addAction(delete)
            self.present(alert, animated: true, completion: nil)
        })
        edit.backgroundColor = .blue

        let share = UITableViewRowAction(style: .normal, title: "分享") { (action, index) in
            print("分享")
            let firstItem = self.datas[indexPath.row]
//            UIActivityViewController 分享界面
            let activityVC = UIActivityViewController(activityItems: [firstItem.title], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: {
                tableView.reloadRows(at: [indexPath], with: .fade)
            })
        }
        share.backgroundColor = .orange

        return [delete, edit, share]
    }
}
