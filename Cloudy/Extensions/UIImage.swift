//
//  UIImage.swift
//  Cloudy
//
//  Created by Piercing on 11/7/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import UIKit

// Definimos un método/función de clase
extension UIImage {
    
    class func imageForIcon(withName name: String) -> UIImage? {
        
        /* Simplificamos la implementación actual de "WeatherViewController"
         Usamos el valor del argumento "name",  para instanciar un "UIImage"
         en la mayoría de los "case" del swicth, y en el "default" */
        switch name {
        case "clear-day", "clear-night", "rain", "snow", "sleet":
            return UIImage(named: name)
        case "wind", "cloudy", "partly-cloudy-day", "partly-cloudy-night":
            return UIImage(named: "cloudy")
        default: return UIImage(named: "clear-day")
        }
    }
    
    /* NOTA: con este método es muy fácil rellenar el icono de la image view
     Creamos una propiedad computada de tipo UIImage? en el VM y la llamamos
     "image". En el cuerpo de la propiedad computada, invocamos el método de
     la clase que hemos creado aquí,pasándole el valor de la propiedad "icon"
     del modelo. Vamos entonces a VM "DayViewViewModel.swift */
}
