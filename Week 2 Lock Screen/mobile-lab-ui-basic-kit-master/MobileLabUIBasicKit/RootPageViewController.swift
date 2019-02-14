//
//  RootPageViewController.swift
//  MobileLabUIKit
//
//  Created by Nien Lam on 12/14/17.
//  Copyright © 2017 Mobile Lab. All rights reserved.
//
//  Description:
//  Root view controller for wrapping other view controllers for paging.

import UIKit

class RootPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    // Lazy loader for instantiating view controllers.
    lazy var viewControllerList:[UIViewController] = {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "DefaultUIVC")
        let vc2 = sb.instantiateViewController(withIdentifier: "CustomUIVC")
        let vc3 = sb.instantiateViewController(withIdentifier: "SportUIVC")
        let vc4 = sb.instantiateViewController(withIdentifier: "LCARSUIVC")

        return [vc1, vc2, vc3, vc4]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set page view data source to current class.
        self.dataSource = self

        // Set initial view controller.
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    
        // Prioritize UI slider control on touches versus paging the view.
        for view in view.subviews {
            if view is UIScrollView {
                (view as? UIScrollView)?.delaysContentTouches = false
            }
        }
    }
    
    // Hide status bar.
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Logic for making UIPageControl background clear.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let subViews: NSArray = view.subviews as NSArray
        var scrollView: UIScrollView? = nil
        var pageControl: UIPageControl? = nil
        
        for view in subViews {
            if view is UIScrollView {
                scrollView = view as? UIScrollView
            }
            else if view is UIPageControl {
                pageControl = view as? UIPageControl
            }
        }
        
        if (scrollView != nil && pageControl != nil) {
            scrollView?.frame = view.bounds
            view.bringSubviewToFront(pageControl!)
        }
    }
    
    // Logic for swpiging page view controller to the left.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else { return nil }
        
        let prevIndex = vcIndex - 1

        guard prevIndex >= 0 else { return nil }
        
        guard viewControllerList.count > prevIndex else { return nil }
        
        return viewControllerList[prevIndex]
    }
    
    // Logic for swpiging page view controller to the right.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let vcIndex = viewControllerList.index(of: viewController) else { return nil }
        
        let nextIndex = vcIndex + 1
        
        guard viewControllerList.count != nextIndex else { return nil }

        guard viewControllerList.count > nextIndex else { return nil }

        return viewControllerList[nextIndex]
    }

    // Customize page indicator color.
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.darkGray
        appearance.currentPageIndicatorTintColor = UIColor.lightGray
        
        return viewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
