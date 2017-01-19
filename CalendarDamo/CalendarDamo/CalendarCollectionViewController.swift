//
//  CalendarCollectionViewController.swift
//  CalendarDamo
//
//  Created by zjajgyy on 2016/11/27.
//  Copyright © 2016年 zjajgyy. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"
//let KScreenHeight = UIScreen.main.bounds.size.height
//let KScreenWidth = UIScreen.main.bounds.size.width
//let KHeightRation = KScreenHeight / 670.0
//let KWidthRation = KScreenWidth / 375.0


class CalendarCollectionViewController: UICollectionViewController {
    
    var lastMonthButton: UIButton! //上个月Button
    var calendarLabel: UILabel! //当天Label
    var nextMonthButton: UIButton! //下个月Button
    var collection: UICollectionView! //显示日历所有日期
    
    var dataArray = NSArray()
    let calendarIdentifier = "Cell"
    let dataIdentifier = "DataCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        dataArray = ["日", "一", "二", "三", "四", "五", "六"]
        addAllViews()

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: calendarIdentifier)
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: dataIdentifier)
        
        
        
        self.collection.register(UINib(nibName: "CalendarCell", bundle: nil), forCellWithReuseIdentifier: calendarIdentifier)
        self.collection.register(UINib(nibName: "DataCell", bundle: nil), forCellWithReuseIdentifier: dataIdentifier)

        // Do any additional setup after loading the view.
    }
    
    
    func addAllViews() {
        lastMonthButton = UIButton(type: UIButtonType.system)
        lastMonthButton.frame = CGRect(x: 20, y: 100, width: 80, height: 40)
        lastMonthButton.setTitle("<", for: UIControlState.normal)
        lastMonthButton.addTarget(self, action: "lastMonthAction:", for: UIControlEvents.touchUpInside)
        self.view.addSubview(lastMonthButton)
        
        
        calendarLabel = UILabel(frame: CGRect(x: lastMonthButton.frame.maxX+20, y: lastMonthButton.frame.minY-17, width: KScreenWidth / 3, height: 50))
        calendarLabel.textAlignment = NSTextAlignment.center
        calendarLabel.textColor = UIColor.white
        calendarLabel.backgroundColor = UIColor(red: 32/255.0, green:
            158/255.0, blue: 133/255.0, alpha: 1.0)
        calendarLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(calendarLabel)
        
        
        nextMonthButton = UIButton(type: UIButtonType.system)
        nextMonthButton.frame = CGRect(x: calendarLabel.frame.maxX+20, y: 100, width: 80, height: 40)
        nextMonthButton.setTitle("<", for: UIControlState.normal)
        nextMonthButton.addTarget(self, action: "nextMonthAction:", for: UIControlEvents.touchUpInside)
        self.view.addSubview(nextMonthButton)
        
        
        let itemWidth = KScreenWidth / 7 - 5
        let itemHeight = itemWidth
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        
        collection = UICollectionView(frame: CGRect(x: 0, y: calendarLabel.frame.maxY, width: KScreenWidth, height: 400), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.dataSource = self
        collection.delegate = self
        self.view.addSubview(collection)
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        if section == 0 {
            return dataArray.count
        } else {
            return 42
        }
        //return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: calendarIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
