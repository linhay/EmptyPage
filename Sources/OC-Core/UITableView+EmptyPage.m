//
//  UITableView+EmptyPage.m
//  EmptyPage
//
//  Created by linhey on 2019/1/21.
//

#import "UITableView+EmptyPage.h"
#import <objc/runtime.h>

@implementation UITableView (EmptyPage)



+ (void)initialize {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self swizzing: @selector(layoutSubviews)
                of: @selector(emptyPage_layoutSubviews)
     in: [UITableView class]];
    [self swizzing: @selector(layoutIfNeeded)
                of: @selector(emptyPage_layoutIfNeeded)
     in: [UITableView class]];
    [self swizzing: @selector(insertRowsAtIndexPaths:withRowAnimation:)
                of: @selector(emptyPage_insertRowsAtIndexPaths:withRowAnimation:)
     in: [UITableView class]];
    [self swizzing: @selector(deleteRowsAtIndexPaths:withRowAnimation:)
                of: @selector(emptyPage_deleteRowsAtIndexPaths:withRowAnimation:)
     in: [UITableView class]];
    [self swizzing: @selector(insertSections:withRowAnimation:)
                of: @selector(emptyPage_insertSections:withRowAnimation:)
     in: [UITableView class]];
    [self swizzing: @selector(deleteSections:withRowAnimation:)
                of: @selector(emptyPage_deleteSections:withRowAnimation:)
     in: [UITableView class]];
    [self swizzing: @selector(reloadData)
                of: @selector(emptyPage_reloadData)
     in: [UITableView class]];
  });
}


- (void)emptyPage_layoutSubviews {
  [self emptyPage_layoutSubviews];
}

- (void)emptyPage_reloadData {
  
}


- (void)setEmptyView:^(void)block {

  
}

+ (void) swizzing: (SEL) selector of: (SEL) anSelector in: (Class) classType {
  Method select1Method = class_getClassMethod(classType, selector);
  Method select2Method = class_getClassMethod(classType, anSelector);
  BOOL didAddMethod = class_addMethod(classType, selector, method_getImplementation(select2Method), method_getTypeEncoding(select2Method));
  if (didAddMethod) {
    class_replaceMethod(classType, anSelector, method_getImplementation(select1Method), method_getTypeEncoding(select1Method));
  } else {
    method_exchangeImplementations(select1Method, select2Method);
  }
}


@end
