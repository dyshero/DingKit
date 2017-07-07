//
//  DDShowView.h
//  Pods
//
//  Created by duodian on 2017/7/4.
//
//

#import <UIKit/UIKit.h>

//屏幕宽
#define kDDScreenWidth_Show ([UIScreen mainScreen].bounds.size.width)
//屏幕高
#define kDDScreenHeight_Show ([UIScreen mainScreen].bounds.size.height)
/**
 *  显示风格
 */
typedef NS_ENUM(NSInteger,DDShowViewStyle) {
    /**
     *  none
     */
    DDShowViewStyleNone = 1,
    /**
     *  alert
     */
    DDShowViewStyleAlert,
    /**
     *  actionSheet
     */
    DDShowViewStyleActionSheet,
    /**
     *  底部分享
     */
    DDShowViewStyleShare
};

@class DDShowView;
@protocol DDShowViewDelegate <NSObject>
@optional
-(void)ddShowView:(DDShowView *)showView buttonIndex:(NSInteger)buttonIndex viewStyle:(DDShowViewStyle)viewStyle;
@end

@interface DDShowView : UIView
/** 内容View*/
@property(nonatomic,strong)UIView *DD_cententView;
/**黑色背景透明度 默认0.5  default translucent(0.5)*/
@property(nonatomic,assign)CGFloat blackAlpha;//不要设置为>0.1，不立即释放

@property(nonatomic,assign)DDShowViewStyle showViewStyle;

@property(nonatomic,weak)id delegate;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)CGFloat contentHeight;
/**是不是触摸其他区域，自动消失*/
@property(nonatomic,assign)BOOL isTouchRemove;

#pragma mark - 外部调用方法
-(instancetype)initWithStyle:(DDShowViewStyle)style;
-(void)show;

#pragma mark - 一般内部调用方法（或子类重写）
-(void)configUIWithData;//创建UI,需要重写
-(void)removeSelfView;//移除View，可以加动画移除
-(void)refreshUIWithData:(id)data;//暂时没有用（空方法）
-(void)showViewDidSeletedIndex:(NSInteger)seletedIndex;//用来选中按钮回调
-(void)shareBtnClick:(UIButton *)btn;//按钮单击事件，tag-100
#pragma mark - 辅助方法
/** 根据换行方式和字体的大小，已经计算的范围来确定字符串的size */
+(CGSize)currentSizeWithContent:(NSString *)content attributes:(NSDictionary *)attributes cgSize:(CGSize)cgsize;
/**动画切换页面的效果(CATransition)
 *subType 方向 kCATransitionFromBottom ....
 *subtypes: kCAAnimationCubic迅速透明移动,cube 3D立方体翻页 pageCurl从一个角翻页，
 *          pageUnCurl反翻页，rippleEffect水波效果，suckEffect缩放到一个角,oglFlip中心立体翻转
 *          (kCATransitionFade淡出，kCATransitionMoveIn覆盖原图，kCATransitionPush推出，kCATransitionReveal卷轴效果)
 */
+(CATransition *)dd_transitionAnimationWithSubType:(NSString *)subType withType:(NSString *)xiaoguo duration:(CGFloat)duration;
@end
