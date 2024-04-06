//
//  ViewController.swift
//  MarketPlace
//
//  Created by Anuar Orazbekov on 04.04.2024.
//

import Then
import SnapKit
import UIKit
import ReactiveSwift
import RxDataSources
import RxSwift
import Lottie

// MARK: - Section
typealias CocktailSection = AnimatableSectionModel<String, Cocktail>

// MARK: - ViewController

final class ViewController: BaseViewController {

    private lazy var navigationTitle = UILabel().then {
        $0.text = "Cocktails"
        $0.numberOfLines = 0
    }
    
    private lazy var searchBar = UISearchBar().then {
        $0.placeholder = "Search"
        $0.backgroundImage = UIImage()
        $0.delegate = self
    }
    
    private lazy var scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.bounces = false
        $0.isPagingEnabled = true
        $0.delegate = self
    }
       
    private lazy var layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 8
        $0.minimumInteritemSpacing = 8
        $0.sectionHeadersPinToVisibleBounds = true
        
        let width = view.bounds.width
        let padding: CGFloat = 16
        let minimusItemSpacing: CGFloat = 8
        let availableWidth = width - (padding * 2) - (minimusItemSpacing * 2)
        let itemWidth = availableWidth / 2
        
        $0.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        $0.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    private lazy var alcCocktailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.register(CocktailsCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(CocktailsCollectionViewCell.self))
    }

    private lazy var nonAlcCocktailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.register(CocktailsCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(CocktailsCollectionViewCell.self))
    }

       
    private var alcCocktailsDataSource: RxCollectionViewSectionedAnimatedDataSource<CocktailSection>!
    
    private var nonAlcCocktailsDataSource: RxCollectionViewSectionedAnimatedDataSource<CocktailSection>!
    
    private let segmentedControl: BaseSegmentControl = .init(items: DrinkCategory.allCases.map { $0.title })
    
    private let fetchCocktailsSubject: PublishSubject<DrinkCategory> = .init()
    
    private let viewModel: MarketPlaceViewModel
    
    init(viewModel: MarketPlaceViewModel) {
        self.viewModel = viewModel
    }
 
    override func viewDidLoad() {
        configureDataSource()
        
        alcCocktailCollectionView.delegate = self
        nonAlcCocktailCollectionView.delegate = self

        super.viewDidLoad()

        configureViews()
    }
    
    override func bind() {
        let searchQueryObservable = searchBar.rx.text.orEmpty.asObservable()

        let output = viewModel.transform(
            input: .init(
                fetchCocktails: fetchCocktailsSubject.asObserver(), searchQuery: searchQueryObservable
            )
        )
        
        output.alcCocktailsSections
            .bind(to: alcCocktailCollectionView.rx.items(dataSource: alcCocktailsDataSource))
            .disposed(by: disposeBag)
        
        output.nonAlcCocktailsSections
            .bind(to: nonAlcCocktailCollectionView.rx.items(dataSource: nonAlcCocktailsDataSource))
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        view.backgroundColor = .white
        [navigationTitle, searchBar, segmentedControl, scrollView].forEach { view.addSubview($0)}
    }
    
    override func setupLayout() {
        navigationTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(-10)
            $0.left.equalToSuperview().offset(16)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(navigationTitle.snp.bottom).inset(-10)
            $0.left.right.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).inset(-10)
            $0.left.right.equalToSuperview().inset(10)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        configureScrollView()
    }
}

private extension ViewController {
    
    func configureViews() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        fetchCocktailsSubject.onNext(.alcoholic)
        fetchCocktailsSubject.onNext(.nonAlcoholic)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        let offsetX = CGFloat(selectedSegmentIndex) * scrollView.frame.size.width
        UIView.animate(withDuration: 0.3) {
            self.scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        }
    }
    
    private func configureDataSource() {
        alcCocktailsDataSource = RxCollectionViewSectionedAnimatedDataSource<CocktailSection>(
            configureCell: configureCell
        )

        nonAlcCocktailsDataSource = RxCollectionViewSectionedAnimatedDataSource<CocktailSection>(
            configureCell: configureCell
        )
    }
    
    private func configureCell(dataSource: CollectionViewSectionedDataSource<CocktailSection>, collectionView: UICollectionView, indexPath: IndexPath, item: Cocktail) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CocktailsCollectionViewCell.self), for: indexPath) as? CocktailsCollectionViewCell else {
             return UICollectionViewCell()
         }
         cell.set(model: .init(imageURL: item.imageStrURL, title: item.title))
         return cell
     }
    
    func configureScrollView() {
        scrollView.layoutIfNeeded()
        
        let collectionViews = [alcCocktailCollectionView, nonAlcCocktailCollectionView]
        scrollView.contentSize = .init(
            width: CGFloat(collectionViews.count) * scrollView.frame.width,
            height: scrollView.frame.height
        )
        
        for (index, collectionView) in collectionViews.enumerated() {
            collectionView.frame = .init(
                x: scrollView.frame.width * CGFloat(index),
                y: 0,
                width: scrollView.frame.width,
                height: scrollView.frame.height
            )
            scrollView.addSubview(collectionView)
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentedControl.selectedSegmentIndex = Int(round(scrollView.contentOffset.x / view.frame.width))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cocktail: Cocktail
        var isAlhocolic = false
        if collectionView == alcCocktailCollectionView {
            cocktail = alcCocktailsDataSource[indexPath]
            isAlhocolic = true
        } else {
            cocktail = nonAlcCocktailsDataSource[indexPath]
        }
        
        let detailViewController = CocktailDetailViewController(cocktail: cocktail, isAlcoholic: isAlhocolic)
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        viewModel.searchQuerySubject.onNext(searchText)
    }
}
