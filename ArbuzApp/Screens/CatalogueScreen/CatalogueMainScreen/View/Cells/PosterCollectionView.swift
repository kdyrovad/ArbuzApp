//
//  PosterCollectionView.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 23.05.2023.
//

import UIKit

class PosterCollectionView: UITableViewCell {
    
    lazy private var images = ["poster1", "poster2", "poster3.jpeg"]
    
    //MARK: - UI Components
    
    let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in

            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(250)),
                subitem: item,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            
            return section
    }))
    
    private lazy var imageeView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup views and constraints
    
    func setupViews() {
        collectionView.addSubview(imageeView)
        
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageeView.widthAnchor.constraint(equalToConstant: 355),
            imageeView.heightAnchor.constraint(equalToConstant: 185)
        ])
    }
    
    func configure(imageName: String){
        imageeView.image = UIImage(named: imageName)
    }
    
    //MARK: - Scrolling posters
    
    var currentIndex = 0
    var timer: Timer?

    @objc func scrollAutomatically(_ timer: Timer) {
        let numberOfItems = collectionView.numberOfItems(inSection: 0)

        guard numberOfItems > 0 else {
            return
        }

        let nextIndex = (currentIndex + 1) % numberOfItems
        let nextIndexPath = IndexPath(item: nextIndex, section: 0)
        
        let nextOffsetX = CGFloat(nextIndex) * collectionView.bounds.width

        var scrollDirection: UICollectionView.ScrollPosition = .right

        if nextIndex < currentIndex {
            scrollDirection = .left
        }

        if nextIndex == 0 && currentIndex == numberOfItems - 1 {
            collectionView.scrollToItem(at: nextIndexPath, at: scrollDirection, animated: false)
            collectionView.layoutIfNeeded()
            collectionView.setContentOffset(CGPoint(x: nextOffsetX, y: 0), animated: true)
        } else {
            collectionView.scrollToItem(at: nextIndexPath, at: scrollDirection, animated: true)
        }

        currentIndex = nextIndex
    }


    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollAutomatically(_:)), userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
}


//MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

extension PosterCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
        let imageName = images[indexPath.item]
        cell.configure(imageName: imageName)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

//MARK: - Exntension UIImage

extension UIImage {
    func resizeTo(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: size))
        }

        return image.withRenderingMode(self.renderingMode)
    }
}

