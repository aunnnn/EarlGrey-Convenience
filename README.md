# EarlGrey-Convenience
Convenience functions for EarlGrey UI testing. This is not really exhaustive, it will grow as we use it.

### Selectors
```swift
func element(id: String) -> GREYInteraction
func element(text: String) -> GREYInteraction
func element(aClass: AnyClass) -> GREYInteraction

// this uses grey_buttonTitle, but element(text:) should also work
func button(title: String) -> GREYInteraction

// Get nav bar's back button
func navigationBackButton() -> GREYInteraction
```

### Assertions
```swift
func makeSureKeyWindowVisible()

func waitUntilElementIsGone(id: String, waitTime: TimeInterval = 10)
func waitUntilElementIsGone(text: String, waitTime: TimeInterval = 10)
func waitUntilElementAppears(id: String, waitTime: TimeInterval = 10)
func waitUntilElementAppears(text: String, waitTime: TimeInterval = 10)
```
### Actions
```swift
func tap(id: String) -> GREYInteraction
func tap(text: String) -> GREYInteraction
func tap(aClass: AnyClass) -> GREYInteraction
```

#### Scroll view
```swift
// Search for element(s)
func searchDownward(id: String, onScrollViewId scrollId: String) -> GREYInteraction
func searchDownward(text: String, onScrollViewId scrollId: String) -> GREYInteraction
func searchUpward(text: String, onScrollViewId scrollId: String) -> GREYInteraction
func searchUpward(id: String, onScrollViewId scrollId: String) -> GREYInteraction
func searchRight(text: String, onScrollViewId scrollId: String) -> GREYInteraction
func searchLeft(text: String, onScrollViewId scrollId: String) -> GREYInteraction

// Just scroll
func scrollDown(scrollId: String, amount: CGFloat) -> GREYInteraction
func scrollUp(scrollId: String, amount: CGFloat) -> GREYInteraction
func scrollToBottom(scrollId: String) -> GREYInteraction
func scrollToTop(scrollId: String) -> GREYInteraction
```

### Extensions
```swift
extension GREYInteraction {

    /// Tap on the element. *Must know that there is one match!. You can use `.first()` to make sure there is one element.
    @discardableResult
    func tap() -> GREYInteraction {
        return perform(grey_tap())
    }
}
```

```swift
extension GREYInteraction {

    /// Select first element when there are multiple matches of elements.
    @discardableResult
    func first() -> GREYInteraction {
        return atIndex(0)
    }
}
```

***Feel free to open PRs!***
