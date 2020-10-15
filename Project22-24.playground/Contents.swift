import UIKit

extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}


extension Int {
    func times(_ closure: () -> Void) {
        if self > 0 {
            for _ in 0..<self {
                closure()
            }
        }
    }
}

extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let elem = self.firstIndex(of: item) {
            self.remove(at: elem)
        }
    }
}


let view = UIView()
view.bounceOut(duration: 3)

5.times { print("Hello") }

var numbers = [1, 2, 3, 4, 5, 3]
numbers.remove(item: 3)
