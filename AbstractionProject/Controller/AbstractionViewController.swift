//
//  AbstractionViewController.swift
//  AbstractionProject
//
//  Created by Porter, Tyler on 12/17/19.
//  Copyright © 2019 CTEC. All rights reserved.
//

import UIKit

public class AbstractionViewController: UIPageViewController, UIPageViewControllerDataSource
{

    public override func viewDidLoad()
    {
        super.viewDidLoad()
        dataSource = self
        
        if let firstViewController = orderedAbstractionViews.first
        {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }
    
    //MARK:- Data members
    private lazy var orderedAbstractionViews : [UIViewController] =
    {
        return [
            self.newAbstractionViewController(abstractionLevel: "Swift"),
            self.newAbstractionViewController(abstractionLevel: "Block"),
            self.newAbstractionViewController(abstractionLevel: "ByteCode"),
            self.newAbstractionViewController(abstractionLevel: "Binary"),
            self.newAbstractionViewController(abstractionLevel: "LogicalGate")
        ]
    }()
    
    //MARK: Helper method to retrieve the correct ViewController based on the data member
    private func newAbstractionViewController(abstractionLevel : String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(abstractionLevel)ViewController")
    }
    
    //MARK:- Datasource required methods
    /// Swipe Left
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = orderedAbstractionViews.index(of: viewController)
            else
        {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0
            else
        {
            return orderedAbstractionViews.last
        }
        
        guard orderedAbstractionViews.count > previousIndex
            else
        {
            return nil
        }
        
        return orderedAbstractionViews[previousIndex]
    }
    
    //Swipe Right
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = orderedAbstractionViews.index(of: viewController)
            else
        {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex >= 0
            else
        {
            return nil
        }
        
        guard nextIndex < orderedAbstractionViews.count
            else
        {
            return orderedAbstractionViews.first
        }
        
        return orderedAbstractionViews[nextIndex]
    }
    
    //MARK:- Optional Support for the dots in the UIPageViewController
    public func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        return orderedAbstractionViews.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = orderedAbstractionViews.index(of: firstViewController)
            else
        {
            return 0
        }
        return firstViewControllerIndex
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
