//
//  ToastView.m
//  iTrends
//
//  Created by njguo.
//
//  模仿android的toast，弹出一个信息提示框

#import "ToastView.h"
#import <QuartzCore/QuartzCore.h>
//#import "AppDelegate.h"

@implementation ToastView

-(id)initWithFrame:(CGRect)frame Icon:(ToastViewIcon)icon Title:(NSString*)title Delay:(float)delay;
{
    CGRect screenBounds = [UIScreen mainScreen].bounds;

    if (icon==ToastViewIconSusess||icon==ToastViewIconError) {
        frameT=CGRectMake((screenBounds.size.width-210)/2, (screenBounds.size.height-60)/2, 210, 60);
    }else{
        frameT=CGRectMake((screenBounds.size.width-130)/2, (screenBounds.size.height-130)/2, 130, 130);
    }
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        
        UIView *bg=[[UIView alloc] initWithFrame:CGRectMake(0, 0, frameT.size.width, frameT.size.height)];
        bg.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8];
        bg.layer.cornerRadius=10;
         bg.center = self.center;
        bg.layer.masksToBounds=YES;
        [self addSubview:bg];
        
        lbText=[[UILabel alloc] init];
        lbText.frame=CGRectMake(0, 0, frameT.size.width, frameT.size.height);
        lbText.center = self.center;
        lbText.textAlignment=NSTextAlignmentCenter;
        lbText.font=[UIFont systemFontOfSize:16.0];
        lbText.text=title;
        lbText.backgroundColor=[UIColor clearColor];
        lbText.textColor=[UIColor whiteColor];
        [self addSubview:lbText];
        
        
        self.disappearBlock=nil;
        if (delay<=100) {
            [self performSelector:@selector(remove) withObject:nil afterDelay:delay];
        }
        
    }
    return self;
}
+(id)ToastViewWithFrame:(CGRect)frame Icon:(ToastViewIcon)icon Title:(NSString *)title Delay:(float)delay
{
//    [self performSelector:@selector(remove) withObject:nil afterDelay:delay];

    return [[ToastView alloc] initWithFrame:frame Icon:icon Title:title Delay:delay];
}
+(void)ToastViewWithIcon:(ToastViewIcon)icon Title:(NSString *)title
{
    CGRect rectT = [UIScreen mainScreen].bounds;
    ToastView *toast=[ToastView ToastViewWithFrame:rectT Icon:icon Title:title Delay:1.5f];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue=[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue=[NSNumber numberWithFloat:0];
    opacityAnimation.toValue  = [NSNumber numberWithFloat:1];
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects: scaleAnimation, opacityAnimation, nil];
    animationgroup.duration = 0.2f;
    animationgroup.fillMode = kCAFillModeForwards;
    animationgroup.removedOnCompletion=YES;
    
    
    if ([[UIApplication sharedApplication].keyWindow viewWithTag:kToastViewTag]!=nil) {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:kToastViewTag] removeFromSuperview];
    }else{
        [toast.layer addAnimation:animationgroup forKey:@"zoomin"];
    }
    toast.tag = kToastViewTag;
    [[UIApplication sharedApplication].keyWindow addSubview:toast];
}
+(id)ToastViewWithFrame2:(CGRect)frame Icon:(ToastViewIcon)icon Title:(NSString *)title Delay:(int)delay
{
//    [self performSelector:@selector(remove) withObject:nil afterDelay:delay];
    
    return [[ToastView alloc] initWithFrame:frame Icon:icon Title:title Delay:delay] ;
}
+(id)ToastViewWithIcon2:(ToastViewIcon)icon Title:(NSString *)title
{
    CGRect rectT = [UIScreen mainScreen].bounds;
    ToastView *toast=[ToastView ToastViewWithFrame2:rectT Icon:icon Title:title Delay:120];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue=[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue=[NSNumber numberWithFloat:0];
    opacityAnimation.toValue  = [NSNumber numberWithFloat:1];
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects: scaleAnimation, opacityAnimation, nil];
    animationgroup.duration = 0.2f;
    animationgroup.fillMode = kCAFillModeForwards;
    animationgroup.removedOnCompletion=YES;
    
    
    if ([[UIApplication sharedApplication].keyWindow viewWithTag:kToastViewTag]!=nil) {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:kToastViewTag] removeFromSuperview];
    }else{
        [toast.layer addAnimation:animationgroup forKey:@"zoomin"];
    }
    toast.tag = kToastViewTag;
    [[UIApplication sharedApplication].keyWindow addSubview:toast];
    return toast;
}



-(void)remove
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(remove) object:nil];
    
    if (self.superview!=nil) {
        [UIView animateWithDuration:.2 animations:^{
            self.alpha=.01;
        }completion:^(BOOL finished){
            if (self.disappearBlock!=nil) {
                _disappearBlock();
            }
            self.disappearBlock=nil;
            [self removeFromSuperview];
        }];
    }
}


///* Called when the animation either completes its active duration or
// * is removed from the object it is attached to (i.e. the layer). 'flag'
// * is true if the animation reached the end of its active duration
// * without being removed. */
//
//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
//{
////    self.alpha=0.01;
//    if (self.disappearBlock!=nil) {
//        _disappearBlock();
//    }
//    self.disappearBlock=nil;
////    [self removeFromSuperview];
//
//}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end

