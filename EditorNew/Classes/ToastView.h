//
//  ToastView.h

//
//  Created by njguo.
//
//

//弹出框
#import <UIKit/UIKit.h>

#define ToastView_Error(title) [ToastView ToastViewWithIcon:ToastViewIconError Title:title]

#define ToastView_Susess(title) [ToastView ToastViewWithIcon:ToastViewIconSusess Title:title]

#define ToastView_Like(title) [ToastView ToastViewWithIcon:ToastViewIconLike Title:title]


#define ToastView_ErrorA(type,title) [ToastView ToastViewWithIcon:ToastViewIconError Title:title]

#define ToastView_SusessA(type,title) [ToastView ToastViewWithIcon:ToastViewIconSusess Title:title]

#define ToastView_LikeA(type,title) [ToastView ToastViewWithIcon:ToastViewIconLike Title:title]

#define kToastViewTag 23525

typedef enum{
    ToastViewIconSusess,//成功的标
    ToastViewIconError,//失败的图标
    ToastViewIconLike//喜欢的图标
}ToastViewIcon;

typedef void(^DisappearBlock)();


@interface ToastView : UIView
{
    UILabel *lbText;
    CGRect  frameT;
}

@property (nonatomic,copy) DisappearBlock disappearBlock;

-(id)initWithFrame:(CGRect)frame Icon:(ToastViewIcon)icon Title:(NSString*)title Delay:(float)delay;

+(id)ToastViewWithFrame:(CGRect)frame Icon:(ToastViewIcon)icon Title:(NSString*)title Delay:(float)delay;

//+(id)ToastViewWithFrame:(CGRect)frame Icon:(ToastViewIcon)icon Title:(NSString *)title Delay:(int)delay andView:(UIView *)parentView;

+(void)ToastViewWithIcon:(ToastViewIcon )icon Title:(NSString*)title;
-(void)remove;
+(id)ToastViewWithIcon2:(ToastViewIcon)icon Title:(NSString *)title;
@end

