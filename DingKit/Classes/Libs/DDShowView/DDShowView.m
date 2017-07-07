//
//  DDShowView.m
//  Pods
//
//  Created by duodian on 2017/7/4.
//
//

#import "DDShowView.h"
@interface DDShowView ()
@property(nonatomic,strong)UIView *blackAlphaView;//背景view
@end

@implementation DDShowView
#pragma mark - 初始化
- (instancetype)initWithStyle:(DDShowViewStyle)style{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kDDScreenWidth_Show, kDDScreenHeight_Show);
        self.backgroundColor =  [UIColor clearColor];
        self.showViewStyle = style;
        self.blackAlpha = 0.5;
    }
    return self;
}

-(void)configUIWithData{
    self.blackAlphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDDScreenWidth_Show, kDDScreenHeight_Show)];
    self.blackAlphaView.backgroundColor = [UIColor blackColor];
    self.blackAlphaView.clipsToBounds = YES;
    self.blackAlphaView.alpha = self.blackAlpha;
    [self.blackAlphaView.layer addAnimation:[DDShowView dd_transitionAnimationWithSubType:kCATransitionFromBottom withType:kCATransitionFade duration:0.3f] forKey:@"alpha.animation"];
    [self addSubview:self.blackAlphaView];
}

-(void)refreshUIWithData:(id)data{
    
}

-(void)show{
    [self configUIWithData];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

#pragma mark - 点击事件
-(void)shareBtnClick:(UIButton*)btn{
    [self showViewDidSeletedIndex:btn.tag-100];
}

-(void)showViewDidSeletedIndex:(NSInteger)seletedIndex{
    if ([_delegate respondsToSelector:@selector(ddShowView:buttonIndex:viewStyle:)]) {
        [_delegate ddShowView:self buttonIndex:seletedIndex viewStyle:self.showViewStyle];
    }
    self.delegate = nil;
    [self removeSelfView];
}

#pragma mark - 移除View
-(void)removeSelfView{
    [self.DD_cententView.layer removeAllAnimations];
    self.blackAlphaView.alpha = 0;
    [self.blackAlphaView.layer addAnimation:[DDShowView dd_transitionAnimationWithSubType:nil withType:nil duration:0.3] forKey:@"alpha.animation.no"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3f];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.isTouchRemove) {
        CGPoint touchPoint = [[touches anyObject]locationInView:self];
        if (touchPoint.y < self.DD_cententView.frame.origin.y||touchPoint.x<self.DD_cententView.frame.origin.x||touchPoint.y>self.DD_cententView.frame.origin.y+self.DD_cententView.frame.size.height||touchPoint.x>self.DD_cententView.frame.origin.x+self.DD_cententView.frame.size.width) {
            [self removeSelfView];
        }
    }
}

#pragma mark - get set

-(void)dealloc{
    NSLog(@"%s",__func__);
}


//NSDictionary *attributes=@{NSFontAttributeName:self.textFont,NSForegroundColorAttributeName:[UIColor redColor]};

/** 根据换行方式和字体的大小，已经计算的范围来确定字符串的size */
+(CGSize)currentSizeWithContent:(NSString *)content attributes:(NSDictionary *)attributes cgSize:(CGSize)cgsize{
    //    CGFloat version=[[UIDevice currentDevice].systemVersion floatValue];
    CGSize size;
    //计算size， 7之后有新的方法
    size=[content boundingRectWithSize:cgsize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    //    if (version>=7.0) {
    //        //得到一个设置字体属性的字典
    //        //        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    //        //optinos 前两个参数是匹配换行方式去计算，最后一个参数是匹配字体去计算
    //        //attributes 传入的字体
    //        //boundingRectWithSize 计算的范围
    //        size=[content boundingRectWithSize:cgsize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    //    }else{
    //        //ios7以前
    //        //根据字号和限定范围还有换行方式计算字符串的size，label中的font 和linbreak要与此一致
    //        //CGSizeMake(215, 999) 横向最大计算到215，纵向Max999
    //        size=[content sizeWithFont:[attributes objectForKey:NSFontAttributeName] constrainedToSize:cgsize lineBreakMode:NSLineBreakByCharWrapping];
    //    }
    return size;
}

#pragma mark - CATransition基本动画
/**动画切换页面的效果(CATransition)
 *subType 方向 kCATransitionFromBottom ....
 *subtypes: kCAAnimationCubic迅速透明移动,cube 3D立方体翻页 pageCurl从一个角翻页，
 *          pageUnCurl反翻页，rippleEffect水波效果，suckEffect缩放到一个角,oglFlip中心立体翻转
 *          (kCATransitionFade淡出，kCATransitionMoveIn覆盖原图，kCATransitionPush推出，kCATransitionReveal卷轴效果)
 */
+(CATransition *)dd_transitionAnimationWithSubType:(NSString *)subType withType:(NSString *)xiaoguo duration:(CGFloat)duration
{
    CATransition *animation = [CATransition animation];
    //立体翻转的效果cube ,rippleEffect,(水波）
    [animation setType:xiaoguo];
    //设置动画方向
    [animation setSubtype:subType];
    //设置动画的动作时长
    [animation setDuration:duration];
    //均匀的作用效果
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    return animation;
}

@end
