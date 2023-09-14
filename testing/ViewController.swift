import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var options = ["Opción 1", "Opción 2", "Opción 3"]
    let dropDownButton = UIButton(type: .system)
    var isDropdownVisible = false
    let redView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redView.backgroundColor = .red
        // Crea el botón para mostrar/ocultar el menú desplegable
        dropDownButton.setTitle("Seleccionar opción", for: .normal)
        dropDownButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
        dropDownButton.frame = CGRect(x: 20, y: 100, width: 200, height: 40)
        dropDownButton.translatesAutoresizingMaskIntoConstraints = false
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dropDownButton)
        view.addSubview(redView)
        
        // Crea la UITableView y configúrala
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.backgroundView = .none
        tableView.isHidden = true
        tableView.frame = CGRect(x: 20, y: 150, width: 200, height: 0) // Altura inicial 0
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dropDownButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dropDownButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dropDownButton.widthAnchor.constraint(equalToConstant: 100),
            dropDownButton.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.topAnchor.constraint(equalTo: dropDownButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            redView.topAnchor.constraint(equalTo: dropDownButton.bottomAnchor),
            redView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Función para mostrar/ocultar el menú desplegable
    @objc func toggleDropdown() {
        isDropdownVisible.toggle()
        if isDropdownVisible {
            tableView.isHidden = false
            UIView.animate(withDuration: 0.2) {
                self.tableView.frame.size.height = CGFloat(self.options.count * 44) // Altura de fila predeterminada: 44
                NSLayoutConstraint.activate([
                    self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    self.tableView.heightAnchor.constraint(equalToConstant: CGFloat(self.options.count * 44))
                ])
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.tableView.frame.size.height = 0
            } completion: { (_) in
                self.tableView.isHidden = true
            }
        }
    }
    
    // Implementa los métodos necesarios para UITableViewDelegate y UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    // Para proporcionar una estimación de la altura de la fila. Esto es importante para mejorar el rendimiento de la tabla.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.row]
        // Haz algo con la opción seleccionada, como mostrarla en un label o guardarla
        print("Opción seleccionada: \(selectedOption)")
        self.dropDownButton.setTitle("\(selectedOption)", for: .normal)
        toggleDropdown() // Oculta el menú desplegable después de la selección
    }
}

