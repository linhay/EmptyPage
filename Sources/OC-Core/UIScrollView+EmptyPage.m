//
//  UIScrollView+EmptyPage.m
//  EmptyPage
//
//  Created by linhey on 2019/1/20.
//

#import "UIScrollView+EmptyPage.h"
#import <objc/runtime.h>

@interface UIScrollView ()

@property(nonatomic,strong) UIView* oldEmptyView;

@end

static NSString *kEmptyViewKey = @"EmptyPage.UIScrollView.emptyView";
static NSString *kOldEmptyViewKey = @"EmptyPage.UIScrollView.OldEmptyViewKey";

@implementation UIScrollView (EmptyPage)


- (void)setEmptyView:(UIView *)emptyView {
  objc_setAssociatedObject(self, &kEmptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)emptyView {
  return objc_getAssociatedObject(self, &kEmptyViewKey);
}

- (void)setOldEmptyView:(UIView *)oldEmptyView {
  if (oldEmptyView.superview == NULL) return;
  objc_setAssociatedObject(self, &kOldEmptyViewKey, oldEmptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)oldEmptyView {
  return objc_getAssociatedObject(self, &kOldEmptyViewKey);
}

@end
