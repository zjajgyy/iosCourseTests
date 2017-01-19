//
//  ViewController.swift
//  CalendarDamo
//
//  Created by zjajgyy on 2016/11/27.
//  Copyright © 2016年 zjajgyy. All rights reserved.
//

import UIKit

let KScreenHeight = UIScreen.main.bounds.size.height
let KScreenWidth = UIScreen.main.bounds.size.width
let KHeightRation = KScreenHeight / 670.0
let KWidthRation = KScreenWidth / 375.0

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    //var lastMonthButton: UIButton! //上个月Button
    //var calendarLabel: UILabel! //当天Label
    //var nextMonthButton: UIButton! //下个月Button
    
    @IBOutlet weak var lastMonthButton: UIButton!
    @IBOutlet weak var calendarLabel: UILabel!
    @IBOutlet weak var nextMonthButton: UIButton!
    @IBOutlet weak var collection: UICollectionView!
    
    
    var detailArray = [1,5,9]
    var detailArrayIndex = Array(repeating: 0, count: 42)
    var dateArray = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    let calendarIdentifier = "CalendarCell"
    let dateIdentifier = "DateCell"
    var date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addAllViews()
        for i in detailArray {
            detailArrayIndex[i+self.firstWeekDayInThisMonth(date: self.date)-1] = 1
        }
    }
    
    func addAllViews() {
        lastMonthButton.frame = CGRect(x: 20, y: 100, width: 80, height: 50)
        lastMonthButton.setTitle("<", for: UIControlState.normal)
        lastMonthButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        lastMonthButton.setTitleColor(UIColor(red: 32/255.0, green:
            158/255.0, blue: 133/255.0, alpha: 1.0), for: UIControlState.normal)
        self.view.addSubview(lastMonthButton)
        
        
        calendarLabel.frame = CGRect(x: lastMonthButton.frame.maxX+20, y: lastMonthButton.frame.minY, width: KScreenWidth / 3, height: 50)
        calendarLabel.textAlignment = NSTextAlignment.center
    
        calendarLabel.backgroundColor = UIColor.white
        calendarLabel.textColor = UIColor(red: 32/255.0, green:
            158/255.0, blue: 133/255.0, alpha: 1.0)
        calendarLabel.font = UIFont.systemFont(ofSize: 25)
        calendarLabel.text = String(format: "%li-%.2ld", self.year(date: self.date), self.month(date: self.date))
        self.view.addSubview(calendarLabel)
        
        nextMonthButton.frame = CGRect(x: calendarLabel.frame.maxX+20, y: 100, width: 80, height: 50)
        nextMonthButton.setTitle(">", for: UIControlState.normal)
        nextMonthButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        nextMonthButton.setTitleColor(UIColor(red: 32/255.0, green:
            158/255.0, blue: 133/255.0, alpha: 1.0), for: UIControlState.normal)
        self.view.addSubview(nextMonthButton)
        
        
        let itemWidth = KScreenWidth / 7 - 5
        let itemHeight = itemWidth
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        
        collection.dataSource = self
        collection.delegate = self
        collection.frame = CGRect(x: 0, y: calendarLabel.frame.maxY+20, width: KScreenWidth, height: 400)
        collection.collectionViewLayout = layout
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        if section == 0 {
            return dateArray.count
        } else {
            return 42
        }
    }
    
    @IBAction func lastMonthAction(_ sender: Any) {
        UIView.transition(with: self.collection, duration: 0.5, options: UIViewAnimationOptions.showHideTransitionViews, animations: {() -> Void in
            self.date = self.lastMonth(date: self.date)
            self.calendarLabel.text = String(format: "%li-%.2ld", self.year(date: self.date), self.month(date: self.date))
            
        }, completion: nil)
        self.collection.reloadData()
    }
    
    @IBAction func nextMonthAction(_ sender: Any) {
        
        UIView.transition(with: self.collection, duration: 0.5, options: UIViewAnimationOptions.showHideTransitionViews, animations: {() -> Void in
            self.date = self.nextMonth(date: self.date)
            self.calendarLabel.text = String(format: "%li-%.2ld", self.year(date: self.date), self.month(date: self.date))
        }, completion: nil)
        self.collection.reloadData()
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Configure the cell
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateIdentifier, for: indexPath) as! DateCollectionViewCell
            cell.dateLabel.font = UIFont.systemFont(ofSize: 20)
            cell.dateLabel.text = dateArray[indexPath.row]
            cell.dateLabel.textAlignment = NSTextAlignment.center
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: calendarIdentifier, for: indexPath) as! CalendarCollectionViewCell
            cell.timeLabel.font = UIFont.systemFont(ofSize: 20)
            cell.timeLabel.textAlignment = NSTextAlignment.center
            let dayInThisMonth = self.totalDayInMonth(date: date)
            let firstWeekday = self.firstWeekDayInThisMonth(date: date)
            
            var day: Int = 0
            let i = indexPath.row
            
            cell.timeLabel.text = ""
            cell.backgroundColor = UIColor.white
            cell.timeLabel.textColor = UIColor.black
            
            if i < firstWeekday {
                cell.backgroundColor = UIColor.white
            } else if i > firstWeekday+dayInThisMonth-1 {
                cell.backgroundColor = UIColor.white
            } else if i > self.day(date: date)+firstWeekday-1 {
                day = i - firstWeekday + 1
                cell.timeLabel.text = String(day)
                cell.timeLabel.textColor = UIColor.gray
            } else {
                day = i - firstWeekday + 1
                cell.timeLabel.text = String(day)
            }
            return cell
        }
        
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if detailArrayIndex[indexPath.row] == 1 {
            //self.performSegue(withIdentifier: "ShowCheckInDailyDetail", sender: nil)
        }
        
    }
   
/*
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        return collectionView.dequeueReusableSupplementaryView(ofKind: " ", withReuseIdentifier: calendarIdentifier, for: indexPath)
    }
    
  
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
*/
    
    //date 为当前时间， 根据date计算时间
    //计算当前为一个月的第几天
    func day(date: Date) -> Int {
        let components = Calendar.current.dateComponents(Set<Calendar.Component>([.year, .month, .day]), from: date)
        return components.day!
    }
    
    //计算当前为一年的几月
    func month(date: Date) -> Int {
        let components = Calendar.current.dateComponents(Set<Calendar.Component>([.year, .month, .day]), from: date)
        return components.month!
    }
    
    //计算当前的年份
    func year(date: Date) -> Int {
        let components = Calendar.current.dateComponents(Set<Calendar.Component>([.year, .month, .day]), from: date)
        return components.year!
    }
    
    //计算当月1号是星期几
    func firstWeekDayInThisMonth(date: Date) -> Int {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        var components = calendar.dateComponents(Set<Calendar.Component>([.year, .month, .day]), from: date)
        components.day = 1
        let firstDayOfMonth = calendar.date(from: components)
        let firstWeekDay = calendar.ordinality(of: .weekday, in: .weekOfMonth, for: firstDayOfMonth!)
        return firstWeekDay! - 1
    }
    
    //计算当前月份的天数
    func totalDayInMonth(date: Date) -> Int {
        //let totalDayInMonth: NSRange = NSCalendar.current.range(of: .day, in: .month, for: date as Date)
        let totalDaysInMonth = Calendar.current.range(of: .day, in: .month, for: date)
        return (totalDaysInMonth?.count)!
        
    }
    
    
    //计算上一个月
    func lastMonth(date: Date) -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = -1
        let newDate = Calendar.current.date(byAdding: dateComponents, to: date)
        return newDate!
    }
    
    //计算下一个月
    func nextMonth(date: Date) -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = 1
        let newDate = Calendar.current.date(byAdding: dateComponents, to: date)
        return newDate!
    }
    
}

