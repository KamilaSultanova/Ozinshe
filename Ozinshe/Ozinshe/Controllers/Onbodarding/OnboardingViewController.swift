//
//  OnboardingViewController.swift
//  Ozinshe
//
//  Created by Kamila Sultanova on 04.12.2023.
//

import UIKit
import SnapKit


class OnboardingViewController: UIViewController {
    
    let pageControl = {
        
        let pc = UIPageControl()
        pc.numberOfPages = 3
        pc.currentPageIndicatorTintColor = UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1)
        pc.pageIndicatorTintColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        
        return pc
    }()
    
    lazy var collectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collView.backgroundColor = UIColor(named: "OnboardingColor")
        collView.showsHorizontalScrollIndicator = false
        collView.contentInsetAdjustmentBehavior = .never
        collView.isPagingEnabled = true
  
        collView.delegate = self
        collView.dataSource = self
        
        collView.register(SlidesCollectionViewCell.self, forCellWithReuseIdentifier: "SlidesCell")
        
        
        return collView
    }()
    
    var arraySlides: [[String]] = [["firstSlide", "ONBOARD_LABEL", "ONBOARD_DESCRIPT_1"],
                       ["secondSlide", "ONBOARD_LABEL", "ONBOARD_DESCRIPT_2"],
                       ["thirdSlide", "ONBOARD_LABEL", "ONBOARD_DESCRIPT_3"]]
    
    var currentPage = 0{
        didSet{
            pageControl.currentPage = currentPage
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = " "
        navigationController?.navigationBar.tintColor = UIColor(named: "arrowColor")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupUI()
        setupConstraints()
    }
    
    func setupUI(){
        view.addSubview(collectionView)
        view.addSubview(pageControl)
    }
    
    func setupConstraints(){
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().dividedBy(1.2)
            make.centerX.equalToSuperview()
        }
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySlides.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlidesCell", for: indexPath) as! SlidesCollectionViewCell
        
        cell.setData(slide: arraySlides[indexPath.row])
        
        if indexPath.row == 2{
            cell.skipButton.isHidden = true
        }
        cell.skipButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

        if indexPath.row != 2{
            cell.nextButton.isHidden = true
        }
        cell.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    @objc func nextButtonTapped(){
        let signInController = SignInViewController()

        navigationController?.show(signInController, sender: self)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
