//
//  DDShowAlertView.m
//  Pods
//
//  Created by duodian on 2017/7/4.
//
//

#import "DDShowAlertView.h"
@interface DDShowAlertView ()
@property(nonatomic,strong)NSMutableArray *buttonTitleArray;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *message;
@end

@implementation DDShowAlertView
-(nullable instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id )delegate otherButtonTitles:(nullable NSArray *)otherButtonTitles {
    self = [super initWithStyle:DDShowViewStyleAlert];
    if (self) {
        self.delegate = delegate;
        [self.buttonTitleArray addObjectsFromArray:otherButtonTitles];
        self.title = title;
        self.message = message;
    }
    return self;
}

-(void)addButtonTitle:(nullable NSString *)buttonTitle {
    [self.buttonTitleArray addObject:buttonTitle];
}

#pragma mark - get set
-(NSMutableArray *)buttonArray{
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _buttonArray;
}

-(NSMutableArray *)buttonTitleArray{
    if (_buttonTitleArray == nil) {
        _buttonTitleArray = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _buttonTitleArray;
}

-(NSMutableArray *)textFiledArray{
    if (_textFiledArray == nil) {
        _textFiledArray = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _textFiledArray;
}
#pragma mark - 重写父类方法
-(void)configUIWithData{
    [super configUIWithData];
    
    CGFloat contentWidth = kDDScreenWidth_Show*0.7;
    
    self.DD_cententView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, contentWidth, kDDScreenWidth_Show*0.4)];
    self.DD_cententView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.DD_cententView];
    
    self.DD_cententView.layer.cornerRadius = 8;
    self.DD_cententView.clipsToBounds = YES;
    
    self.contentHeight = 5;
    if (self.title) {
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, contentWidth, 21)];
        titleLabel.text=self.title;
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.font=[UIFont boldSystemFontOfSize:17];
        [self.DD_cententView addSubview:titleLabel];
        self.contentHeight+=21;
    }
    if (self.message) {
        CGSize size = [DDShowAlertView currentSizeWithContent:self.message attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor]} cgSize:CGSizeMake(contentWidth-20, 10000)];
        UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.contentHeight+5, contentWidth-20, size.height)];
        messageLabel.text = self.message;
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont systemFontOfSize:13];
        [self.DD_cententView addSubview:messageLabel];
        self.contentHeight+=(size.height+10);
    }
    
    if (self.buttonTitleArray.count) {
        if (self.buttonTitleArray.count==1) {
            UIButton *btn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn1.frame=CGRectMake(0, self.contentHeight+5, contentWidth, 44);
            [btn1 setTitle:self.buttonTitleArray[0] forState:UIControlStateNormal];
            btn1.titleLabel.font=[UIFont boldSystemFontOfSize:17];
            btn1.layer.borderWidth=0.5;
            [btn1 addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn1.tag=100;
            btn1.layer.borderColor=[UIColor colorWithWhite:0.7 alpha:1].CGColor;
            [self.DD_cententView addSubview:btn1];
            self.contentHeight+=49;
        }else if(self.buttonTitleArray.count == 2){
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn1.frame=CGRectMake(0, self.contentHeight+5, contentWidth/2, 44);
            [btn1 setTitle:self.buttonTitleArray[0] forState:UIControlStateNormal];
            btn1.titleLabel.font=[UIFont boldSystemFontOfSize:17];
            btn1.layer.borderWidth=0.5;
            [btn1 addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn1.tag=100;
            btn1.layer.borderColor=[UIColor colorWithWhite:0.7 alpha:1].CGColor;
            [self.DD_cententView addSubview:btn1];
            UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn2.frame=CGRectMake(contentWidth/2-0.5, self.contentHeight+5, contentWidth/2+1, 44);
            [btn2 setTitle:self.buttonTitleArray[1] forState:UIControlStateNormal];
            btn2.titleLabel.font=[UIFont boldSystemFontOfSize:17];
            btn2.layer.borderWidth=0.5;
            [btn2 addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn2.tag=101;
            btn2.layer.borderColor=[UIColor colorWithWhite:0.7 alpha:1].CGColor;
            [self.DD_cententView addSubview:btn2];
            self.contentHeight+=49;
        }else if(self.buttonTitleArray.count>2){
            
        }
    }
    self.DD_cententView.frame=CGRectMake(0, 0, contentWidth, self.contentHeight);
    self.DD_cententView.center=self.center;
}

- (void)removeSelfView{
    [super removeSelfView];
    self.DD_cententView.alpha = 0;
    [self.DD_cententView.layer addAnimation:[DDShowAlertView dd_transitionAnimationWithSubType:kCATransitionFromTop withType:kCATransitionFade duration:0.3f] forKey:@"animation"];
}
@end
