//
//  ViewController.m
//  yuefan
//
//  Created by zhangz on 15/11/12.
//  Copyright © 2015年 dtdxunlei. All rights reserved.
//

#import "EditViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ToastView.h"
#import "EditPublishCell.h"
#import "DisplayViewController.h"
#import "CamaraViewController.h"
//#import "RootTarBarViewController.h"
//#import "AppDelegate.h"
#import "MLSelectPhotoPickerViewController.h"
#import "MLSelectPhotoAssets.h"
#import "UIImage+GIF.h"
//#import "RequestManager.h"
#define cover 3
@interface EditViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)NSMutableArray *editArr;
@property(nonatomic,strong)NSMutableArray *peformArr;
@property(nonatomic,assign)BOOL isPreform;
@property(nonatomic,weak)NSIndexPath *path;
@property(nonatomic,weak)UIImageView *imgView;
@property(nonatomic ,weak)UIButton *creat;
@property(nonatomic,assign)CGFloat khight;
@property(nonatomic,assign)CGPoint point;
@property(nonatomic,assign)CGPoint curuntPoint;

@property(weak , nonatomic)UIView *blackView;
@property (weak , nonatomic)UIAlertView *clearAlert;
//jiancai VIew

@property(nonatomic ,assign)BOOL isShow;
@property(nonatomic ,weak )UISwitch *switchView;
@property (nonatomic, weak)UILabel *pLabel;

@property (nonatomic, strong)NSMutableArray *imageViews;
//@property (nonatomic ,strong)UIScrollView *sv;
//@property (nonatomic ,weak)UIView *chooseView;//相册选择图片底图

@property(nonatomic,weak)UIAlertView *alertTip;

@property(nonatomic,weak)UIView *rightView;

@end

@implementation EditViewController{
     UIImagePickerController *_photoPickerController;
}

- (NSMutableArray*)imageViews{
    if (_imageViews == nil) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.rightView.hidden = NO;
   
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rightView.hidden = YES;
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
//   [self addTitleViewWithTitle:@"创建饭局"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];//ViewColor(242, 242, 242,1.0);
       [self setbackBtn:@"返回"];
    //[self setBack];
    [self custum];
    [self registerForKeyboardNotifications];
//    RootTarBarViewController *tab = (RootTarBarViewController*)self.tabBarController;
//    [tab hiddenTabbar];
    if (self.isOld)
    {
//        if (self.isFoodOld) {
//            [self loadingOldFood];
//        }else if(self.isEditor)
//        {
//            //小编推荐 修改
//            [self loadEditor];
//        }else
//        {
//          [self loadingOldMeal];
//        }
        
    }else
    {
        [self showLastEdit];
    }
    
 
   
//    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    app.isEdited = YES;
//  __weak  typeof(app)weakApp = app;
//    __weak typeof(self)weakSelf = self ;
//    app.saveEdit=^{
//        [weakSelf saveEditView];
//        weakApp.isEdited = NO;
//    };
}
#pragma mark 获取小编推荐内容
//-(void)loadEditor{
//    __weak typeof(self)weakSelf = self ;
////    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
////    __weak  typeof(app)weakApp = app;
//    RequestManager *manager = [[RequestManager alloc]init];
//    NSUserDefaults *stand = [NSUserDefaults standardUserDefaults];
//    NSMutableDictionary *pamers = [NSMutableDictionary dictionary];
//    NSString *token = [stand objectForKey:yuefanToken];
//    [pamers setObject:token forKey:yuefanToken];//@"v1_230713505452_BB270"
//    NSNumber *num =[NSNumber numberWithLongLong:[self.mealId longLongValue]] ;//[NSNumber numberWithLong:<#(long)#>]
//    [pamers setObject:num forKey:@"recommendId"];
//    
//    [manager requestDataWithURL:@"/api/v2/editor/recommend/content/get.json" Parameters:pamers jsonParameter:nil success:^(NSDictionary *receiveData, NSInteger state)
//     {
//         
//         UIView *baview= [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
//         baview.backgroundColor = [UIColor blackColor];
//         baview.alpha = 0.8;
//         baview.userInteractionEnabled = NO;
//         weakSelf.blackView = baview;
//         
//         
//         
//         [weakSelf.view.window addSubview:baview];
//         //[weakApp.loadingView loadViewShow];
//         
//         NSString *title = receiveData[@"data"][@"recommendTitle"];
//         if (title.length>0) {
//             weakSelf.textField.text = title;
//         }
//         eidtFanJuModel *coverModel = [[eidtFanJuModel alloc]init];
//         coverModel.centent = receiveData[@"data"][@"recommendCover"];
//         __weak typeof(coverModel)weakModel = coverModel;
//         coverModel.tag = @"2";
//         coverModel.type = @"2";
//         NSURLRequest *req = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:coverModel.centent]];
//         [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *  response, NSData *  data, NSError *  connectionError) {
//             UIImage *img = [[UIImage alloc]initWithData:data];
//             weakModel.img = img;
//             [weakSelf.fenmian setImage:img forState:UIControlStateNormal];
//         }];
//         weakSelf.coverModel = coverModel;
//         
//         self.textView.text = receiveData[@"data"][@"recommendSummary"];
//         
//         NSArray *arr = [receiveData[@"data"][@"recommendContent"] mj_JSONObject];//receiveData[@"data"];
//         if (arr.count>0) {
//             //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//             NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = 2"];
//             NSArray *tempArr = [arr filteredArrayUsingPredicate:predicate];
//             __block    NSInteger index = 0;
//             NSMutableArray *dataArr = [NSMutableArray array];
//             for (NSDictionary *dic  in arr)
//             {
//                 //  NSDictionary *dic =
//                 
//                 eidtFanJuModel *model = [[eidtFanJuModel alloc]init];
//                 __weak typeof(model)weakModel = model;
//                 model.type =[NSString stringWithFormat:@"%@",dic[@"type"]] ;
//                 model.centent = dic[@"value"];
//                 
//                 [dataArr addObject:model];
//                 
//                 if ([model.type isEqualToString:@"2"])
//                 {
//                     model.tag = @"2";//服务器 已存在的图片
//                     NSURLRequest *req = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:model.centent]];
//                     [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *  response, NSData *  data, NSError *  connectionError) {
//                         index++;
//                         UIImage *img = [[UIImage alloc]initWithData:data];
//                         
//                         weakModel.img = img;
//                         if (index ==tempArr.count)
//                         {
//                             
//                             [weakSelf configWith:dataArr];
//                             [baview removeFromSuperview];
//                            // [weakApp.loadingView loadViewHide];
//                             [weakSelf.table reloadData];
//                             //[self.navigationController pushViewController:vc animated:YES];
//                             
//                         }
//                         
//                     }];
//                     
//                     
//                 }
//                 
//             }
//             
//             
//             if (tempArr.count == 0) {
//                 
//                 [weakSelf configWith:dataArr];
//                 [baview removeFromSuperview];
//                // [weakApp.loadingView loadViewHide];
//                 [weakSelf.table reloadData];
//             }
//             // });
//             
//         }
//         else{
//             [baview removeFromSuperview];
//            // [weakApp.loadingView loadViewHide];
//         }
//         
//     } failure:^(NSDictionary *receiveData, NSInteger state) {
//         
//     }];
//
//}
//
//#pragma mark 获取套餐详情
//-(void)loadingOldFood{
//    __weak typeof(self)weakSelf = self;
////    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
////    __weak  typeof(app)weakApp = app;
//     RequestManager *manager = [[RequestManager alloc]init];
//    NSMutableDictionary *pamers = [NSMutableDictionary dictionary];
//    NSNumber *num =[NSNumber numberWithLongLong:[self.mealId longLongValue]] ;//[NSNumber numberWithLong:<#(long)#>]
//    [pamers setObject:num forKey:@"comboId"];
//    [manager requestDataWithURL:@"/api/v2/combo/detail.json" Parameters:pamers jsonParameter:nil success:^(NSDictionary *receiveData, NSInteger state) {
//        UIView *baview= [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
//        baview.backgroundColor = [UIColor blackColor];
//        baview.alpha = 0.8;
//        baview.userInteractionEnabled = NO;
//        weakSelf.blackView = baview;
//        
//        
//        
//        [weakSelf.view.window addSubview:baview];
//       // [weakApp.loadingView loadViewShow];
//        
//        eidtFanJuModel *coverModel = [[eidtFanJuModel alloc]init];
//        coverModel.centent = receiveData[@"data"][@"comboCover"];
//        __weak typeof(coverModel)weakModel = coverModel;
//        coverModel.tag = @"2";
//        coverModel.type = @"2";
//        NSURLRequest *req = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:coverModel.centent]];
//        [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *  response, NSData *  data, NSError *  connectionError) {
//            UIImage *img = [[UIImage alloc]initWithData:data];
//            weakModel.img = img;
//            [weakSelf.fenmian setImage:img forState:UIControlStateNormal];
//        }];
//        weakSelf.coverModel = coverModel;
//        weakSelf.textField.text = receiveData[@"data"][@"comboName"];
//      //  NSData *jsondata = [receiveData[@"data"][@"comboFeature"] mj_JSONData ];
//        NSString *str =receiveData[@"data"][@"comboFeature"];
////        NSArray *data = receiveData[@"data"][@"comboFeature"];
//       // str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//     
//        NSMutableArray *data = [str mj_JSONObject];
//        if (data.count>0) {
//            
//            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = 2"];
//            NSArray *tempArr = [data filteredArrayUsingPredicate:predicate];
//            __block    NSInteger index = 0;
//             NSMutableArray *dataArr = [NSMutableArray array];
//            for (NSDictionary *dic  in data) {
//                eidtFanJuModel *mode = [[eidtFanJuModel alloc]init];
//              //  [weakSelf.editArr addObject:mode];
//                [dataArr addObject:mode];
//                 __weak typeof(mode)weakModel = mode;
//                mode.type = [NSString stringWithFormat:@"%@",dic[@"type"]];
//                mode.centent = dic[@"value"];
//                if ([mode.type isEqualToString:@"2"]) {
//                    mode.tag =@"2";
//                    NSURLRequest *req = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:mode.centent]];
//                    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *  response, NSData *  data, NSError *  connectionError) {
//                        index++;
//                        UIImage *img = [[UIImage alloc]initWithData:data];
//                        weakModel.img = img;
////                        if (index== 1) {
////                             [weakSelf.fenmian setImage:img forState:UIControlStateNormal];
////                            [dataArr removeObject:weakModel];
////                        }
//                        
//                        if (index ==tempArr.count)
//                        {
//                            
//                            [weakSelf configWith:dataArr];
//                            [baview removeFromSuperview];
//                            //[weakApp.loadingView loadViewHide];
//                            [weakSelf.table reloadData];
//                            //[self.navigationController pushViewController:vc animated:YES];
//                            
//                        }
//                        
//                    }];
//
//                }
//                
//            }
//            if (tempArr.count ==0) {
//                [weakSelf configWith:dataArr];
//                [baview removeFromSuperview];
//                //[weakApp.loadingView loadViewHide];
//                [weakSelf.table reloadData];
//            }
//        }
//        else{
//            [baview removeFromSuperview];
//           // [weakApp.loadingView loadViewHide];
//        }
//
//    } failure:^(NSDictionary *receiveData, NSInteger state) {
//       // ToastView_Error(@"套餐内容获取失败");
//    }];
//}
//
//#pragma mark 老饭局详情
//-(void)loadingOldMeal{
//    __weak typeof(self)weakSelf = self ;
////    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
////    __weak  typeof(app)weakApp = app;
//    RequestManager *manager = [[RequestManager alloc]init];
//    NSUserDefaults *stand = [NSUserDefaults standardUserDefaults];
//    NSMutableDictionary *pamers = [NSMutableDictionary dictionary];
//    NSString *token = [stand objectForKey:yuefanToken];
//    [pamers setObject:token forKey:yuefanToken];//@"v1_230713505452_BB270"
//    NSNumber *num =[NSNumber numberWithLongLong:[self.mealId longLongValue]] ;//[NSNumber numberWithLong:<#(long)#>]
//    [pamers setObject:num forKey:@"mealId"];
//    
//    [manager requestDataWithURL:@"/api/v1/meal/content.json" Parameters:pamers jsonParameter:nil success:^(NSDictionary *receiveData, NSInteger state)
////   [ manager getWithURl:@"/api/v1/meal/content.json" Parameters:pamers success:^(NSDictionary *receiveData, NSInteger state)
//    {
//        
//        UIView *baview= [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
//        baview.backgroundColor = [UIColor blackColor];
//        baview.alpha = 0.8;
//        baview.userInteractionEnabled = NO;
//        weakSelf.blackView = baview;
//        
//        
//        
//        [weakSelf.view.window addSubview:baview];
//       // [weakApp.loadingView loadViewShow];
//        
//        NSString *title = receiveData[@"data"][@"mealTopic"];
//        if (title.length>0) {
//            weakSelf.textField.text = title;
//        }
//        
//        NSArray *arr = [receiveData[@"data"][@"mealContent"] mj_JSONObject];
//        if (arr.count>0) {
//            //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = 2"];
//            NSArray *tempArr = [arr filteredArrayUsingPredicate:predicate];
//            __block    NSInteger index = 0;
//            NSMutableArray *dataArr = [NSMutableArray array];
//            for (NSDictionary *dic  in arr)
//            {
//                //  NSDictionary *dic =
//                
//                eidtFanJuModel *model = [[eidtFanJuModel alloc]init];
//                __weak typeof(model)weakModel = model;
//                model.type =[NSString stringWithFormat:@"%@",dic[@"type"]] ;
//                model.centent = dic[@"value"];
//                
//                [dataArr addObject:model];
//                
//                if ([model.type isEqualToString:@"2"])
//                {
//                    model.tag = @"2";//服务器 已存在的图片
//                    NSURLRequest *req = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:model.centent]];
//                    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *  response, NSData *  data, NSError *  connectionError) {
//                        index++;
//                        UIImage *img = [[UIImage alloc]initWithData:data];
//                        
//                        weakModel.img = img;
//                        if (index ==tempArr.count)
//                        {
//                            
//                            [weakSelf configWith:dataArr];
//                            [baview removeFromSuperview];
//                           // [weakApp.loadingView loadViewHide];
//                            [weakSelf.table reloadData];
//                            //[self.navigationController pushViewController:vc animated:YES];
//                            
//                        }
//                        
//                    }];
//                    
//                    
//                }
//                
//            }
//            
//            
//            if (tempArr.count == 0) {
//     
//                [weakSelf configWith:dataArr];
//                [baview removeFromSuperview];
//              //  [weakApp.loadingView loadViewHide];
//                [weakSelf.table reloadData];
//            }
//            // });
//            
//        }
//        else{
//            [baview removeFromSuperview];
//           // [weakApp.loadingView loadViewHide];
//        }
//        
//    } failure:^(NSDictionary *receiveData, NSInteger state) {
//        
//    }];
//
//}
-(void)configWith:(NSArray *)arr
{
   //__weak typeof(self)weakSelf =self;
    self.editArr = [NSMutableArray arrayWithArray:arr];
    eidtFanJuModel *m = [[eidtFanJuModel alloc]init];
    [_editArr insertObject:m atIndex:0];
}

-(void)showLastEdit{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (self.isFoodEdit) {
        if ([manager fileExistsAtPath:FILEPATH(@"foodContent")])
        {
            NSDictionary *dic  = [NSKeyedUnarchiver unarchiveObjectWithFile:FILEPATH(@"foodContent")];
            if (dic) {
                self.textField.text = dic[@"title"];
                self.editArr = [NSMutableArray arrayWithArray:dic[@"mealContent"]];
                self.coverModel = dic[@"cover"];
                if (self.coverModel) {
                    [self.fenmian setImage:self.coverModel.img forState:UIControlStateNormal];
                }
              
                              [_table reloadData];
            }

        }
    }else
    {
        if ([manager fileExistsAtPath:FILEPATH(@"mealContent")])
        {
            //        NSData *data = [NSData dataWithContentsOfFile:FILEPATH(@"mealContent")];
            //        NSDictionary *dic  = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            NSDictionary *dic  = [NSKeyedUnarchiver unarchiveObjectWithFile:FILEPATH(@"mealContent")];
            if (dic) {
                self.textField.text = dic[@"title"];
                self.editArr = [NSMutableArray arrayWithArray:dic[@"mealContent"]];
                NSNumber *num =  dic[@"isOn"];
                self.switchView.on = [num boolValue];
                [self swithAction:_switchView];
                [_table reloadData];
            }
            
            
        }

    }
}
-(void)Rootback{
    if (_editArr.count>1) {
        if (!self.isOld) {
             [self saveEditView];
        }
       
//        AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        app.isEdited = NO;
        [self.navigationController popViewControllerAnimated:YES];
//        UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"确定要退出吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
    }else{
//        AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        app.isEdited = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == self.alertTip) {
        if (buttonIndex == 1) {
            if (SYSTEM_FLOAT_VER >= 8.0) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
            
        }
    }else if(alertView == self.clearAlert)
    {
        if (buttonIndex == 0) {
            
        }else{
            NSFileManager *manager = [NSFileManager defaultManager];
            if (self.isFoodEdit) {
                if ([manager fileExistsAtPath:FILEPATH(@"foodContent")])
                {
                    NSError *err = nil;
                    [manager removeItemAtPath:FILEPATH(@"foodContent") error:&err];
                    if (err) {
                        NSLog(@"出错！ %@",[err localizedDescription]);
                    }
                    
                }
                if (self.fenmian.imageView.image) {
                    [self.fenmian setImage:nil forState:UIControlStateNormal];
                    self.coverModel.img = nil;
                }
            }else
            {
                if ([manager fileExistsAtPath:FILEPATH(@"mealContent")])
                {
                    NSError *err = nil;
                    [manager removeItemAtPath:FILEPATH(@"mealContent") error:&err];
                    if (err) {
                        NSLog(@"出错！ %@",[err localizedDescription]);
                    }
                    
                }
            }
           
           
            [self.editArr removeAllObjects];
            if (_peformArr.count>0) {
                [_peformArr removeAllObjects];
            }
            eidtFanJuModel *mode = [[eidtFanJuModel alloc]init];
            [self.editArr addObject:mode];
            if (_textField.text.length>0) {
                _textField.text = @"";
                _textField.placeholder = self.topic;
            }
            [self.table reloadData];
        }
    }
    else
    {
        if (buttonIndex == 0) {
            
        }else{
            [self saveEditView];
//            AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//            app.isEdited = NO;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
   
}

-(void)showSheet{
//    if (self.sheetView==nil)
//    {
//        UIView * bv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
//        bv.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
//        bv.userInteractionEnabled = YES;
//        _blackView.hidden =YES;
//        _blackView = bv;
//        
//        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesClick:)];
//        [_blackView addGestureRecognizer:tapGes];
//
//    }
    
    UIActionSheet *shet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    [shet showFromTabBar:self.tabBarController.tabBar];
}

#pragma mark -sheetview
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0://相册
            [self picture:nil];
            //NSLog(@"00000");
            break;
        case 1://拍照
           // NSLog(@"1111");
        {
            CamaraViewController *vc = [[CamaraViewController alloc]init];
            __weak typeof(self)weakSelf = self;
            vc.getPic  = ^(NSArray *arr,BOOL isfromCamera){
                if (weakSelf.imageViews.count) {
                    [weakSelf.imageViews removeAllObjects];
                }
                [weakSelf.imageViews addObjectsFromArray:arr];
                [weakSelf insertPic:weakSelf.imageViews :isfromCamera];
                [weakSelf.imageViews removeAllObjects];
            };
            
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        }
            
            break;
        default:
            break;
    }
}
-(NSMutableArray *)editArr{
    if (_editArr==nil) {
        _editArr = [NSMutableArray array];
    }
    return _editArr;
}
-(void)custum{
//    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, kWIDTH-50, 40)];
//    _textField.placeholder = self.topic;
//    //@"输入本次饭局聚会的主题";
//    //  _textField.text = self.topic;
//    self.textField.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_textField];
//
//    self.peformArr = [NSMutableArray array];
//    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_textField.frame)+4, kWIDTH-30, 1)];
//    line1.backgroundColor = ViewColor(217, 217, 217, 1);
//    [self.view addSubview:line1];
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT-64) style:UITableViewStylePlain];
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone ;
//    UINib *tablecell = [UINib nibWithNibName:@"EditPublishCell" bundle:nil];
      NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"Resouce" withExtension:@"bundle"]];
    UINib *tablecell = [UINib nibWithNibName:@"EditPublishCell" bundle:bundle];
    [_table registerNib:tablecell forCellReuseIdentifier:@"edit"];
    
    eidtFanJuModel *model = [[eidtFanJuModel alloc]init];
    [self.editArr insertObject:model atIndex:0];
    //[_editArr addObject:model];
    
    self.table.delegate = self;
    self.table.dataSource = self ;
    if (self.headView) {
        self.table.tableHeaderView = self.headView;
    }
    
    [self.view addSubview:self.table];
    
//    UIView *view= [[UIView alloc]initWithFrame:CGRectMake(kWIDTH-109, 20, 109, 40)];
//    self.rightView  = view;
//
//    UIButton *preformbtn = [[UIButton alloc]init];
//    preformbtn.frame = CGRectMake(52, 0, 50, 40);
// 
//    [preformbtn setTitle:@"预览" forState:UIControlStateNormal];
//  
//    preformbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 50-40, 0, 0);
//    [preformbtn setTitleColor:ViewColor(109, 61, 40, 1) forState:UIControlStateNormal];
//    preformbtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [preformbtn addTarget:self action:@selector(preform:) forControlEvents:UIControlEventTouchUpInside];
// 
//    
//    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(51, 13, 1, 14)];
//    line3.backgroundColor = ViewColor(109, 61, 40, 1);
//    [view addSubview:line3];
//    
//    UIButton *tempbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
//    
//    
//    [tempbtn setTitle:@"清空" forState:UIControlStateNormal];
//    [tempbtn setTitleColor:ViewColor(109, 61, 40, 1) forState:UIControlStateNormal];
//    tempbtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [tempbtn addTarget:self action:@selector(clearn) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:preformbtn];
//    [view addSubview:tempbtn];
    if (self.rightBtnView) {
        self.rightView = self.rightBtnView;
        [self.navigationController.view addSubview:self.rightBtnView];
    }
    
    
    UITapGestureRecognizer *tapLong = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moveCell)];
    
    tapLong.numberOfTapsRequired =2;
    
    [_table addGestureRecognizer:tapLong];
    _table.allowsSelectionDuringEditing = YES;
    
   

}
-(void)addRightBtn{
    if (self.rightBtnView) {
        self.rightView = self.rightBtnView;
        [self.navigationController.view addSubview:self.rightBtnView];
    }
}

//清空
-(void)clearn{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"确定清空编辑吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.clearAlert = alert;
    [alert show];
}
-(void)saveEditView{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_textField.text forKey:@"title"];
    [self resultArr :1];
    [dic setObject:_peformArr forKey:@"mealContent"];
    if (self.isFoodEdit) {
        if (self.coverModel.img!=nil) {
            [dic setObject:self.coverModel forKey:@"cover"];
        }
        
        
        [NSKeyedArchiver archiveRootObject:dic toFile:FILEPATH(@"foodContent")];
        
    }else{
        NSNumber *num = [NSNumber numberWithBool:self.switchView.on];
        [dic setObject:num forKey:@"isOn"];
        [NSKeyedArchiver archiveRootObject:dic toFile:FILEPATH(@"mealContent")];
    }
   
    //[data writeToFile:FILEPATH(@"mealContent") atomically:YES];
}

/**
 *  获取封面图片
 */
-(void)getFirstPicture:(UIButton*)sender{
    [self picture:sender];
}

-(void)moveCell{
    [_table setEditing:YES animated:YES];

}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}
- (void)swithAction:(UISwitch *)sender{
    
    BOOL isOn = sender.on;
    if (isOn) {
        
        self.pLabel.text = @"公开饭局";
        self.pLabel.textColor = ViewColor(163, 135, 64, 1);
        
    }else {
        
        self.pLabel.text = @"私密饭局";
        self.pLabel.textColor = ViewColor(183, 183, 183, 1);
    }
    
}

- (void)resultArr :(NSInteger)type {
    if (_peformArr.count!=0) {
        [_peformArr removeAllObjects];
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = '1'"];
    //_peformArr = [NSMutableArray array];
    NSMutableArray *temarr = [NSMutableArray arrayWithArray:_editArr];
    for(int i =0; i<_editArr.count; i++)
    {
        eidtFanJuModel *mode = _editArr[i];
        if([predicate evaluateWithObject:mode])
        { //判断指定的对象是否满足
            if (mode.centent==nil|| [mode.centent isEqualToString:@"点击开始输入"] || [mode.centent  isEqual: @""]) {
               // mode.type = @"10";
                [temarr removeObject:mode];
            }
        }
    }
    
//     NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"type = '10'"];
//    NSArray *temp = [_peformArr filteredArrayUsingPredicate:predicate2];
//    NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"NOT (SELF in %@)", temp];
//    _peformArr = [_peformArr filteredArrayUsingPredicate:thePredicate].mutableCopy;
    if (type == 0) {
        
        if (temarr.count >= 1) {
                 NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"type = '0'"];
                NSArray *temp = [temarr filteredArrayUsingPredicate:predicate2];
                NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"NOT (SELF in %@)", temp];
                temarr = [temarr filteredArrayUsingPredicate:thePredicate].mutableCopy;
           // [temarr removeObjectAtIndex:0];
        }
        
    }
    if (self.isFoodEdit && self.coverModel  && type == 0) {
        
        [temarr insertObject:self.coverModel atIndex:0];
    }
    if(self.isEditor && type == 0){
        if (self.textView.text.length!= NSNotFound) {
            eidtFanJuModel *m = [[eidtFanJuModel alloc]init];
            m.centent = self.textView.text;
            m.type = @"1";
            m.tag = @"intro";
            [temarr insertObject:m atIndex:0];
        }else{
            ToastView_Error(@"亲~请输入简介");
            return;
        }
        if(self.coverModel){
            [temarr insertObject:self.coverModel atIndex:0];
        }
    }
    
    _peformArr = [NSMutableArray arrayWithArray:temarr];
}

//yulan
-(void)preform:(UIButton *)sender{
    
//    if ([sender.titleLabel.text isEqualToString:@"预览"]) {
//        [self resultArr :0];
//        self.isShow =YES;
////        _table.frame = CGRectMake(8, 66, kWIDTH-16, kHEIGHT-66);
//        _table.backgroundColor = ViewColor(254, 234, 13, 1);
//        [sender setTitle:@"编辑" forState:UIControlStateNormal];
//        _table.tableFooterView= self.footView2;
//        _table.tableHeaderView.hidden =NO;
//        [self hideBackBtn];
//        [_table reloadData];
//    }else{
//        self.isShow =NO;
//        [sender setTitle:@"预览" forState:UIControlStateNormal];
//         _table.tableHeaderView.hidden =YES;
////        _table.frame = CGRectMake(0, CGRectGetMaxY(_textField.frame)+10, kWIDTH, kHEIGHT-120);
//        _table.backgroundColor = [UIColor whiteColor];
//        _table.tableFooterView= self.footView1;
//       
//        [self setbackBtn:@"返回"];
//        [_table reloadData];
//    }
//    
    
//bianxie
    DisplayViewController *vc = [[DisplayViewController alloc]init];
    if (_textField.text.length ==0) {
        vc.titleString = _textField.placeholder;
    }else
    {
        vc.titleString = _textField.text;
    }
    
    [self resultArr :0];
    if (self.isFoodEdit && self.coverModel) {//有封面
        [_peformArr removeObjectAtIndex:0];
    }
    [vc configWithArr:_peformArr];
    [self.navigationController pushViewController:vc animated:YES];
}


-(NSArray*)creatFanju:(NSInteger)sender
{
    NSLog(@"%@", kLIBRARY_PATH);
   // [self saveEditView];
    if (_textField.text.length>0) {
        
    }else{
        _textField.text = self.topic;
    }
    if (self.isFoodEdit || self.isEditor) {
        NSString *str = @"";
        if (_textField.text == nil || [_textField.text isEqualToString:@""]) {
            if (self.isFoodEdit) {
                str = @"请输入套餐名";
            }else{
                str = @"请输入推荐主题";
            }
            ToastView_Error(str);
            return nil;
        }
        if (self.coverModel.img == nil || self.coverModel == nil) {
            
            ToastView_Error(@"套餐封面还未选取");
            return nil;
        }
    }
//    UIView *baview= [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
//    baview.backgroundColor = [UIColor blackColor];
//    baview.alpha = 0.8;
//    baview.userInteractionEnabled = NO;
//    self.blackView = baview;
    
//    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [self.view.window addSubview:baview];
//    [app.loadingView loadViewShow];
    __weak typeof(self)weakSelf = self;
    NSLog(@"生成饭局");
    [self resultArr :0];//结果在_peformArr中
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //上传图片
  //__block  NSInteger index =0;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = '2'"];

    NSArray *arr = [_peformArr filteredArrayUsingPredicate:predicate];
    
//    NSMutableArray *imgArr = [NSMutableArray array];
    
    NSInteger oldMealPicCount = 0;
    if (self.isOld) {
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"tag = '2'"];
        NSArray *isHad =[_peformArr filteredArrayUsingPredicate:predicate2];
        oldMealPicCount = isHad.count;
       
    }
    [dic setValue:[NSNumber numberWithInteger:oldMealPicCount] forKey:@"oldMealPicCount"];
    //[dic setObject:self.textField.text forKey:@"title"];
    if (_peformArr.count >0)
    {
        [dic setObject:_peformArr forKey:@"data"];
        
//        self.navigationController.view.userInteractionEnabled =NO;
//        for (int i =0 ; i< _peformArr.count; i++)
//        {
//            eidtFanJuModel *model = _peformArr[i];
//            __weak typeof(model)weakModel = model;
////            if ([model.tag isEqualToString:@"cover"]) {
////                
////            }else
////            {
//                [imgArr addObject:model];
////            }
//            
//            if ([model.type isEqualToString:@"2"])
//            {
//                
//
//                if (self.isOld && [model.tag isEqualToString:@"2"]) {
//                    if (i == 0 ) {
//                        if (self.isFoodOld || self.isEditor) {
//                            model.tag = @"cover";
//                        }
//                        
//                    }
//                }else
//                {
//                    NSString *path = [NSString stringWithFormat:@"%@/api/v2/upload/meal/image.json",kServerAdress];
//                    
//                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//                    NSDictionary *params = @{@"yuefanToken":[[NSUserDefaults standardUserDefaults] objectForKey:yuefanToken]};
//                    //响应数据的序列化
//                    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
//                    NSData *imgData = UIImageJPEGRepresentation(model.img, 1.0);
//                    
//                    if (imgData)
//                    {
//                        [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//                            [formData appendPartWithFileData:imgData name:@"uploadFile" fileName:@"abc.jpg" mimeType:@"image/jpg"];
//                        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//                            
//                            NSLog(@"发送成功：%@",dic);
//                            weakModel.centent = dic[@"data"];
//                            
//                            index++;
//                            if (self.isOld)
//                            {
//                                if (index == (arr.count -oldMealPicCount) ) {
//                                    [self performSelectorOnMainThread:@selector(updataGoBack:) withObject:imgArr waitUntilDone:NO];
//                                }
//                            }else
//                            {
//                                if (index ==arr.count) {
//                                    [self performSelectorOnMainThread:@selector(updataGoBack:) withObject:imgArr waitUntilDone:NO];
//                                }
//                            }
//                            
//                            
//                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                            
//                            NSLog(@"发送带图失败");
//                            [baview removeFromSuperview];
////                            [app.loadingView loadViewHide];
//                             self.navigationController.view.userInteractionEnabled =YES;
////                            [weakSelf.navigationController popViewControllerAnimated:YES];
////                            ToastView_Error(@"图片发送失败");
//                        }];
//                        
//                    }
// 
//                }
//               
//            }
//            
//        }
//        if ( arr.count ==0)//纯文字
//        {
//            if (weakSelf.creatMeal){
//                
//                weakSelf.creatMeal(imgArr,0,weakSelf.textField.text,weakSelf.switchView.on);
//                self.navigationController.view.userInteractionEnabled =YES;
//            }
//                [baview removeFromSuperview];
////                [app.loadingView loadViewHide];
//                [self.navigationController popViewControllerAnimated:YES];
//            }else
//            {
//                if (index - arr.count -oldMealPicCount ==0 && self.isOld) {
//                    if (weakSelf.creatMeal)
//                    {
//                        weakSelf.creatMeal(imgArr,0,weakSelf.textField.text,weakSelf.switchView.on);
//                        self.navigationController.view.userInteractionEnabled =YES;
//                    }
//                    [baview removeFromSuperview];
////                    [app.loadingView loadViewHide];
//                    [self.navigationController popViewControllerAnimated:YES];
//                }else if(arr.count == oldMealPicCount)
//                    
//                {
//                    if (weakSelf.creatMeal)
//                    {
//                        weakSelf.creatMeal(imgArr,0,weakSelf.textField.text,weakSelf.switchView.on);
//                        self.navigationController.view.userInteractionEnabled =YES;
//                    }
//                    [baview removeFromSuperview];
////                    [app.loadingView loadViewHide];
//                    [self.navigationController popViewControllerAnimated:YES];
//                }
//            }
//
//
//
        if (self.creatMeal && sender == dataBack)
        {
            
            self.creatMeal(dic);
           // self.navigationController.view.userInteractionEnabled =YES;
            
        }
       
       // [self.navigationController popViewControllerAnimated:YES];
   
return _peformArr;
    }else
        {
            if (arr.count ==0)
            {
                if (weakSelf.creatMeal && sender == dataBack)
                {
                    
                    weakSelf.creatMeal(dic);
                   // return nil;
                    
                }
                return nil;

            }
            

           return nil;
        }
    
    
}
//-(void)updataGoBack:(NSMutableArray*)arr{
////    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    __weak typeof(self)weakSelf =self;
//    if (arr.count == _peformArr.count ) {
//        if (weakSelf.creatMeal)
//        {
//            
//            weakSelf.creatMeal(arr,0,weakSelf.textField.text,weakSelf.switchView.on);
//            self.navigationController.view.userInteractionEnabled =YES;
//        }
//         [_blackView removeFromSuperview];
////        [app.loadingView loadViewHide];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}
//
#pragma mark -相册
-(void)picture:(UIButton*)sender{
    //判断相册是否允许访问
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    
    if (status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusDenied) {
        //相册不允许访问
        UIAlertView *alret = [[UIAlertView alloc]initWithTitle:@"提示" message:@"相册不允许访问，请去设置-> 约饭 -> 相册，使我们允许访问" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        self.alertTip = alret;
        [alret show];
       // ToastView_Susess(@"相册不允许访问，请去设置-> 约饭 -> 相册，使我们允许访问");
        
    }
//    else if (sender.tag ==cover)//fengmian
//    {
//        if (!_photoPickerController) {
//            
//            _photoPickerController =[[UIImagePickerController alloc]init];
//
//            _photoPickerController.delegate = self;
//            _photoPickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
//
//            _photoPickerController.allowsEditing=NO;
//            
//            
//        }
//        [self presentViewController:_photoPickerController animated:YES completion:nil];
//        
//    }
    else  {
        
        MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
        
        pickerVc.status = PickerViewShowStatusCameraRoll;
        if (sender.tag== cover) {
            pickerVc.maxCount = 1;
        }else
        {
          pickerVc.maxCount = 9;
        }
        
        
        [pickerVc showPickerVc:self];
        __weak typeof(self) weakSelf = self;
        __weak typeof(sender)weakSender =sender;
        pickerVc.callBack = ^(NSArray *assets)
        {
            if (assets.count>0)
            {
                if (weakSender.tag == cover) {
                    MLSelectPhotoAssets *aset = assets[0];
                    //UIImage *portraitImg = arr[i];
                    
                    UIImage  *portraitImg   = [aset originImage];
                    // portraitImg = [self OriginImage:portraitImg scaleToSize:(CGSize)]
                    if (!weakSelf.coverModel) {
                        eidtFanJuModel *mode = [eidtFanJuModel addPicCellModel:portraitImg];
                        mode.tag = @"cover";
                        weakSelf.coverModel = mode;
                    }
                    weakSelf.coverModel.img = portraitImg;
                    if (weakSelf.isFoodOld || weakSelf.isEditor) {
                        weakSelf.coverModel.tag =@"cover";
                        
                    }
                    [weakSelf.fenmian setImage:weakSelf.coverModel.img forState:UIControlStateNormal];
                    
                }else
                {
                    if (weakSelf.imageViews.count) {
                        [weakSelf.imageViews removeAllObjects];
                    }
                    [weakSelf.imageViews addObjectsFromArray:assets];
                    [weakSelf insertPic:weakSelf.imageViews :NO];
                }
            }
            
           
            //[weakSelf.table reloadData];
        };

        
      
//        [self presentViewController:_photoPickerController animated:YES completion:nil];
        
    }

}
- (void)insertPic:(NSMutableArray *)arr :(BOOL)isfromCamera {
   
    if (arr.count>0) {
        for (int i =0   ;i<arr.count;i++) {
            UIImage *portraitImg;
            eidtFanJuModel *model;
            if (isfromCamera) {
                portraitImg = arr[i];
                model = [eidtFanJuModel addPicCellModel:portraitImg];
            }else
            {
                MLSelectPhotoAssets *aset = arr[i];
                portraitImg   = [aset originImage];
                model = [eidtFanJuModel addPicCellModel:portraitImg];
                NSString *url = aset.assetURL.description;
                if ([url rangeOfString:@".GIF"].length>0) {
                    //  model.url = url;
                    ALAssetRepresentation *rep = [aset.asset defaultRepresentation];
                    Byte *imageBuffer = (Byte*)malloc(rep.size);
                    NSUInteger bufferSize = [rep getBytes:imageBuffer fromOffset:0.0 length:rep.size error:nil];
                    NSData *imageData = [NSData dataWithBytesNoCopy:imageBuffer length:bufferSize freeWhenDone:YES];
                    model.gifData = imageData;
                    //model.img =nil;
                    model.img = [UIImage sd_animatedGIFWithData:model.gifData];
                }
                
                
                
            }
            
            
            
            
            [_editArr insertObject:model atIndex:_path.row+1+i];
            
            //[_table beginUpdates];
            [_table insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_path.row+1+i inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
            
            //[_table endUpdates];
            [_table reloadData];
            
        }
    }
    
    [_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_path.row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   

    [picker dismissViewControllerAnimated:YES completion:^() {
        
        //        [self faceDetect:portraitImg];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        float imageSize = imageData.length / 1024.0 / 1024.0;
        
        if (imageSize >= 8.0) {
            
//            ToastView_Susess(@"图片过大，请重新选择");
            
            return;
        }
        [self.fenmian setImage:image forState:UIControlStateNormal];

    }];
}



-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
   // UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.imageViews removeAllObjects];
    }];
}

#pragma mark table
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isShow) {
        eidtFanJuModel *mode = _peformArr [indexPath.row];
        if ([mode.type isEqualToString:@"1"])
        {
            
            CGSize size = CGSizeMake(kWIDTH-10, MAXFLOAT);
            
            CGSize labelsize = [mode.centent sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:size lineBreakMode:UILineBreakModeCharacterWrap];
            return labelsize.height+8;
        }else
        {
            return mode.img.size.height*(kWIDTH-10)/mode.img.size.width+5;
        }
        
    }
    else
    {
        eidtFanJuModel *model = _editArr[indexPath.row];
        if ([model.type isEqualToString:@"0"]) {
            return 40;
        }else
            return 135;
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    if (_editArr.count==0) {
//        return 1;
//    }else
    if (self.isShow) {
        return _peformArr.count;
    }else
        return _editArr.count;
}

-   (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (self.isShow)
//    {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//        if (cell==nil)
//        {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectZero];
//            img.tag = 1000;
//            img.layer.borderWidth = 2;
//            img.layer.borderColor = [UIColor blackColor].CGColor;
//            [cell addSubview:img];
//            
//            UITextView *lab = [[UITextView alloc]initWithFrame:CGRectZero];
//            lab.font = [UIFont systemFontOfSize:15];
//            lab.tag = 100;
//            lab.userInteractionEnabled = NO;
//            //        lab.textAlignment = NSTextAlignmentJustified;
//            [cell addSubview:lab];
//        }
//      
//        
//        eidtFanJuModel *model = _peformArr[indexPath.row];
//        UITextView *lb = [cell viewWithTag:100];
//      
//        CGRect rect = CGRectZero;
//        rect.size.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
//        lb.frame = CGRectMake(5, 0, kWIDTH-10, rect.size.height);
//        UIImageView *imgv = (UIImageView*)[cell viewWithTag:1000];
//        imgv.frame =CGRectMake(5, 0, kWIDTH-10, rect.size.height-5);
//        
//        if ([model.type isEqualToString:@"1"]) {
//            //wenzi
//            lb.text = model.centent;
//            imgv.hidden=YES;
//            lb.hidden = NO;
//        }else{
//            imgv.image = model.img;
//            imgv.hidden=NO;
//            lb.hidden = YES;
//        }
//        
//        
//        return cell;
//
//    }else
//    {
        eidtFanJuModel *model = _editArr[indexPath.row];
        EditPublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"edit"];
//    if (cell == nil) {
//        NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"EditorController1" withExtension:@"bundle"]];
////        cell = [UINib nibWithNibName:@"EditPublishCell" bundle:bundle];
////        [_table registerNib:tablecell forCellReuseIdentifier:@"edit"];
//       cell= [bundle loadNibNamed:@"EditPublishCell" owner:nil options:nil].firstObject;
//      
//    }
    cell.isMarryVc = self.isMarry;
    if (self.marryTips.length>0) {
        cell.marryLabel.text = self.marryTips;
        cell.marryLabel.textColor = [UIColor darkTextColor];
    }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        // cell.buttomVIew.tag = indexPath.row;
        cell.userInteractionEnabled = YES;
        
        if ([model.type isEqualToString:@"1"]) {
            cell.imgView.hidden = YES;
            
            cell.textView.hidden = NO;
        }else{
            cell.imgView.hidden = NO;
            cell.textView.hidden = YES;
            cell.imgView.image =nil;
        }
    [cell ViewinitWithModel:model];
    cell.model = model;
        __weak typeof(self)weakSelf =self;
        //block回调（其实写那里都行，只有cell.add被调用的时候才会回调进入那里）
        cell.add =^(NSString *type)
        {
            [weakSelf.view endEditing:YES];
            [weakSelf addcell:type index:indexPath];
            weakSelf.path =indexPath;
        };
        
        __weak typeof(cell)weakCell = cell;
        __weak typeof(tableView)WeakTable = tableView;
        
        cell.refrshKeyBoard=^{
            weakSelf.keyBoardhideStutes = NO;
            weakSelf.point = weakSelf.table.contentOffset;
            CGRect rect = [WeakTable convertRect:weakCell.textView.frame fromView:weakCell];
            // NSLog(@"%@",rect);
            [UIView animateWithDuration:.25 animations:^{
               weakSelf.table.contentOffset = CGPointMake(0, rect.origin.y);
                weakSelf.curuntPoint = CGPointMake(0, rect.origin.y);
                
            }];
        
            
        };
        
        
        [cell setNeedsDisplay];
        return cell;
 
//    }
    
    
   
}

#pragma mark -  移动数据行

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    //
    eidtFanJuModel *contact = [self.editArr objectAtIndex:sourceIndexPath.row];
    
    [self.editArr removeObjectAtIndex:sourceIndexPath.row];
    
    [self.editArr insertObject:contact atIndex:destinationIndexPath.row];
}



//新建cell
- (void)addcell:(NSString *)type index:(NSIndexPath*)index{
    if ([type isEqualToString:@"text"]) {
        
        eidtFanJuModel *model = [eidtFanJuModel addTextCellModel];
        [_editArr insertObject:model atIndex:index.row+1];
      //  [_table beginUpdates];
        //插入一个单元格
        [_table insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index.row+1 inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
        //[_table endUpdates];
      [_table reloadData];
        //滚动到刚加的单元格位置
         [_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index.row+1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
//        if (_table.contentSize.height-_table.contentOffset.y-_table.bounds.size.height  ==0) {
//            _table.contentOffset = CGPointMake(0, self.kbHight+_table.contentOffset.y);
//            
//        }
//        EditPublishCell *cell = [_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index.row+1 inSection:0]];
//        
//        [cell.textView becomeFirstResponder];
        
    }else if ([type isEqualToString:@"pic"])
    {
        [self showSheet];
       // [self picture:nil];
    }else if ([type isEqualToString:@"delet"])
    {
        
        [_editArr removeObjectAtIndex:index.row];
        // EditPublishCell *cell = [_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index.row inSection:0]];
      //  [_table beginUpdates];
        //删除一个单元格
        [_table deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index.row inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
//        cell.editingStyle = UITableViewCellEditingStyleDelete;
       // [_table endUpdates];
        [_table reloadData];
        NSLog(@"delet---%ld",(long)index.row);
        
    }
    
    
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == _table) {
       // if (scrollView.contentOffset.y != _curuntPoint.y) {
            [self.view endEditing:YES];
        [_table setEditing:NO animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 键盘通知
- (void)registerForKeyboardNotifications
{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShownToEdit:)
//                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHiddenToEdit:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)removeKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShownToEdit:(NSNotification *)notification
{
    
    NSDictionary* info = [notification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    
    self.point = _table.contentOffset;
    
//    //滚动视图偏移量
    CGPoint offSet = _table.contentOffset;
//    //上次键盘的高度
//    CGFloat oldKBh = offSet.y + _table.bounds.size.height - _table.contentSize.height;
//    
    offSet.y = offSet.y +  kbSize.height;
//    if (_table.contentSize.height<_table.bounds.size.height/2) {
//        offSet.y = 0;
//    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _table.contentOffset = CGPointMake(0, _khight);
        
    }];
}

- (void)keyboardWillBeHiddenToEdit:(NSNotification *)notification
{
//    NSDictionary* info = [notification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    //滚动视图偏移量
//    CGPoint offSet = _table.contentOffset;
    //    //上次键盘的高度
   
   // offSet.y = _table.contentSize.height - _table.bounds.size.height;
//    offSet.y = _table.contentOffset.y - kbSize.height;
//    
//   
    [UIView animateWithDuration:0.25 animations:^{
        if (!self.keyBoardhideStutes) {
            _table.contentOffset = self.point;
        }
        
        
    }];
}

-(void)dealloc{
    self.table.delegate = nil;
    self.table.dataSource = nil;
  //  self.table = nil;
    [self.rightView removeFromSuperview];
    [self removeKeyboardNotifications];
//    self.creatMeal= nil;
//    self.view=nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
