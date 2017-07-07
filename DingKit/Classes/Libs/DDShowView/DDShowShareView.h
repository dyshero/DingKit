//
//  DDShowShareView.h
//  Pods
//
//  Created by duodian on 2017/7/4.
//
//

#import "DDShowView.h"

@interface DDShowShareView : DDShowView
@property(nonatomic,strong,nullable)NSMutableArray *titleArray;

-(nullable instancetype)initWithDataArray:(nullable NSArray *)dataArray titleArray:(nullable NSArray *)titleArray delegate:(nullable id )delegate;

@end
