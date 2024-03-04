//
//  GlobalStrings.swift
//  StoriTest
//
//  Created by Cristian Hernandez Garcia on 01/03/24.
//

import Foundation
import UIKit

struct Constants {
    
    static var baseUrl = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page="
    static var baseImage = "https://image.tmdb.org/t/p/w440_and_h660_face"
    static var homeCell = "homeCell"
    static var empty = ""
    static var get = "GET"
    static var accept = "accept"
    static var authorization = "Authorization"
    static var appjson = "application/json"    
    static var title = "Top Rated Movies"
    static var sorry = "¡Lo sentimos!"
    static var errorData = "Los datos no pueden ser interpretados"
    static var errorInternet = "Parece que no tienes conexión a internet"
    static var readyToFun = "¡Listo para disfrutar!"
    static var successPurchase = "Tu película ha sido comprada con éxito"
    static var thanksForRate = "¡Gracias por puntuar!"
    static var ratingSent = "Tu calificación ha sido enviada"
    static var doubleArrow = "double_arrow"
    static var star = "star"
    static var buy = "Comprar"
    static var token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMzY0MzA0NzE0MDY3ZjlkMjU1ZGE0YzAzMDdjMWZlMiIsInN1YiI6IjY1ZTI1MWNmNDFhNTYxMDE2MzgzNTFlYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-Hrq2fz7N_S7iF95Gsd2cMyuaZt8PlCIJLlrcsy1fsI"
}

struct Colors {
    
    static var green900 = "#003A40"
    static var green800 = "#336166"
    static var green700 = "#66898C"
    static var green600 = "#809DA0"
    static var green500 = "#99B0B3"
    static var green400 = "#B3C4C6"
    static var green300 = "#CCD8D9"
    static var green200 = "#E6EBEC"
    static var green100 = "#F3F5F6"
    static var green0 = "#FFFFFF"
}

struct Fonts {
    
    static var montserratBold = "Montserrat-Bold"
    static var montserratItalic = "Montserrat-Italic"
    static var montserratMedium = "Montserrat-Medium"
    static var montserratRegular = "Montserrat-Regular"
}

extension CGFloat {
    static var zero: CGFloat { return 0 }
    static var one: CGFloat { return 1 }
    static var four: CGFloat { return 4 }
    static var five: CGFloat { return 5 }
    static var ten: CGFloat { return 10 }
    static var fifteen: CGFloat { return 15 }
    static var seventeen: CGFloat { return 17 }
    static var twenty: CGFloat { return 20 }
    static var thirty: CGFloat { return 30 }
    static var fifty: CGFloat { return 50 }
    static var seventy: CGFloat { return 70 }
    static var oneHundred: CGFloat { return 100 }
    static var oneHundredTwenty: CGFloat { return 120 }
    static var oneHundredThirty: CGFloat { return 130 }
    static var twoHundred: CGFloat { return 200 }
    static var twoHundredTwenty: CGFloat { return 220 }
    static var threeHundred: CGFloat { return 300 }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex.replacingOccurrences(of: "#", with: ""))
        var color: UInt64 = 0
        
        if scanner.scanHexInt64(&color) {
            self.init(red: CGFloat((color & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((color & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(color & 0x0000FF) / 255.0,
                      alpha: 1.0)
        } else {
            self.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}

extension String {
    func formatDate() -> String {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd / MM / yyyy"
        
        if let date = dateFormatterInput.date(from: self) {
            return dateFormatterOutput.string(from: date)
        } else {
            return Constants.empty
        }
    }
}

extension UIImageView {
    func setImage(fromPath imagePath: String?) {
        guard let path = imagePath, let url = URL(string: "\(Constants.baseImage)\(path)") else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
        
        dataTask.resume()
    }
}

extension UIViewController {
    func pushWithCustomTransition(to viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    func showAlert(with message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Continuar", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension Optional where Wrapped == String {
    func formatDate() -> String {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd / MM / yyyy"
        
        if let dateString = self, let date = dateFormatterInput.date(from: dateString) {
            return dateFormatterOutput.string(from: date)
        } else {
            return Constants.empty
        }
    }
}

extension String {
    static func releaseLabelText(for dateString: String?) -> String {
        return "Lanzamiento:\n" + (dateString?.formatDate() ?? "")
    }
}

extension Optional where Wrapped == Double {
    func formatRating() -> String {
        return String(format: "Calificación:\n%.1f / 10", self ?? 0.0)
    }
}

extension String {
    static func ratingLabelText(for rating: Double?) -> String {
        return rating.map { Optional($0).formatRating() } ?? ""
    }
}
