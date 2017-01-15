extension UIView: UIGestureRecognizerDelegate {
    public func szMakeMovable() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(szWasDragged(gestureRecognizer:)))
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
        gesture.delegate = self
    }

    public func szWasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.began || gestureRecognizer.state == UIGestureRecognizerState.changed {
            let translation = gestureRecognizer.translation(in: self)

            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)

            gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self)
        }
    }
}
