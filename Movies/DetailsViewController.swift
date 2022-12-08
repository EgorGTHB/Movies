import UIKit
import Kingfisher

final class DetailsViewController: UIViewController {
  // MARK: - Private Properties
  private let movieImageView = UIImageView()
  private let titleLabel = UILabel()
  private let overviewTextView = UITextView()
  
  // MARK: - Public Properties
  var detail: DetailModel?

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
    movieImageView.layer.cornerRadius = 20
    movieImageView.layer.masksToBounds = true
    movieImageView.contentMode = .scaleAspectFill
    movieImageView.layer.borderWidth = 1
    movieImageView.layer.borderColor = UIColor.gray.cgColor
  }
  
  private func setupTitleLabel() {
    titleLabel.text = detail?.titleText
    titleLabel.textAlignment = .center
    titleLabel.textColor = .black
    titleLabel.font = .systemFont(ofSize: 23, weight: .bold)
  }
  
  private func setupOverviewTextView() {
    overviewTextView.text = detail?.overview
    overviewTextView.textAlignment = .center
    overviewTextView.textColor = .black
    overviewTextView.backgroundColor = .white

    overviewTextView.font = .systemFont(ofSize: 20)
  }
  
  //MARK: - Private Methods
  private func setupView() {
    network()
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
  
  private func network() {
    guard let image = detail?.image else { return } 
    let url = "https://image.tmdb.org/t/p/original\(image)"
    movieImageView.kf.setImage(with: URL(string: url), placeholder: UIImage(systemName: "photo"), options: nil, progressBlock: nil)
  }
  
  //MARK: - Constraints
  private func setupMovieImageViewConstraint() {
    NSLayoutConstraint.activate([
      movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide .topAnchor, constant: 10),
      movieImageView.heightAnchor.constraint(equalToConstant: 350)
    ])
  }
  
  private func setupTitleLabelConstraint() {
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      titleLabel.heightAnchor.constraint(equalToConstant: 25),
      titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10)
    ])
  }
  
  private func setupOverviewTextViewConstraint() {
    NSLayoutConstraint.activate([
      overviewTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      overviewTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      overviewTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      overviewTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
    ])
  }
}

