//
//  KCUIPageView.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit

class KCUIPageView: UIControl {
    public var currentPage: Int = 0

    var scrollView: UIScrollView!
    var stackView: UIStackView!

    private var pageViews: [UIView] = []
    private var isScrollDragEngaged : Bool = false

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupScrollView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupScrollView()
    }
    
    
    
    private func commonInit() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)

        // Add constraints to position and size the scrollView within the containerView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal // Customize the axis and properties as needed
        scrollView.addSubview(stackView)

        // Add constraints to position and size the stackView within the scrollView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor) // Ensure stackView width matches scrollView width
        ])
    }
    
    
    private func setupScrollView() {
        // Configure the scrollView, such as paging and delegate
        scrollView?.isPagingEnabled = true
        scrollView?.delegate = self
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Update the frame of the scrollView to match the PagerView's size
        scrollView?.frame = bounds

        // Update the content size of the scrollView based on the number of pages
        let pageCount = pageViews.count
        let pageWidth = bounds.width
        scrollView?.contentSize = CGSize(width: pageWidth * CGFloat(pageCount), height: bounds.height)

        // Adjust the position of the current page
        let xOffset = CGFloat(currentPage) * pageWidth
        scrollView?.contentOffset = CGPoint(x: xOffset, y: 0)
    }
    
    
    
    /// Add new page view
    ///
    /// - Parameters:
    ///   - pageView: `UIView`
    func addPageView(_ pageView: UIView) {
        // Add a page view to the stackView
        pageViews.append(pageView)
        
        pageView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView?.addArrangedSubview(pageView)

        // Add constraints to position and size the stackView within the scrollView
        NSLayoutConstraint.activate([
            pageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            pageView.heightAnchor.constraint(equalTo: self.heightAnchor) // Ensure stackView width matches scrollView width
        ])
    }

    
    
    /// Add new `UIViewController` as a new page
    ///
    /// - Parameters:
    ///   - viewController: `UIViewController`
    func addPageViewController(_ viewController: UIViewController) {
        // Add the view controller's view to the scrollView
        pageViews.append(viewController.view)

        stackView?.addArrangedSubview(viewController.view)
        
        // Add constraints to position and size the stackView within the scrollView
        NSLayoutConstraint.activate([
            viewController.view.widthAnchor.constraint(equalTo: self.widthAnchor),
            viewController.view.heightAnchor.constraint(equalTo: self.heightAnchor) // Ensure stackView width matches scrollView width
        ])
    }
    
    
}


extension KCUIPageView: UIScrollViewDelegate {
    
    /// Jump to page
    ///
    /// - Parameters:
    ///   - pageIndex: target page index
    ///   - animated: `Bool`
    func goToPage(_ pageIndex: Int, animated: Bool = true) {

        isScrollDragEngaged = false

        // Scroll to a specific page
        let pageWidth = scrollView?.frame.width ?? 0
        let contentOffset = CGPoint(x: CGFloat(pageIndex) * pageWidth, y: 0)
        scrollView?.setContentOffset(contentOffset, animated: animated)
        
        if currentPage != pageIndex {
            currentPage = pageIndex
            sendActions(for: .valueChanged)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isScrollDragEngaged { return }

        let pageWidth = scrollView.frame.width
        let c = Int( (scrollView.contentOffset.x  + pageWidth / 2) / pageWidth)
        if currentPage != c {
            currentPage = c
            print(currentPage)
            sendActions(for: .valueChanged)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / pageWidth)
        sendActions(for: .valueChanged)
        isScrollDragEngaged = false
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScrollDragEngaged = true
    }
}
