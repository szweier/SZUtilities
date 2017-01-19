private var additionalWindowAssociationKey: UInt8 = 0

public extension UIViewController {
    internal var additionalWindow: UIWindow! {
        get {
            return objc_getAssociatedObject(self, &additionalWindowAssociationKey) as? UIWindow
        }
        set(newValue) {
            objc_setAssociatedObject(self, &additionalWindowAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    func szPresentGlobally(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
        additionalWindow = UIWindow()
        additionalWindow.backgroundColor = .clear
        additionalWindow.rootViewController = UIViewController()
        additionalWindow.windowLevel = UIWindowLevelAlert + 1
        additionalWindow.makeKeyAndVisible()
        additionalWindow.rootViewController?.present(viewControllerToPresent, animated: animated, completion: completion)
    }

    func szDismissGlobal(animated: Bool, completion: (() -> Void)?) {
        additionalWindow.rootViewController?.dismiss(animated: animated, completion: { [weak self] in
            self?.additionalWindow.isHidden = true
            self?.additionalWindow = nil
            completion?()
        })
    }
}
