import UIKit

final class PopFilmsViewController: UIViewController {
  // MARK: - Private Properties
  private let tableView = UITableView()
  private let refreshController = UIRefreshControl()
  
  private var arrData = [Properties]()
  
  // MARK: - UIViewController
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  // MARK: - Visual Components
  private func setupNavigationController() {
    let appearance = UINavigationBarAppearance()
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
    appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
    appearance.backgroundColor = .white
    navigationItem.standardAppearance = appearance
    navigationItem.scrollEdgeAppearance = appearance
    navigationItem.title = "Популярные фильмы"
  }
  
  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
    tableView.backgroundColor = .white
    tableView.refreshControl = refreshController
  }
  
  private func setupRefreshControl() {
    refreshController.addTarget(self, action: #selector(refresh), for: .valueChanged)
    refreshController.tintColor = .black
  }
  
  // MARK: - Private Methods
  private func setupView() {
    setupNavigationController()
    setupRefreshControl()
    setupTableView()
    addSubviews()
    setupSelfView()
    setupTableViewConstraints()
  }
  
  private func addSubviews() {
    [tableView].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  private func setupSelfView() {
    view.backgroundColor = .white
    fetchData()
  }
  
  func fetchData() {
    let jsonURL = "https://api.themoviedb.org/3/movie/popular?api_key=c5c9b81bfa21c9acc5961d318733ccae&language=ru-RU&page=1"
    guard let url = URL(string: jsonURL) else { return }
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data else { return }
      guard error == nil else { return }
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let newData = try decoder.decode(Films.self, from: data)
        DispatchQueue.main.async {
          self.arrData = newData.results
          self.tableView.reloadData()
        }
      } catch {
        print("Error is : \n\(error)")
      }
    }
    task.resume()
  }
  
  // MARK: - Actions
  @objc private func refresh(sender: UIRefreshControl) {
    sender.endRefreshing()
  }
  
  // MARK: - Constraints
  private func setupTableViewConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
}

extension PopFilmsViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailsViewController()
    vc.image = arrData[indexPath.row].posterPath
    vc.titleText = arrData[indexPath.row].title
    vc.overview = arrData[indexPath.row].overview
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension PopFilmsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let movieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell else { return UITableViewCell() }
    guard let path = URL(string: "https://image.tmdb.org/t/p/original\(arrData[indexPath.row].posterPath)") else { return UITableViewCell() }
    URLSession.shared.dataTask(with: path) {
      (data, response, error) in
      guard let data = data else { return }
      DispatchQueue.main.async {
        let model = MovieModel(movie: data, title: self.arrData[indexPath.row].title, overview: self.arrData[indexPath.row].overview)
        movieTableViewCell.configureCell(model: model)
      }
    }.resume()
    return movieTableViewCell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrData.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 225
  }
}




