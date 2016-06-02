//
//  CamaraViewController.m
//  yuefan
//
//  Created by zhangz on 15/11/25.
//  Copyright © 2015年 dtdxunlei. All rights reserved.
//

#import "CamaraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVCaptureSession.h>
#import <AssetsLibrary/AssetsLibrary.h>
//#import "ToastView.h"
//#import "RootTarBarViewController.h"
#import "UIImage+Resize.h"
//#import "CLImageEditor.h"
#import "MLSelectPhotoPickerViewController.h"

@interface CamaraViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate , UIImagePickerControllerDelegate >
{
    AVCaptureSession *_session;
    //相册
    UIImagePickerController *_photoPickerController;
    UIView *_cameraView;
     UIView *_showView;
}
@property (nonatomic, strong)NSMutableArray *imageViews;

/**确认使用*/
@property (nonatomic , weak)UIImageView *affirmView;
//取消
- (IBAction)cancerClick:(id)sender;
//拍照
- (IBAction)playClick:(id)sender;
//相册
- (IBAction)labraryClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *flashLamp;
@property (weak, nonatomic) IBOutlet UIButton *transform;

@property (weak, nonatomic) IBOutlet UIView *bgview;
/**输入流*/
@property (nonatomic , strong)AVCaptureDeviceInput *deviceInput;
/**照片输出流*/
@property (nonatomic , strong)AVCaptureStillImageOutput *stillImageOutput;
/**预览层 显示摄像机拍摄到的画面*/
@property (nonatomic , strong)AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation CamaraViewController
- (instancetype)init
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"Resouce" withExtension:@"bundle"]];
    self = [super initWithNibName:@"CamaraViewController" bundle:bundle];
    if (self) {
        return self;
    }
    return nil;
}
-(NSMutableArray*)imageViews{
    if (_imageViews == nil) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [(RootTarBarViewController *)self.tabBarController hiddenTabbar];
    
    if (_session) {
        [_session startRunning];
    }
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [(RootTarBarViewController *)self.tabBarController showTabbar];
    
    if (_session) {
        [_session stopRunning];
    }
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prefersStatusBarHidden];
    [self setNeedsStatusBarAppearanceUpdate];
    self.bgview.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor blackColor];
    //定制相机
    [self createCamera];
    self.flashLamp.hidden = YES;
    self.transform.hidden = YES;
//    _showView = [[UIView alloc]initWithFrame:CGRectMake(0, (self.bgview.frame.size.height -  kWIDTH ) / 2.0, kWIDTH, kWIDTH)];
//    _showView.backgroundColor = [UIColor clearColor];
//    _showView.contentMode = UIViewContentModeScaleAspectFill;
    if (kWIDTH == 320.0) {
         _cameraView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kWIDTH, kWIDTH)];
    }else{
        _cameraView = [[UIView alloc]initWithFrame:CGRectMake(0, 75, kWIDTH, kWIDTH)];
    }
    
    // [self.bgview addSubview:_showView];
    _cameraView.backgroundColor = [UIColor clearColor];
    
    [self.bgview addSubview:_cameraView];
     [self setUpCameraLayer:_cameraView];
     [self changeCamaraType:2];
    [self createAffirmView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//闪光灯
- (IBAction)flashLampclick:(UIButton *)sender {
}
//前后置
- (IBAction)cameraType:(UIButton *)sender {
    [self changeCamaraType:0];
    //翻转动画
    
        [UIView transitionWithView:_cameraView duration:0.5 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionTransitionFlipFromLeft|UIViewAnimationOptionCurveEaseOut animations:^{
            
        } completion:^(BOOL finished) {
            
        }];
//    }else {
//        [UIView transitionWithView:_faceView duration:0.5 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionTransitionFlipFromLeft|UIViewAnimationOptionCurveEaseOut animations:^{
//            
//        } completion:^(BOOL finished) {
//            
//        }];
    

}

- (void)changeCamaraType:(NSUInteger)type
{
    /*
     type 0 按键操作
     1 切换到前置
     2 切换到后置
     */
    [_session beginConfiguration];
    //创建一个输入[self.deviceInput.device isEqual:[self frontCamera]]
    if (self.deviceInput.device.position == AVCaptureDevicePositionFront) {
        if (type == 1) {
            [_session commitConfiguration];
            return;
        }
        self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:[self backCamera] error:nil];
    }else {
        if (type == 2) {
            [_session commitConfiguration];
            return;
        }
        self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:[self frontCamera] error:nil];
    }
    //删掉之前的输入
    NSArray *oldInputs = [_session inputs];
    for (AVCaptureInput *input in oldInputs)
    {
        [_session removeInput:input];
    }
    
    if ([_session canAddInput:self.deviceInput]) {
        [_session addInput:self.deviceInput];
    }
    [_session commitConfiguration];
}
#pragma mark - 定制相机
- (void)createCamera
{
    NSError *error = nil;
    
    _session = [[AVCaptureSession alloc] init];
    [_session beginConfiguration];
    //图片质量
    _session.sessionPreset = AVCaptureSessionPresetMedium;
    
    //创建一个输入
    //删掉之前的输入
    NSArray *oldInputs = [_session inputs];
    for (AVCaptureInput *input in oldInputs)
    {
        [_session removeInput:input];
    }
    AVCaptureDeviceInput *input;

        input = [AVCaptureDeviceInput deviceInputWithDevice:[self backCamera] error:&error];

    self.deviceInput = input;
    if ([_session canAddInput:input]) {
        [_session addInput:input];
    }
    
    
    //创建输出
    //删掉之前的输出
    NSArray *oldOutputs = [_session outputs];
    for (AVCaptureOutput *output in oldOutputs)
    {
        [_session removeOutput:output];
    }
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    //这是输出流的设置参数AVVideoCodecJPEG参数表示以JPEG的图片格式输出图片
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    if ( [_session canAddOutput:self.stillImageOutput])
    {
        //Add new output
        [_session addOutput:self.stillImageOutput];
    }
    
    //结束
    [_session commitConfiguration];
    
}
#pragma mark - 切换摄像头
- (AVCaptureDevice *)captureDeviceForPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        
        if ([device position] == position) {
            
            return device;
        }
    }
    return nil;
}
- (AVCaptureDevice *)frontCamera
{
    return [self captureDeviceForPosition:AVCaptureDevicePositionFront];
}
- (AVCaptureDevice *)backCamera
{
    return [self captureDeviceForPosition:AVCaptureDevicePositionBack];
}
#pragma mark - 设置展示的VIEW
- (void) setUpCameraLayer:(UIView *)view
{
    if (_session == nil) return;
    
    if (self.previewLayer == nil) {
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    }
    CALayer * viewLayer = [view layer];
    [viewLayer setMasksToBounds:YES];
    
    CGRect bounds = [view bounds];
    
    [self.previewLayer setFrame:bounds];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    [viewLayer insertSublayer:self.previewLayer below:[[viewLayer sublayers] objectAtIndex:0]];
    
}
#pragma mark - 相册的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:UIImagePickerControllerOriginalImage];

    
        NSData *imageData = UIImageJPEGRepresentation(portraitImg, 1);
        float imageSize = imageData.length / 1024.0 /1024.0 ;
        
        if (imageSize >= 8.0) {
            
           // ToastView_Susess(@"图片过大，请重新选择");
            
            return;
        }
        
        self.affirmView.image = portraitImg;
        self.affirmView.hidden = NO;
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 确认view
- (void)createAffirmView
{
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
    iv.backgroundColor = [UIColor blackColor];
    iv.userInteractionEnabled = YES;
    iv.contentMode = UIViewContentModeScaleAspectFit;
    self.affirmView = iv;
    [self.view addSubview:self.affirmView];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(kWIDTH - 80, kHEIGHT - 30, 80, 30)];
    btn.tag = 3331;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"确认使用" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(AffirmViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.affirmView addSubview:btn];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, kHEIGHT - 30, 80, 30)];
    btn2.tag = 3332;
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"重新选择" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(AffirmViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.affirmView addSubview:btn2];
//    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(kWIDTH- 80,  20, 80, 30)];
//    btn3.tag = 3333;
//    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn3 setTitle:@"编辑" forState:UIControlStateNormal];
//    [btn3 addTarget:self action:@selector(AffirmViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.affirmView addSubview:btn3];
    
    self.affirmView.hidden = YES;
}
- (void)AffirmViewBtnClick:(UIButton *)btn
{
    //self.affirmView.hidden = NO;
    if (btn.tag == 3331) {
        //确认使用
        
        if (self.getPic) {
           // self.affirmView.hidden = YES;
            
            self.getPic(@[_affirmView.image],YES);
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        
        
    }else if(btn.tag == 3332){
        //重新选择
        self.affirmView.hidden = YES;
        self.affirmView.image = nil;
    }else if (btn.tag == 3333)
    {
        //编辑图片
//        CLImageEditor *editvc = [[CLImageEditor alloc]initWithImage:_affirmView.image delegate:self];
//        [self presentViewController:editvc animated:YES completion:^{
//            
//        }];
    }
}
#pragma mark - 滤镜的代理方法
//- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
//{
//    //编辑后的图片
//   
//    [editor dismissViewControllerAnimated:YES completion:nil];
//}
//- (void)imageEditorDidCancel:(CLImageEditor *)editor
//{
//    self.affirmView.hidden = YES;
//    self.affirmView.image = nil;
//    [editor dismissViewControllerAnimated:YES completion:nil];
//}
#pragma mark - 页面点击事件
- (IBAction)cancerClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)playClick:(id)sender {
    AVCaptureConnection *videoConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"拍照失败");
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return ;
        }
        
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        
        float imageSize = 2 * imageData.length / 1024.0 /1024.0 ;
        
        if (imageSize >= 8.0) {
            
           // ToastView_Susess(@"照片过大，请重新拍摄");
            
            return;
        }
        
        UIImage * image = [[UIImage alloc] initWithData:imageData];
        
        CGSize size = CGSizeMake(kWIDTH * 2, kWIDTH * 2);
        
        CGFloat headHeight = _previewLayer.bounds.size.height - kWIDTH;
        
        UIImage *scaledImage = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:size interpolationQuality:kCGInterpolationMedium];
        
        NSLog(@"scaledImage:%@", [NSValue valueWithCGSize:scaledImage.size]);
        
        CGRect cropFrame = CGRectMake((scaledImage.size.width - size.width) / 2, (scaledImage.size.height - size.height) / 2 + headHeight, size.width, size.height);
        
        NSLog(@"cropFrame:%@", [NSValue valueWithCGRect:cropFrame]);
        
        //UIImage *croppedImage = [self OriginImage:scaledImage scaleToSize:size];
        UIImage *croppedImage = [scaledImage croppedImage:cropFrame];
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
        if (orientation != UIDeviceOrientationPortrait) {
            
            CGFloat degree = 0;
            if (orientation == UIDeviceOrientationPortraitUpsideDown) {
                degree = 180;// M_PI;
            } else if (orientation == UIDeviceOrientationLandscapeLeft) {
                degree = -90;// -M_PI_2;
            } else if (orientation == UIDeviceOrientationLandscapeRight) {
                degree = 90;// M_PI_2;
            }
            croppedImage = [croppedImage rotatedByDegrees:degree];
        }
        
        
        self.affirmView.image = croppedImage;
        self.affirmView.hidden = NO;
    }];
}
//-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
//{
//    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
//    // UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
//    
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return scaledImage;   //返回的就是已经改变的图片
//}


- (IBAction)labraryClick:(id)sender {
    //判断相册是否允许访问
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    
    if (status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusDenied) {
        //相册不允许访问
        UIAlertView *alret = [[UIAlertView alloc]initWithTitle:@"提示" message:@"相册不允许访问，请去设置-> 约饭 -> 相册，使我们允许访问" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        
        [alret show];
        
    }else  {
//        if (!_photoPickerController) {
//            
//            _photoPickerController =[[UIImagePickerController alloc]init];
//            _photoPickerController.delegate = self;
//            _photoPickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
//            _photoPickerController.allowsEditing=NO;
//            
//        }
//        [self presentViewController:_photoPickerController animated:YES completion:nil];
        MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
        
        pickerVc.status = PickerViewShowStatusCameraRoll;
        
        pickerVc.maxCount = 9;
        
        [pickerVc showPickerVc:self];
        __weak typeof(self) weakSelf = self;
        pickerVc.callBack = ^(NSArray *assets)
        {
            // CallBack or Delegate
            if (weakSelf.imageViews.count) {
                [weakSelf.imageViews removeAllObjects];
            }
            [weakSelf.imageViews addObjectsFromArray:assets];
           // [weakSelf insertPic:weakSelf.imageViews];
            if (self.getPic)
            {
                // self.affirmView.hidden = YES;
                
                weakSelf.getPic(weakSelf.imageViews,NO);
                [weakSelf dismissViewControllerAnimated:NO completion:^{
                    
                }];
            //[weakSelf.table reloadData];
            };

        };
    }

}
@end
