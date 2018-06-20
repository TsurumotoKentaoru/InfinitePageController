//
//  ViewController.swift
//  InfinitePageController
//
//  Created by 鶴本賢太朗 on 2018/06/20.
//  Copyright © 2018年 Kentarou. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    // 表示するViewControllerのリスト
    private let vcList: [UIViewController]
    
    required init?(coder: NSCoder) {
        // ViewControllerのリストを初期化する
        let redVC: RedViewController = RedViewController()
        let blueVC: BlueViewController = BlueViewController()
        let yellowVC: YellowViewController = YellowViewController()
        let vcList: [UIViewController] = [redVC, blueVC, yellowVC]
        self.vcList = vcList
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPageViewControllers()
    }
    
    // ページングの初期化をする
    private func initPageViewControllers() {
        // 一番最初に表示したいViewControllerを指定する
        self.setViewControllers([self.vcList[0]], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }
    
    // MARK: 次のViewControllerのindexを取得する
    // originViewController: ページングする前のViewController
    // ifAfter: true=後のViewControlelrか, false: 前か
    private func nextVCIndex(originViewController: UIViewController, ifAfter: Bool) -> Int? {
        guard let originVCIndex: Int = self.vcList.index(of: originViewController) else {
            return nil
        }
        var nextVCIndex: Int = originVCIndex
        nextVCIndex += ifAfter ? 1 : -1
        if nextVCIndex >= self.vcList.count {
            nextVCIndex = 0
        }
        else if nextVCIndex < 0 {
            nextVCIndex = self.vcList.count - 1
        }
        return nextVCIndex
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let nextVCIndex: Int = self.nextVCIndex(originViewController: viewController, ifAfter: false) {
            let nextVC: UIViewController = self.vcList[nextVCIndex]
            return nextVC
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let nextVCIndex: Int = self.nextVCIndex(originViewController: viewController, ifAfter: true) {
            let nextVC: UIViewController = self.vcList[nextVCIndex]
            return nextVC
        }
        return nil
    }
}
