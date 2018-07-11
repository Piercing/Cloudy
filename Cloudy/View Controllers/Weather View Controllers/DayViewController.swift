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
    
    // Sustituimos la propiedad "now" por una instancia de
    // la struct  "DayViewViewModel", dejando la propiedad
    // observador "didSet" sin tocar.
    var viewModel: DayViewViewModel? {
        didSet {
            updateView()
        }
    }
    
    /* NOTA: Al  eliminar dicha propiedad tenemos que actualizar
     el view controller root, ya que ya no se pasa una instancia
     de "WeatherData a este controlador.
     
     En cambio, el controlador raíz crea una instancia del MV
     "DayViewViewModel" utilizando una instancia "WeatherData"
     y establece una propiedad del view controller day*/
    
    
// Eliminamos la propiedad y la sustituimos por la de arriba.
//    var now: WeatherData? {
//        didSet {
//            updateView()
//        }
//    }

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

    //MARK: - Update View

    private func updateView() {
        activityIndicatorView.stopAnimating()

        if let viewModel = viewModel {
            updateWeatherDataContainer(withViewModel: viewModel)
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
    
    // Por último, cambiamos el parámetro que recibe de "withWeatherData" a -->"withViewModel"
    // dado que tiene más sentido porque este controlador ya no accede directamente al modelo
    // sino que lo hace a través del "VM --> DayViewViewModel".
    
    // Esto también nos significa que tenemos que actualizar el método "updateView()",
    // además de sustituir las referencias de la propiedad  "now" por referencias de
    // la propiedad "viewModel".
    
    // Por último, hacemos la implementación de este método más corta. En lugar de utilizar
    // los "raw valuew" del modelo, simplemente solicitaremos al view model los datos que
    // el view controller necestia para mostrar en su vista correspondiente.
    private func updateWeatherDataContainer(withViewModel viewModel: DayViewViewModel) { // <-- Acceso al VM "DayViewViewModel"!!
       
        weatherDataContainer.isHidden = false
        
        dateLabel.text          = viewModel.date
        timeLabel.text          = viewModel.time
        iconImageView.image     = viewModel.image
        windSpeedLabel.text     = viewModel.windSpeed
        descriptionLabel.text   = viewModel.summary
        temperatureLabel.text   = viewModel.temperature
       
    }

    // MARK: - Actions

    @IBAction func didTapSettingsButton(sender: UIButton) {
        delegate?.controllerDidTapSettingsButton(controller: self)
    }

    @IBAction func didTapLocationButton(sender: UIButton) {
        delegate?.controllerDidTapLocationButton(controller: self)
    }

}
