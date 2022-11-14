//
//  AllowNotificationTutorialViewController.swift
//  SliderApp
//
//  Created by Sun on 11/11/2022.
//

import UIKit
import Reusable

class AllowNotificationTutorialViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var settingButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var autoPlaySwitch: UISwitch!
    
    // MARK: - Property
    var viewModel: AllowNotificationTutorialViewModel!
    var timer: Timer!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
    }
    
    // MARK: - View
    private func setupView() {
        collectionView.register(cellType: AllowNotificationTutorialCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        settingButton.cornerRadius = settingButton.frame.height / 2
        cancelButton.cornerRadius = settingButton.frame.height / 2
        setupSwitch()
    }
    
    private func setupSwitch() {
        autoPlaySwitch.tintColor = .systemBlue
        autoPlaySwitch.backgroundColor = .systemPink
        autoPlaySwitch.layer.masksToBounds = true
        autoPlaySwitch.cornerRadius = 16
    }
    
    // MARK: - Data
    private func setupData() {
        onTimer()
    }
    
    private func getCurrentRow() -> Int {
        for cell in collectionView.visibleCells {
            if let row = collectionView.indexPath(for: cell)?.item {
                return row
            }
        }
        return 0
    }
    
    @objc private func setupSlider() {
        scrollToItem(calculator: +)
    }
    
    private func onTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.setupSlider), userInfo: nil, repeats: true)
    }
    
    private func offTimer() {
        timer.invalidate()
    }
    
    // MARK: - Action
    private func scrollToItem(calculator: (Int, Int) -> Int) {
        let maxCount = viewModel.imageDataDictionary.count
        var currentRow = getCurrentRow()
        currentRow = calculator(currentRow, 1)
        currentRow = currentRow % maxCount
        let toIndexPath = IndexPath(row: currentRow, section: 0)
        collectionView.scrollToItem(at: toIndexPath, at: .centeredVertically, animated: true)
    }
    
    @IBAction func settingAction(_ sender: Any) {
        viewModel.gotoSettingScreen()
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func autoPlaySwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            onTimer()
        } else {
            offTimer()
        }
    }
}

@available(iOSApplicationExtension, unavailable)
extension AllowNotificationTutorialViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageStringItem = viewModel.imageStringArray[indexPath.row]
        let imageData = viewModel.imageDataDictionary[imageStringItem]
        let cell: AllowNotificationTutorialCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setContent(data: imageData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageDataDictionary.count
    }
}

@available(iOSApplicationExtension, unavailable)
extension AllowNotificationTutorialViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
