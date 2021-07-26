//
//  ViewController.swift
//  CatSwipe
//
//  Created by Theo on 26/7/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: UI Components
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .secondarySystemBackground
        imageView.isUserInteractionEnabled = true
        
        let swipeGeasture = UISwipeGestureRecognizer(target: self, action: #selector(swipeImage(_:)))
        swipeGeasture.direction = [.left, .right]
        
        imageView.addGestureRecognizer(swipeGeasture)
        
        return imageView
    }()
    
    // MARK: View Models
    private let viewModel: ViewModel
    
    // MARK: Inits
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        bind()
    }

    // MARK: Bind
    private func bind() {
        viewModel
            .cat
            .sink { [weak self] cat in
                guard let self = self else { return }
                self.imageView.downloadImage(from: cat?.url)
            }
            .store(in: &viewModel.subscriptions)
    }
    
    // MARK: Button actions
    @objc
    private func swipeImage(_ sender: UISwipeGestureRecognizer) {
        viewModel.fetchCatImage()
    }

    // MARK: UI
    private func layoutUI() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

