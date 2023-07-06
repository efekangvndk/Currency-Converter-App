//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Efekan Güvendik on 5.07.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var rusLabel: UILabel!
    @IBOutlet weak var eadLabel: UILabel!
    
    
    //---- Images----
    @IBOutlet weak var euroImage: UIImageView!
    @IBOutlet weak var cusdImage: UIImageView!
    @IBOutlet weak var usdImage: UIImageView!
    @IBOutlet weak var tlImage: UIImageView!
    @IBOutlet weak var rubleImage: UIImageView!
    @IBOutlet weak var poundImage: UIImageView!
    @IBOutlet weak var cyen: UIImageView!
    @IBOutlet weak var yenImage: UIImageView!
    @IBOutlet weak var eadImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        /// 1) Request & Session : kaynak almak için ayarladığımız URL den veri almak.
        /// 2)  Respons & Data : dataya almak
        /// 3) Parsing & JSON Serialitons : datayı işlemek
       
        
        // Stage 1-----
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=0242a035a23b54b3856029569b8cefe5") //URL string
        
        let session = URLSession.shared
        
        //closure
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil{
                let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present( alert, animated: true)
                
                ///yukarıdaki işlemler 1-dataTask : işlem hatamı verdi yada bu işlem ne işe yarar onu bize söyler.
                ///2-alert oluşturma ve sunma.
        
        // Stage2-----
            }else {
                if data != nil{
                    do{
                        
                   
                   let jsonResponse = try JSONSerialization.jsonObject(with: data! ,options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String , Any>
                    //yukarıda JSON'dan gelen verileri işlemek için gerekli işlemi yapıyoruz.
                        
                        //Arka planda işlem yapmak için dispacthQueue yapmamız lazım.
                        DispatchQueue.main.async {///Alt kısımda yaptığımız işlemde jsonResponse bir any geliyor bunu sözlük olarak yapmak için yukarıda response'yi as diyip dictionary olarak yazarız.
                            if let rates = jsonResponse["rates"] as? [String : Any]{
                               
                                if let cad = rates["CAD"] as? Double{
                                    self.cadLabel.text = "CAD : \(cad) "
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                if let jpyn = rates["JPY"] as? Double{
                                    self.jpyLabel.text = "JPY : \(jpyn)"
                                }
                                if let tr = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY : \(tr)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.chfLabel.text = "CHF : \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpLabel.text = "GBP : \(gbp)"
                                }
                                if let rus = rates["RUB"] as? Double{
                                    self.rusLabel.text = "RUB : \(rus)"
                                }
                                if let ead = rates["AED"] as? Double{
                                    self.eadLabel.text = "EAD  : \(ead)"
                                }
                            }
                        }
                        
                    }catch{
                        print("Error!!")
                    }
                }
            }
            
        }

        task.resume() //bunu task dan sora dememiz lazım ki sistem çalışsın
    }

    
}


