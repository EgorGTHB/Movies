import UIKit

final class DetailsViewController: UIViewController {
  // MARK: - Private Properties
  private let movieImageView = UIImageView()
  private let titleLabel = UILabel()
  private let overviewTextView = UITextView()
  
  // MARK: - Public Properties
  var image = String()
  var titleText = String()
  var overview = String()
  
  // MARK: - UIViewController
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  //MARK: - Visual Components
  private func setupAppearance() {
    view.backgroundColor = .white
  }
  
  private func setupMovieImageView() {
    guard let path = URL(string: "https://image.tmdb.org/t/p/original\(image)") else { return }
   let task = URLSession.shared.dataTask(with: path) {
      (data, response, error) in
      guard let data = data else { return }
      DispatchQueue.main.async {
        self.movieImageView.image = UIImage(data: data)
      }
    }
    task.resume()
    movieImageView.layer.cornerRadius = 20
    movieImageView.layer.masksToBounds = true
    movieImageView.contentMode = .scaleAspectFit
    movieImageView.layer.borderWidth = 1
    movieImageView.layer.borderColor = UIColor.gray.cgColor
    movieImageView.contentMode = .scaleAspectFill
  }
  
  private func setupTitleLabel() {
    titleLabel.text = titleText
    titleLabel.textAlignment = .center
    titleLabel.textColor = .black
    titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
  }
  
  private func setupOverviewTextView() {
    overviewTextView.text = overview
    overviewTextView.textAlignment = .center
    overviewTextView.textColor = .black
    overviewTextView.font = .systemFont(ofSize: 20)
  }
  
  //MARK: - Private Methods
  private func setupView() {
    setupMovieImageView()
    setupTitleLabel()
    setupOverviewTextView()
    setupAppearance()
    addSubviews()
    setupMovieImageViewConstraint()
    setupTitleLabelConstraint()
    setupOverviewTextViewConstraint()
  }
  
  private func addSubviews() {
    [movieImageView, titleLabel, overviewTextView].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  //MARK: - Constraints
  private func setupMovieImageViewConstraint() {
    NSLayoutConstraint.activate([
      movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      movieImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      movieImageView.heightAnchor.constraint(equalToConstant: 420)
    ])
  }
  
  private func setupTitleLabelConstraint() {
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      titleLabel.heightAnchor.constraint(equalToConstant: 30),
      titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 30)
    ])
  }
  
  private func setupOverviewTextViewConstraint() {
    NSLayoutConstraint.activate([
      overviewTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      overviewTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      overviewTextView.heightAnchor.constraint(equalToConstant: 200),
      overviewTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
    ])
  }
}

