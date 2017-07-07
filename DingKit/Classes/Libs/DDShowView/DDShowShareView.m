//
//  DDShowShareView.m
//  Pods
//
//  Created by duodian on 2017/7/4.
//
//

#import "DDShowShareView.h"
#define kDDShareWidth  57
#define kDDEachNum       4 //每行不要超过4个，

@implementation DDShowShareView

-(nullable instancetype)initWithDataArray:(nullable NSArray *)dataArray titleArray:(nullable NSArray *)titleArray delegate:(nullable id )delegate{
    self=[super initWithStyle:DDShowViewStyleShare];
    if (self) {
        self.delegate = delegate;
        self.dataArray = [dataArray mutableCopy];
        self.titleArray = [titleArray mutableCopy];
    }
    return self;
}

#pragma mark - 重写父类方法
-(void)configUIWithData{
    [super configUIWithData];
    CGFloat btnHeight = kDDShareWidth+13;
    CGFloat spaceWidth = (kDDScreenWidth_Show-kDDEachNum*kDDShareWidth)/(kDDEachNum+1);
    CGFloat spaceHeight = 20;
    self.contentHeight = spaceHeight+(self.dataArray.count/kDDEachNum+(self.dataArray.count%kDDEachNum?1:0))*(btnHeight+spaceHeight)+44;
    self.DD_cententView = [[UIView alloc]initWithFrame:CGRectMake(0, kDDScreenHeight_Show-self.contentHeight, kDDScreenWidth_Show, self.contentHeight)];
    self.DD_cententView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.DD_cententView];
    
    self.DD_cententView.layer.cornerRadius = 8;
    self.DD_cententView.clipsToBounds = YES;
    
    [self.DD_cententView.layer addAnimation:[DDShowShareView dd_transitionAnimationWithSubType:kCATransitionFromTop withType:kCATransitionPush duration:0.3f] forKey:@"animation"];
    
    for (int i = 0; i <self.dataArray.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(spaceWidth+(i%kDDEachNum)*(kDDShareWidth+spaceWidth), spaceHeight+(i/kDDEachNum)*(btnHeight+spaceHeight), kDDShareWidth, btnHeight)];
        btn.tag = 100+i;
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 13, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(kDDShareWidth+10, -1*kDDShareWidth, 0, 0);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:self.dataArray[i]] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.DD_cententView addSubview:btn];
    }
    
    UIButton *cancelBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelBtn setFrame:CGRectMake(0, self.contentHeight-45, kDDScreenWidth_Show, 45)];
    cancelBtn.backgroundColor=[UIColor colorWithWhite:0.8 alpha:1];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(removeSelfView) forControlEvents:UIControlEventTouchUpInside];
    [self.DD_cententView addSubview:cancelBtn];
}

-(void)removeSelfView{
    [super removeSelfView];
    [self.DD_cententView setFrame:CGRectMake(0, kDDScreenHeight_Show, kDDScreenWidth_Show, self.contentHeight)];
    [self.DD_cententView.layer addAnimation:[DDShowShareView dd_transitionAnimationWithSubType:kCATransitionFromBottom withType:kCATransitionPush duration:0.3f] forKey:@"animation"];
}


@end
