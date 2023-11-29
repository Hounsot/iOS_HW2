//
//  WishMakerViewController.swift
//  mvvasilev_2PW2
//
//  Created by Matvey Vasilyev on 29.11.2023.
//

import UIKit

final class WishMakerViewController: UIViewController {
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let toggleSlidersButton = UIButton()
    private let stack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        static let stackRadius: CGFloat = 20
        static let buttonRadius: CGFloat = 6
        static let stackBottom: CGFloat = -100
        static let toggleSlidersButtonBottom: CGFloat = -20
        static let toggleSlidersButtontrailingAnchor: CGFloat = -20
        static let stackLeading: CGFloat = 20
        static let titleFontSize: CGFloat = 38
        static let descriptionFontSize: CGFloat = 18
        static let leadingAnchor: CGFloat = 20
        static let titleTop: CGFloat = 30
        static let descriptionTop: CGFloat = 20
        static let colorRange: CGFloat = 100
        
    }
    private func configureUI() { view.backgroundColor = .lightGray
        configureTitle()
        configureDescription()
        configureSliders()
        configureToggleSlidersButton()
    }
    private func configureToggleSlidersButton() {
        toggleSlidersButton.translatesAutoresizingMaskIntoConstraints = false
        toggleSlidersButton.setTitle("Тянучки", for: .normal)
        toggleSlidersButton.backgroundColor = .white
        toggleSlidersButton.layer.cornerRadius = Constants.buttonRadius
        toggleSlidersButton.setTitleColor(.darkGray, for: .normal)
        toggleSlidersButton.addTarget(self, action: #selector(toggleSlidersVisibility), for: .touchUpInside)

        view.addSubview(toggleSlidersButton)
        NSLayoutConstraint.activate([
            toggleSlidersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            toggleSlidersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.toggleSlidersButtontrailingAnchor),
            toggleSlidersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.toggleSlidersButtonBottom)
        ])
    }
    @objc private func toggleSlidersVisibility() {
        stack.isHidden = !stack.isHidden
    }
    private func configureTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Фея крестная"
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.textAlignment = .center

        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTop)
        ])
    }
    private func configureDescription() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Цветик-семицветик app"
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.textColor = UIColor.darkGray
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.descriptionTop)
        ])
    }
    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: "Red", min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: "Blue", min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: "Green", min: Constants.sliderMin, max: Constants.sliderMax)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
            slider.valueChanged = { [weak self, sliderRed, sliderGreen, sliderBlue] _ in
                self?.updateBackgroundColor(sliderRed: sliderRed, sliderGreen: sliderGreen, sliderBlue: sliderBlue)
            } // Я понимаю, что выглядит странно, но я больше не придумал способов достать value из них в другой функции, а мне очень хотелось сделать это в другой функции
        }
//        sliderRed.valueChanged = { [weak self, sliderRed, sliderGreen, sliderBlue] _ in
//            self?.updateBackgroundColor(sliderRed: sliderRed, sliderGreen: sliderGreen, sliderBlue: sliderBlue)
//        } // Я понимаю, что выглядит странно, но я больше не придумал способов достать value из них в другой функции, а мне очень хотелось сделать это в другой функции
//        sliderGreen.valueChanged = sliderRed.valueChanged
//        sliderBlue.valueChanged = sliderRed.valueChanged
        NSLayoutConstraint.activate([
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
        stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.stackBottom)
        ])
    }
    private func updateBackgroundColor(sliderRed: CustomSlider, sliderGreen: CustomSlider, sliderBlue: CustomSlider) {
        let redValue = CGFloat(sliderRed.slider.value)
        let greenValue = CGFloat(sliderGreen.slider.value)
        let blueValue = CGFloat(sliderBlue.slider.value)
        sliderRed.valueView.text = "\(floor(redValue*Constants.colorRange))%"
        sliderGreen.valueView.text = "\(floor(greenValue*Constants.colorRange))%"
        sliderBlue.valueView.text = "\(floor(blueValue*Constants.colorRange))%"
        view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
}
