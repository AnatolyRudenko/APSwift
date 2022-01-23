//
//  UIView.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 06.12.2021.
//

import UIKit

// MARK: - Functional
public extension UIView {
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach({ addSubview($0) })
    }
    
    func fitSubviewIn(_ subview: UIView, insets: UIEdgeInsets = .zero) {
        addSubview(subview)
        subview.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(insets.top)
            make.left.equalToSuperview().inset(insets.left)
            make.right.equalToSuperview().inset(insets.right)
            make.bottom.equalToSuperview().inset(insets.bottom)
        }
    }
    
    func fitSubviewIn(_ subview: UIView, inset: CGFloat) {
        addSubview(subview)
        subview.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(inset)
        }
    }
}

// MARK: - Visual
public extension UIView {
    
    func fadeTo(
        _ alpha: CGFloat,
        duration: TimeInterval = 0.3,
        delay: TimeInterval = 0,
        completion: (() -> Void)? = nil) {
            
            UIView.animate(
                withDuration: duration,
                delay: delay,
                options: .curveEaseInOut,
                animations: {
                    self.alpha = alpha
                },
                completion: nil
            )
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                completion?()
            }
        }
    
    func fadeIn(duration: TimeInterval = 0.3, delay: TimeInterval = 0, completion: (() -> Void)? = nil) {
        fadeTo(1, duration: duration, delay: delay, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.3, delay: TimeInterval = 0, completion: (() -> Void)? = nil) {
        fadeTo(0, duration: duration, delay: delay, completion: completion)
    }
    
    func setHidden(_ hide: Bool, animated: Bool = true, completion: Closure? = nil) {
        hide ? self.hide(completion: completion) : self.show(completion: completion)
    }
    
    func animatesTap() {
        UIView.animate(withDuration: 0.15, delay: .zero, options: .curveLinear) { [weak self] in
            self?.alpha = 0.4
        } completion: { [weak self] _ in
            self?.alpha = 1
        }
    }
    
    private func show(animated: Bool = true, completion: Closure? = nil) {
        guard animated else {
            isHidden = false
            completion?()
            return
        }
        self.alpha = 0
        self.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        } completion: { _ in
            completion?()
        }
    }
    
    private func hide(animated: Bool = true, completion: Closure? = nil) {
        guard animated else {
            isHidden = true
            completion?()
            return
        }
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        } completion: { _ in
            self.isHidden = true
            self.alpha = 1
            completion?()
        }
    }
}

// MARK: - Corners Radius
public extension UIView {
    
    func roundCorners(_ value: CGFloat = 20) {
        layer.cornerRadius = value
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

// MARK: - Shadows
public extension UIView {
    
    func addShadowLayer(index: Int, color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.name = "shadow"
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        shadowLayer.fillColor = backgroundColor?.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowOffset = offset
        shadowLayer.shadowRadius = radius
        shadowLayer.backgroundColor = UIColor.black.cgColor
        self.layer.insertSublayer(shadowLayer, at: UInt32(index))
    }
    
    func removeShadows() {
        shadowLayers.forEach({ $0.removeFromSuperlayer() })
    }
    
    var shadowLayers: [CALayer] {
        layer.sublayers?.filter { $0.name == "shadow" } ?? []
    }
}

// MARK: - Static
public extension UIView {
    
    static func stackView(_ axis: NSLayoutConstraint.Axis, _ spacing: CGFloat, _ subviews: [UIView], insets: DirectionalInsets? = nil) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.addArrangedSubviews(subviews)
        if let insets = insets {
            stackView.setInsets(NSDirectionalEdgeInsets(top: insets.vertical,
                                                        leading: insets.horizontal,
                                                        bottom: insets.vertical,
                                                        trailing: insets.horizontal))
        }
        return stackView
    }
    
    static func container<Content: UIView>(content: Content, insets: UIEdgeInsets) -> ContainerView<Content> {
        ContainerView(content: content, insets: insets)
    }
}
