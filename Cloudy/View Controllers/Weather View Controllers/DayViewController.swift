//
//  DayViewController.swift
//  Cloudy
//
//  Created by Bart Jacobs on 01/10/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

protocol DayViewControllerDelegate {
    func controllerDidTapSettingsButton(controller: DayViewController)
    func controllerDidTapLocationButton(controller: DayViewController)
}

class DayViewController: WeatherViewController {

    // MARK: - Properties

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    // MARK: - Delegate

    var delegate: DayViewControllerDelegate?

    // MARK: - Computer variables

    var now: WeatherData? {
        didSet {
            updateView()
        }
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Public Interface

    override func reloadData() {
        updateView()
    }

    // MARK: - View Methods

    private func setupView() {

    }

    private func updateView() {
        activityIndicatorView.stopAnimating()

        if let now = now {
            updateWeatherDataContainer(withWeatherData: now)

        } else {
            messageLabel.isHidden = false
            messageLabel.text = "Cloudy was unable to fetch weather data."

        }
    }

    // MARK: - Update data

    // Este es un patrón común del patrón "MVC". Los valores brutos de los datos del
    // modelo se transforman y son formateados antes de que sean mostrado al usuario.
    
    // ¿Debe el "view controller" encargarse de esta tarea?. Tal vez sí, tal vez no!.
    // ¿Pero existe una solución más elegante?. Por supuesto que existe otra solución.
    
    // Si adoptamos el patrón "MVVM", el view controller ya no será responsable de la
    // manipulación  de datos. Por otro lado, el "view controller" ya no va a conocer
    // y tener acceso directo al modelo de datos. Éste recibirá un "view model" desde
    // el "root view controller" y utlizará el "view model" (VM) para poblar su vista.
    private func updateWeatherDataContainer(withWeatherData weatherData: WeatherData) { // <-- Acceso al modelo "WeatherData"!!
        weatherDataContainer.isHidden = false
        
        var windSpeed = weatherData.windSpeed
        var temperature = weatherData.temperature
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMMM d"
        dateLabel.text = dateFormatter.string(from: weatherData.time)
        
        let timeFormatter = DateFormatter()
        
        if UserDefaults.timeNotation() == .twelveHour {
            timeFormatter.dateFormat = "hh:mm a"
        } else {
            timeFormatter.dateFormat = "HH:mm"
        }
        
        timeLabel.text = timeFormatter.string(from: weatherData.time)
        
        descriptionLabel.text = weatherData.summary
        
        if UserDefaults.temperatureNotation() != .fahrenheit {
            temperature = temperature.toCelcius()
            temperatureLabel.text = String(format: "%.1f °C", temperature)
        } else {
            temperatureLabel.text = String(format: "%.1f °F", temperature)
        }
        
        if UserDefaults.unitsNotation() != .imperial {
            windSpeed = windSpeed.toKPH()
            windSpeedLabel.text = String(format: "%.f KPH", windSpeed)
        } else {
            windSpeedLabel.text = String(format: "%.f MPH", windSpeed)
        }
        
        iconImageView.image = imageForIcon(withName: weatherData.icon)
    }

    // MARK: - Actions

    @IBAction func didTapSettingsButton(sender: UIButton) {
        delegate?.controllerDidTapSettingsButton(controller: self)
    }

    @IBAction func didTapLocationButton(sender: UIButton) {
        delegate?.controllerDidTapLocationButton(controller: self)
    }

}
