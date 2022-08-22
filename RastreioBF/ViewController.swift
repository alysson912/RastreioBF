//
//  ViewController.swift
//  RastreioBF
//
//  Created by ALYSSON MENEZES on 20/08/22.
//

import UIKit

struct Section {
    let title: String
    let options : [SettingsOptionsType]
}

enum SettingsOptionsType {
    case staticCell(model : SettingsOption)
    case switchCell(model : SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title : String
    let icon : UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var  isOn: Bool
}

struct SettingsOption {
    let title : String
    let icon : UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private let tablewView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tablewView)
        tablewView.delegate = self
        tablewView.dataSource = self
        tablewView.frame = view.bounds
    }
    
    // icones e descricao
    func configure(){
      // grupo 1
            models.append(Section(title: "Notificações", options: [
                .switchCell(model : SettingsSwitchOption(title: "Ativar Notificações", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemOrange, handler: {
            // colocar acao aqui
                    print("tapped first cell ")
                }, isOn: true)),
                   
            ]))
    
    // grupo 2
    models.append(Section(title: "Rastreio", options: [
        .staticCell(model : SettingsOption(title: "Notificações", icon: UIImage(systemName: "person"), iconBackgroundColor: .link){
            print("tapped first cell ") // action
            
        }),
        .staticCell(model : SettingsOption(title: "Descrição", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemGreen){

        }),
        .staticCell(model : SettingsOption(title: "Cadastro", icon: UIImage(systemName: "cloud"), iconBackgroundColor: .systemCyan){

        }),
        .staticCell(model : SettingsOption(title: "Movimentação", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPurple){

        }),

       
    ]))
}
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[ indexPath.section].options[ indexPath.row]
      
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsTableViewCell.identifier,
                for: indexPath
            ) as? SettingsTableViewCell else {
                    return UITableViewCell()
            }
            cell.configure(width: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                    return UITableViewCell()
            }
            cell.configure(width: model)
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[ indexPath.section].options[ indexPath.row]
          switch type.self {
          case .staticCell(let model):
              model.handler()
          case .switchCell(let model):
              model.handler()
          }
    }
}

