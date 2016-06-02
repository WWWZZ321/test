//
//  RootViewController.m
//  yuefan
//
//  Created by dtdxunlei on 15/11/5.
//  Copyright © 2015年 dtdxunlei. All rights reserved.
//

#import "RootViewController.h"
@interface RootViewController ()
//@property (nonatomic, weak) UIView *backView;
//@property(nonatomic,weak)UIView *backViewState;
@end

@implementation RootViewController{
   // enum WXScene wxscene;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    //[self.navigationController setNavigationBarHidden:YES];
    self.automaticallyAdjustsScrollViewInsets =NO;

}
/**
 *
 *设置页面title图片
 */
- (void)addTitleImageWithName:(NSString *)name
{

    UIImageView *title = [[UIImageView alloc]initWithImage:[UIImage imageNamed:name]];
    self.navigationItem.titleView = title;
}
//设置titleView
-(void)addTitleViewWithTitle:(NSString *)title
{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100,0,100,30)];
//    label.backgroundColor = [UIColor clearColor];
//    label.text = title;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = ViewColor(90, 90, 90, 1);

    NSDictionary *att = @{
                          NSFontAttributeName:[UIFont systemFontOfSize:17],
                          NSForegroundColorAttributeName:ViewColor(51, 3, 0, 1)
                          };
    [self.navigationController.navigationBar setTitleTextAttributes:att];
    self.navigationItem.title  = title;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    // UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(void)setbackBtn:(NSString*)str{
    
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 20, 60, 40)];
//    self.backView = view;
//    view.backgroundColor = [UIColor redColor];
//    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 13, 8, 15)];
//    im.image = [UIImage imageNamed:@"backbutton"];
//    [view addSubview:im];
    UIButton *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
   // backbtn.backgroundColor = [UIColor redColor];
//    backbtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [backbtn setTitle:str forState:UIControlStateNormal];
//    [backbtn setTitleColor:ViewColor(81, 81, 81, 1) forState:UIControlStateNormal];
   [backbtn setImage:[UIImage imageNamed:@"Resouce.bundle/返回button"] forState:UIControlStateNormal];
    backbtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//    backbtn.backgroundColor = [UIColor orangeColor];
    [backbtn addTarget:self action:@selector(Rootback) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:backbtn];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:view];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -12;//这个数值可以根据情况自由变化
//    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:backbtn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, btn];
//    self.navigationItem.leftBarButtonItem = btn;
}




- (NSData *)Dictionary2DataWithDict:(NSDictionary *)object
{
    NSError *error;
    NSData *data = nil;
    if (object) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                           options:kNilOptions // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            //jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            data = jsonData;
        }
    }
    //    object JSONDataWithOptions:<#(JKSerializeOptionFlags)#> error:<#(NSError *__autoreleasing *)#>
    return data;
}





-(void)Rootback{
    [self.navigationController popViewControllerAnimated:YES];
}



//- (NSString *)md5:(NSString *)str
//{
//    const char *cStr = [str UTF8String];
//    unsigned char result[16];
//    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
//    return [NSString stringWithFormat:
//            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//            result[0], result[1], result[2], result[3],
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15]
//            ]; 
//}

//- (void)hideBackBtn{
//    
//    self.backView.hidden = YES;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
