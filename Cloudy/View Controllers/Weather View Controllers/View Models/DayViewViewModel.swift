//
//  DayViewViewModel.swift
//  Cloudy
//
//  Created by Piercing on 10/7/18.
//  Copyright © 2018 devspain. All rights reserved.
//

import UIKit

// NOTA 1: "DayViewViewModel" --> es una struct, un "value type" (tipo de valor).
// Recordar que el "VM" debe mantener una referencia al modelo, lo que significa
// que tenemos que crear una propiedad para ello.

struct DayViewViewModel {
    
    // MARK: - Properties
    
    let weatherData: WeatherData
    
    // MARK: -
    private let dateFormatter = DateFormatter()
    private let timeFormatter = DateFormatter()
    
    // NOTA 2:el siguiente paso es mover el código ubicado en el método
    // "updateWeatherDataContainer(withWeatherData:)"  de la clase -->
    // -->"DayViewController" hasta aquí, el VM, ya que lo necesitamos
    // para centrarnos en los valores que son usados para poblar la UI. ===>>> ¡¡¡PENDIENTE VER SI HE HACE!!!
    
    
    // NOTA 3: vamos a empezar con la etiqueta "date", la cual espera
    // una fecha con formato de tipo Sting. Es responsabilidad del VM
    // pedir al modelo el valor de la propiedad  "time" y transformar
    // ese valor al formato que la etiqueta "date" espera.
    
    // Empezaremos con una propiedad computada en el VM, aquí. Inicializamos
    // un "DateFormatter" para convertir la fecha en un String con formato y
    // establecer las propiedades "dateFormatter".
    
    var date: String {
        
        // Configure Date Formatter
        dateFormatter.dateFormat = "EEE, MMMM d"
        
        return dateFormatter.string(from: weatherData.time)
    }
    
    // NOTA 4: La etiqueta "time" se crea como la anterior, "date".
    
    // Sin embargo hay una  complicación, el formato  del tiempo depende
    // de la configuración del usuario en la aplicación. Para resolverlo
    // vamos hasta la carpeta "Extensions" --> "UserDefaults" y añadimos
    // una propiedad calculada timeFormat dentro de la enum TimeNotation
    // en la parte de arriba, que nos devuelve el formato fecha correcto
    // en función de las propiedades del usuario.
    
    // Una vez hecha la propiedad computada en -->"userDefaults" podemos
    // actualizar la propiedad "time".
    
    var time: String {
        
        // Configure Date Formatter
        dateFormatter.dateFormat = UserDefaults.timeNotation().timeFormat
        
        return dateFormatter.string(from: weatherData.time)
    }
    
    // Etiqueta Description. Definimos una propiedad computada, ->"summary" de
    // tipo String, y devolvemos el valor de la propiedad "summary" del modelo.
    
    var summary:String {
        return weatherData.summary
    }
    
    // Etiqueta Temperature. Ésta es un poco más complicada
    // dado que tenemos que tener en cuenta las user prefer.
    // Creamos una propiedad computada en la que almacenamos
    // la temperatura, en una constante llamada "temperature".
    
    var temperature:String {
        let temperature = weatherData.temperature
        
        /* Buscamos en las preferencias de usuario y damos formato
         al valor almacenado en la constante" temperature". Notar
         que necesitamos convertir la temperatura si en user pref
         se ha establecido ésta en grados Celsius. */
        
        switch UserDefaults.temperatureNotation() {/* método estático */
        case .fahrenheit:
            return String(format: "%.1f ºF", temperature)
        case .celsius:
            return String(format: "%.1f ºC", temperature.toCelcius())
        }
    }
    
    /* Wind Speed Label. Preguntamos al modelo por dicho valor
     y le damos formato basado de nuevo, en la prefer. de user */
    
    var windSpeed: String {
        let windSpeed = weatherData.windSpeed
        
        switch UserDefaults.unitsNotation() { /* método estático */
        case .imperial:
            return String(format: "%.f MPH", windSpeed)
        case .metric:
            return String(format: "%.f KPH", windSpeed.toKPH())
        }
    }
    
    /* NOTA 5: Para el Icon Image View, necesitamos una imagen
     Podríamos poner esta lógica en el view model, sin embargo
     necesitamos la misma lógica más tarde en el VModel del VC
     de la semana (week), por tanto, mejor crear una extensión
     para UIImage en el que pondremos esa lógica. Creamos pues,
     un nuevo archivo en la carpeta "Extensions" con el nombre
     "UIImage.swift". Una vez creada la extensión creamos la
     propiedad computada para tal caso */
    
    var image: UIImage? {
        return UIImage.imageForIcon(withName: weatherData.icon)
    }
    
    /* NOTA 6: IMPORTANTE -->  Este código huele mal. Cada vez que se importa UIKit en un "VM", una alarma
     debe encenderse. El modelo de vista no debería necesitar saber nada de puntos de vista,de la interfaz
     usuario. En este ejemplo, sin embargo, no tenemos otra opción. Dado que queremos devolver una UIImage,
     tenemos que importar --->"UIKit". Si no te gusta esto, también puedes devolver el nombre de la iamgen
     y que el controlador de vista sea el encargado de crear el UIImage, por ejemplo. Eso depende de ti */
    
}
















