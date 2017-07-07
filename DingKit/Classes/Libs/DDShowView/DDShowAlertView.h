//
//  DDShowAlertView.h
//  Pods
//
//  Created by duodian on 2017/7/4.
//
//

#import "DDShowView.h"

@interface DDShowAlertView : DDShowView
@property(nonatomic,strong,nullable)NSMutableArray<UIButton *> *buttonArray;
@property(nonatomic,strong,nullable)NSMutableArray<UITextField *> *textFiledArray;

- (nullable instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id )delegate otherButtonTitles:(nullable NSArray *)otherButtonTitles;
- (void)addButtonTitle:(nullable NSString *)buttonTitle;
@end
