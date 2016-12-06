//
//  CouponAddViewController.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 05/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import UIKit

class CouponAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    var couponToEdit: Coupon?
    
    @IBOutlet weak var logo: UIImageView!
    
    //데이터베이스에서 삭제
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        if couponToEdit != nil {
            context.delete(couponToEdit!)
            ad.saveContext()
            
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
   
    //로고를 선택하면 데이터베이스의 로고를 불러오기 위한 버튼액션(현재는 사진첩으로 가게해놓음)
    @IBAction func picturePickerPressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            logo.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var product: UITextField!
    
    @IBOutlet weak var barcode: UITextField!
    
    //barcode 실시간으로 보여주기 위한 액션
    @IBAction func createdBarcodeImg(_ sender: UITextField) {

        let generateBarcode = GenerateBarcode()
        barcodeImg.image = generateBarcode.fromString(string: barcode.text!)
    }

    @IBOutlet weak var barcodeImg: UIImageView!
    
    @IBOutlet weak var expiredDate: UITextField!
    
    //유효기간 텍스트필드 클릭시 데이트 픽커를 이용한 날짜 선택하기 액션
    @IBAction func expiredDateFieldBegin(_ sender: UITextField) {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
        
        datePicker.datePickerMode = .date
        sender.inputView = datePicker
        datePicker.addTarget(self, action: #selector(CouponAddViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    //타겟시 데이트피커의 값을 텍스트 필드에 넣어주기 위한 펑션
    func datePickerValueChanged(sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        expiredDate.text = dateFormatter.string(from: sender.date)
        
    }

    //카테고리 필드 클릭시 여태까지 만들어 놓았던 카테고리를 픽커뷰로 보여주기 위한 액션
    @IBAction func categoryFieldPressed(_ sender: UITextField) {
        
    }
    
    //모든 값을 코어데이터 테이블로 저장하기 위한 액션
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        var coupon: Coupon!
        let brand = Brand(context: context)
        
        brand.logo = logo.image
        
        //itemToEdit이 nil일 경우 새로운 객체를 전달해서 저장 아닐경우 그 itemToEdit으로 저장
        if couponToEdit == nil {
            coupon = Coupon(context: context)
        } else {
            coupon = couponToEdit
        }
        
        coupon.toBrand?.logo = brand.logo
        
        if let title = product.text {
            coupon.title = title
        }
        
        if let barcode = barcode.text {
            
            coupon.barcode = barcode
            
        }
        
        if let barcodeImg = barcodeImg.image {
            coupon.barcodeImg = barcodeImg
        }
        
        if let expiredDate = expiredDate.text{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date = formatter.date(from: expiredDate)
            if date != nil {
                coupon.expireDate = date as NSDate?
            }
        }
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    //Coupon 데이타를 로드하는 펑션
    func loadCouponData() {
        
        if let coupon = couponToEdit {
            product.text = coupon.title
            barcode.text = coupon.barcode
            barcodeImg.image = coupon.barcodeImg as! UIImage?
            expiredDate.text = displayTheDate(theDate: coupon.expireDate as! Date)
            logo.image = coupon.toBrand?.logo as? UIImage
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if couponToEdit != nil {
            loadCouponData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
