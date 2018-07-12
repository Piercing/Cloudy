//
//  WeekViewViewModel.swift
//  Cloudy
//
//  Created by Piercing on 12/7/18.
//  Copyright © 2018 DevSpain. All rights reserved.
//

import UIKit

/* NOTA: la struct --> "WeekViewViewModel" es algo diferente al VM de la de "day"
 ya que maneja una gran cantidad de datos del modelo. Una vez que refactoricemos
 la clase "WeekViewController, ya no tendremos referencias a los "weather data".
 Esto significa que el view controller de la semana no sabrá cuántas sections y
 rows de la tableView debe mostrar, ya que la info vendrá de los VM's de los VC's */

// Declaramos la struct
struct WeekViewViewModel {
    
    // MARK: - Properties
    
    // Añadimos una  propiedad sobre los datos  del tiempo que gestionará este VM.
    // Esta propiedad es del tipo -->"WeatherDayData", que almacenará en un array
    // los datos de los días que le pasemos,de ahí que sea de tipo WeatherDayData
    // y no de tipo "WeatherDayWeekData", esta  última contine los distintos días.
    let weatherData: [WeatherDayData]
    
    // MARK: -
    
    // Initialize Date Formatter
    private let dateFormatter = DateFormatter()
    private let dayFormatter  = DateFormatter()
    
    // Añadimos una propiedad computada, que devuelve el número de secciones que el VC
    // de la semana debe mostrar en la tableView que gestiona. El  VC actualmente sólo
    // muestra una sección, lo que significa que devolvemos "1".
    var numberOfSections: Int {
        return 1
    }
    
    // El VC también necesita saber el número de filas que contiene la sección, por lo
    // que añadimos otra propiedad computada, que le dice al VC el número de días que
    // este VM tiene con respecto a "weather data".
    
    // NOTA IMPORTANTE !!!: estas propiedades computadas devuelven algún dato y se
    // implementan a partir del formato ---> "var numberOfDays: Int { get }"
    var numberOfDays: Int {
        return weatherData.count
    }
    
    // NOTA 2: vamos a crear algunos métodos para indicarle al VC la info que necesita.
    // Estos métodos proporcionan al VC los datos del tiempo para un día en particular.
    // Por lo que el  VC pide a este VM los datos del tiempo para un índice específico.
    // El índice se corresponde con una "row" de la tabla. Vamos a empezar con el label
    // "WeatherDayTableViewCell".El VC le preguntará a este VM un String que representa
    // los datos meteorológicos de un día. Por lo que necesitamos un método en este  VM
    // que acepte un "index" de tipo "Int" y devuelva un valor de tipo "String".
    
    /// Función que devuelve la el día "day" con formato "EEEE"
    ///* index: row seleccionada en la table view
    func day(for index: Int) -> String {
        
        // En primer lugar tenemos que buscar el "index" que se corresponda con el índice que
        // se le pasa a "day(index:)". Creamos una instancia de "DateFormatter" y formateamos
        // el valor de la propiedad "time" del modelo.
        
        // Buscamos el día concreto que corresponde al el índice pasado.
        let weatherDayData = weatherData[index]
        
        // Configure Date Formatter
        dateFormatter.dateFormat = "EEEE"
        
        // Devolvemos la propiedad "time" del día que corresponde al índice pasado formateado.
        return dateFormatter.string(from: weatherDayData.time)
    }
    
    /// Función que devuelve la fecha "date" con formato "MMM d"
    ///* index: row seleccionada en la table view
    func date(for index: Int) -> String {
        
        // Fetch Weather Data for Day
        let weatherDayData = weatherData[index]
        
        // Este método es igual que el anterior, solo cambia el formateo: "MMM d"
        dateFormatter.dateFormat = "MMMM d"
        
        // Devolvemos la propiedad "time" del día que corresponde al índice pasado formateado.
        return dateFormatter.string(from: weatherDayData.time)
    }
    
    /* NOTA 3: Establecer la propiedad "text" de la etiqueta temperatura
     del "WeatherDayTableViewCell"es otro buen ejemplo de la elegancia y
     versatilidad de view's models. Recuerde que WeatherDayTableViewCell
     muestra la temperatura -> mínima y máxima para un día en particular.
     El view model debe proporcionar el String formateado al viewControll
     para que pueda pasarlo a "WeatherDayTableViewCell". */
    
    /// En el método --> "temperature (for:)", buscamos los datos del clima,
    /// formateamos las temper. mínimas y máximas usando un método auxiliar,
    /// format(temperature:), y devuelve el String formateado como resultado.
    ///* index: row seleccionada en la table view
    func temperature(for index: Int) -> String {
        let weatherDayData = weatherData[index]
        
        let min = format(temperature: weatherDayData.temperatureMin)
        let max = format(temperature: weatherDayData.temperatureMax)
        
        return "\(min) - \(max)"
    }
    
    /// Función helper para el formato de la temperatura.
    private func format(temperature: Double) -> String {
        
        switch UserDefaults.temperatureNotation() {
        case .fahrenheit:
            return String(format: "%.0f ºF", temperature)
        case .celsius:
            return String(format: "%.0f ºC", temperature.toCelcius())
        }
    }
    
    /// Función para la velocidad del viento.
    ///* index: row seleccionada en la table view
    func windSpeed(for index: Int) -> String {
        // Fetch Weather Data
        let weatherDayData = weatherData[index]
        let windSpeed = weatherDayData.windSpeed
        
        switch UserDefaults.unitsNotation() {
        case .imperial:
            return String(format: "%.f MPH", windSpeed)
        case .metric:
            return String(format: "%.f KPH", windSpeed.toKPH())
        }
    }
    
    /// Función para la imagen del icono
    ///* index: row seleccionada en la table view
    func image(for index: Int) -> UIImage? {
        // Fetch Weather Data
        let weatherDayData = weatherData[index]
        
        return UIImage.imageForIcon(withName: weatherDayData.icon)
    }
}
















