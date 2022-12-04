import UIKit

final class MovieTableViewCell: UITableViewCell {
  //MARK: - Private Properties
   let movieImageView = UIImageView()
   let originalTitleLabel = UILabel()
   let overviewLabel = UILabel()
 
  // MARK: - UICollectionViewCell
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCell()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Visual Components
  private func setupAppearance() {
    backgroundColor = .white
    selectionStyle = .none
  }
  
  private func setupMovieImageView() {
    movieImageView.contentMode = .scaleAspectFit
  }
  
  private func setupOriginalTitleLabel() {
    originalTitleLabel.textAlignment = .center
    originalTitleLabel.textColor = .black
    originalTitleLabel.font = .systemFont(ofSize: 17, weight: .bold)
    originalTitleLabel.numberOfLines = 2
  }
  
  private func setupOverviewLabel() {
    overviewLabel.textAlignment = .center
    overviewLabel.textColor = .gray
    overviewLabel.font = .systemFont(ofSize: 15)
    overviewLabel.numberOfLines = 6
  }
  
  //MARK: - Private Methods
  private func setupCell() {
    setupMovieImageView()
    setupOriginalTitleLabel()
    setupOverviewLabel()
    setupAppearance()
    addSubviews()
    setupMovieImageViewConstraint()
    setupOriginalTitleLabelConstraint()
    setupOverviewLabelConstraint()
  }
  
  private func addSubviews() {
    [movieImageView, originalTitleLabel, overviewLabel].forEach {
      contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  //MARK: - Public Methods
  func configureCell(model: MovieModel) {
    movieImageView.image = UIImage(data: model.movie)
    originalTitleLabel.text = model.title
    overviewLabel.text = model.overview
  }
  
  //MARK: - Constraints
  private func setupMovieImageViewConstraint() {
    NSLayoutConstraint.activate([
      movieImageView.widthAnchor.constraint(equalToConstant: 140),
      movieImageView.heightAnchor.constraint(equalToConstant: 200),
      movieImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
    ])
  }
  
  private func setupOriginalTitleLabelConstraint() {
    NSLayoutConstraint.activate([
      originalTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
      originalTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      originalTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12.5),
      originalTitleLabel.heightAnchor.constraint(equalToConstant: 42),
      originalTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15)
    ])
  }
  
  private func setupOverviewLabelConstraint() {
    NSLayoutConstraint.activate([
      overviewLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
      overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      overviewLabel.heightAnchor.constraint(equalToConstant: 150),
      overviewLabel.topAnchor.constraint(equalTo:     originalTitleLabel.bottomAnchor, constant: 5)
    ])
  }
}
