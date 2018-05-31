//
//  EarlGrey+Convenience.swift
//
//  Created by Wirawit Rueopas on 28/5/18.
//  Copyright © 2018 Oozou. All rights reserved.
//

import EarlGrey
import Salsa
import XCTest


// MARK:- Selectors
func keyWindow() -> UIWindow {
    return UIApplication.shared.keyWindow!
}

/// Find visible, interactable element with accessibility id.
@discardableResult
func element(id: String) -> GREYInteraction {
    return EarlGrey.selectElement(with: grey_allOf([
            grey_accessibilityID(id),
            grey_sufficientlyVisible(),
            grey_interactable()
        ]))
}

/// Find visible, interactable element with text.
@discardableResult
func element(text: String) -> GREYInteraction {
    return EarlGrey.selectElement(with: grey_allOf([
        grey_text(text),
        grey_sufficientlyVisible(),
        grey_interactable()
        ]))
}

/// Find visible, interactable button with title.
@discardableResult
func button(title: String) -> GREYInteraction {
    return EarlGrey.selectElement(with: grey_allOf([
        grey_buttonTitle(title),
        grey_sufficientlyVisible(),
        grey_interactable()
        ]))
}

/// Find visible, interactable element with class.
@discardableResult
func element(aClass: AnyClass) -> GREYInteraction {
    return EarlGrey.selectElement(with: grey_allOf([
        grey_kindOfClass(aClass),
        grey_sufficientlyVisible(),
        grey_interactable()
        ]))
}

@discardableResult
func navigationBackButton() -> GREYInteraction {
    return EarlGrey.selectElement(with: grey_allOf([
        grey_accessibilityLabel("@Back"),
        grey_accessibilityTrait(UIAccessibilityTraitButton)
        ]))
}

// MARK:- Assertions

/// Wait until an element is gone.
func waitUntilElementIsGone(id: String, waitTime: TimeInterval = 10) {
    let condition = GREYCondition(name: "Wait until id: `\(id)` is gone.") { () -> Bool in
        var err: NSError?
        element(id: id).assert(grey_notVisible(), error: &err)
        return err == nil
    }
    let success = condition.waitWithTimeout(seconds: waitTime)
    if !success {
        XCTFail("Fail to wait for element with id: `\(id)` to disappear.")
    }
}

/// Wait until a text is gone.
func waitUntilElementIsGone(text: String, waitTime: TimeInterval = 10) {
    let condition = GREYCondition(name: "Wait until text: `\(text)` is gone.") { () -> Bool in
        var err: NSError?
        element(text: text).assert(grey_notVisible(), error: &err)
        return err == nil
    }
    let success = condition.waitWithTimeout(seconds: waitTime)
    if !success {
        XCTFail("Fail to wait for element with text: `\(text)` to disappear.")
    }
}

/// Wait until an element with text appears.
func waitUntilElementAppears(id: String, waitTime: TimeInterval = 10) {
    let condition = GREYCondition(name: "Wait until id: `\(id)` appears.") { () -> Bool in
        var err: NSError?
        element(id: id).assert(grey_sufficientlyVisible(), error: &err)
        return err == nil
    }
    let success = condition.waitWithTimeout(seconds: waitTime)
    if !success {
        XCTFail("Fail to wait for element with id: \(id) to appear.")
    }
}

/// Wait until an element with text appears.
func waitUntilElementAppears(text: String, waitTime: TimeInterval = 10) {
    let condition = GREYCondition(name: "Wait until text: `\(text)` appears.") { () -> Bool in
        var err: NSError?
        element(text: text).assert(grey_sufficientlyVisible(), error: &err)
        return err == nil
    }
    let success = condition.waitWithTimeout(seconds: waitTime)
    if !success {
        XCTFail("Fail to wait for element with text: \(text) to appear.")
    }
}


/// Assert that key window is visible. Call this at the start of the unit test session.
func makeSureKeyWindowVisible() {
    EarlGrey.selectElement(with: grey_keyWindow()).assert(grey_sufficientlyVisible())
}

// MARK:- Actions

/// Tap element with accessbiilty id.
@discardableResult
func tap(id: String) -> GREYInteraction {
    return element(id: id).tap()
}

/// Tap element with text.
@discardableResult
func tap(text: String) -> GREYInteraction {
    return element(text: text).tap()
}

/// Tap element with class.
func tap(aClass: AnyClass) -> GREYInteraction {
    return element(aClass: aClass).tap()
}

/// Search for an element with accessbility id in a scroll view with `scrollId`, downward (scroll down, finger up).
@discardableResult
func searchDownward(id: String, onScrollViewId scrollId: String) -> GREYInteraction {
    return element(id: id)
        .using(searchAction: grey_scrollInDirectionWithStartPoint(.down, 300, 0.5, 0.5),
               onElementWithMatcher: grey_accessibilityID(scrollId))
}

/// Search for an element with `text` in a scroll view with `scrollId`, downward (scroll down, finger up).
@discardableResult
func searchDownward(text: String, onScrollViewId scrollId: String) -> GREYInteraction {
    return element(text: text)
        .using(searchAction: grey_scrollInDirectionWithStartPoint(.down, 300, 0.5, 0.5),
               onElementWithMatcher: grey_accessibilityID(scrollId))
}

/// Search for an element with accessbility id in a scroll view with `scrollId`, on the right (scroll right, finger to the left).
@discardableResult
func searchRight(text: String, onScrollViewId scrollId: String) -> GREYInteraction {
    return element(text: text)
        .using(searchAction: grey_scrollInDirectionWithStartPoint(.right, 300, 0.5, 0.5),
               onElementWithMatcher: grey_accessibilityID(scrollId))
}

@discardableResult
func searchLeft(text: String, onScrollViewId scrollId: String) -> GREYInteraction {
    return EarlGrey
        .selectElement(with: grey_allOf([
            grey_text(text),
            grey_interactable(),
            grey_sufficientlyVisible()]))
        .using(searchAction: grey_scrollInDirectionWithStartPoint(.left, 300, 0.5, 0.5),
               onElementWithMatcher: grey_accessibilityID(scrollId))
}

@discardableResult
func scrollDown(scrollId: String, amount: CGFloat) -> GREYInteraction {
    return EarlGrey.selectElement(with: grey_accessibilityID(scrollId))
        .perform(grey_scrollInDirectionWithStartPoint(.down, amount, 0.5, 0.5))
}

@discardableResult
func scrollUp(scrollId: String, amount: CGFloat) -> GREYInteraction {
    return EarlGrey.selectElement(with: grey_accessibilityID(scrollId))
        .perform(grey_scrollInDirectionWithStartPoint(.up, amount, 0.5, 0.5))
}

@discardableResult
func scrollToBottom(scrollId: String) -> GREYInteraction {
    return EarlGrey.selectElement(with: grey_accessibilityID(scrollId))
        .perform(grey_scrollToContentEdge(.bottom))
}

@discardableResult
func scrollToTop(scrollId: String) -> GREYInteraction {
    return EarlGrey.selectElement(with: grey_accessibilityID(scrollId))
        .perform(grey_scrollToContentEdge(.top))
}

extension GREYInteraction {

    /// Tap on the element. *Must know that there is one match!. You can use `.first()` to make sure there is one element.
    @discardableResult
    func tap() -> GREYInteraction {
        return perform(grey_tap())
    }
}

// MARK: - Filtering
extension GREYInteraction {

    /// Select first element when there are multiple matches of elements.
    @discardableResult
    func first() -> GREYInteraction {
        return atIndex(0)
    }

    /// Select first element when there are multiple matches of elements.
    @discardableResult
    func index(_ ind: UInt) -> GREYInteraction {
        return atIndex(ind)
    }
}
