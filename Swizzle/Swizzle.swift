//
//  Swizzle.swift
//  Swizzle
//
//  Created by Yasuhiro Inami on 2014/09/14.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

import ObjectiveC

internal func swizzleMethodOf(var class_: AnyClass!, replace selector1: Selector, by selector2: Selector, isClassMethod isClassMethod: Bool) {
    if isClassMethod {
        class_ = object_getClass(class_)
    }

    let method1: Method = class_getInstanceMethod(class_, selector1)
    let method2: Method = class_getInstanceMethod(class_, selector2)

    if class_addMethod(class_, selector1, method_getImplementation(method2), method_getTypeEncoding(method2)) {
        class_replaceMethod(class_, selector2, method_getImplementation(method1), method_getTypeEncoding(method1))
    } else {
        method_exchangeImplementations(method1, method2)
    }
}

internal func addMethodFrom(var class1: AnyClass!, selector: Selector, var toClass class2: AnyClass!, isClassMethod: Bool, replace: Bool) -> Bool {
    if isClassMethod {
        class1 = object_getClass(class1)
        class2 = object_getClass(class2)
    }
    
    let method: Method = class_getInstanceMethod(class1, selector)
    
    let didAddMethod = class_addMethod(class2, selector, method_getImplementation(method), method_getTypeEncoding(method))
    if !didAddMethod && replace {
        class_replaceMethod(class2, selector, method_getImplementation(method), method_getTypeEncoding(method))
        return true
    } else {
        return didAddMethod
    }
}

public func swizzleInstanceMethod(var class_: AnyClass!, sel1: Selector, sel2: Selector) {
    swizzleMethodOf(class_, replace: sel1, by: sel2, isClassMethod: false)
}

public func swizzleClassMethod(var class_: AnyClass!, sel1: Selector, sel2: Selector) {
    swizzleMethodOf(class_, replace: sel1, by: sel2, isClassMethod: true)
}

public func addInstanceMethod(var class1: AnyClass!, selector: Selector, var toClass class2: AnyClass!, replace: Bool = false) -> Bool {
    return addMethodFrom(class1, selector: selector, toClass: class2, isClassMethod: false, replace: replace)
}

public func addClassMethod(var class1: AnyClass!, selector: Selector, var toClass class2: AnyClass!, replace: Bool = false) -> Bool {
    return addMethodFrom(class1, selector: selector, toClass: class2, isClassMethod: true, replace: replace)
}

//--------------------------------------------------
// MARK: - Custom Operators
// + - * / % = < > ! & | ^ ~ .
//--------------------------------------------------

infix operator <-> { associativity left }

/// Usage: (MyObject.self, "hello") <-> "bye"
public func <-> (tuple: (class_: AnyClass!, selector1: Selector), selector2: Selector) {
    swizzleInstanceMethod(tuple.class_, sel1: tuple.selector1, sel2: selector2)
}

infix operator <+> { associativity left }

/// Usage: (MyObject.self, "hello") <+> "bye"
public func <+> (tuple: (class_: AnyClass!, selector1: Selector), selector2: Selector) {
    swizzleClassMethod(tuple.class_, sel1: tuple.selector1, sel2: selector2)
}
