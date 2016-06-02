//
//  EditPublishCell.m
//  yuefan
//
//  Created by zhangz on 15/11/12.
//  Copyright © 2015年 dtdxunlei. All rights reserved.
//

#import "EditPublishCell.h"
//#import "UIImageView+WebCache.h"

@interface EditPublishCell ()<UITextViewDelegate>
//@property(nonatomic ,weak)UIView *bgView;
@end

@implementation EditPublishCell

- (void)awakeFromNib {
    // Initialization code
//    self.cententView.layer.borderWidth= 1;
//    self.cententView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.delegate =self;
    self.textView.textColor = [UIColor lightGrayColor];
    self.cutPicBtn.hidden = YES;
    self.sureBtn.hidden = YES;
    self.textView.textContainerInset = UIEdgeInsetsMake(5, 10, 5, 10);
//    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectZero];
//    self.imgView =iv;
    
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView.clipsToBounds = YES;
   // self.imgView.backgroundColor  = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImg:)];
    [self addGestureRecognizer:tap];
    
}
-(void)tapImg:(UITapGestureRecognizer*)gr{
    
    //获取点击位置
    CGPoint point = [gr locationInView:self];
  
    //判断点击位置是否在图片区域
    if (_imgView.hidden == NO && CGRectContainsPoint(_imgView.frame, point)) {
       // if (_bgView==nil) {
        //获取图片对应在windows上的frame
        CGRect rect = [self convertRect:_imgView.frame toView:self.window];
//            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
//            view.backgroundColor = ViewColor(29, 29, 29, 1);
        
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeBjView:)];
//        CGRect fram =rect;
//        fram.origin.x = 20;
//        rect = fram;
        //设置图片
            UIImageView *iv = [[UIImageView alloc]initWithFrame:rect];
        iv.backgroundColor = [UIColor blackColor];
            iv.userInteractionEnabled = YES;
            iv.contentMode = UIViewContentModeScaleAspectFit;
            iv.tag =110;
            //[view addSubview:iv];
            [iv addGestureRecognizer:tap];
        //将imageview加到window上面
            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
           // _bgView = view;
         //   [window addSubview:view];
        [window addSubview:iv];
       // }
        [UIView animateWithDuration:.5 animations:^{
           // _bgView.hidden = NO;
            //_bgView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
           // UIImageView *iv = [_bgView viewWithTag:110];
            iv.image = _imgView.image;
            iv.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
        }];
        
        
    }
    else{
        
        [self.superview.superview endEditing:YES];
    }
}
-(void)closeBjView:(UITapGestureRecognizer*)gr{
    __weak typeof(self)weakSelf = self;
    CGRect rect = [weakSelf convertRect:weakSelf.imgView.frame toView:weakSelf.window];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    UIImageView *iv = [window viewWithTag:110];
    [UIView animateWithDuration:.5 animations:^{
        //_bgView.frame = rect;
        iv.frame = rect;
        //_bgView.alpha = 0;
    } completion:^(BOOL finished) {
       // [_bgView removeFromSuperview];
        [iv removeFromSuperview];
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
     __weak typeof(self)weakSelf = self;
    [weakSelf.superview endEditing:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//-(void)layoutSubviews{
//    
//}

-(void)ViewinitWithModel:(eidtFanJuModel*)model{

    
    if (self.isMarryVc) {
        
        self.addMarryImgBtn.hidden = NO;
        self.addMarryTextBtn.hidden = NO;
        self.addPuTongPicBtn.hidden = YES;
        self.addPuTongTextBtn.hidden = YES;
        self.marryLabel.hidden = NO;
        
        self.puTongImgBtn.hidden = YES;
        self.puTongTextBtn.hidden = YES;
        self.marryTextBtn.hidden = NO;
        self.marryImageBtn.hidden = NO;
        
    } else {
        
        self.marryLabel.hidden = YES;
        self.addMarryImgBtn.hidden = YES;
        self.addMarryTextBtn.hidden = YES;
        self.addPuTongPicBtn.hidden = NO;
        self.addPuTongTextBtn.hidden = NO;
        
        self.puTongImgBtn.hidden = NO;
        self.puTongTextBtn.hidden = NO;
        self.marryTextBtn.hidden = YES;
        self.marryImageBtn.hidden = YES;
        
    }
    if ([model.type isEqualToString:@"0"]) {//choose
//        self.cententView.textVew.hidden = YES;
//        //默认图片
//        self.deletBtn.hidden = YES;
//        self.cutPicBtn.hidden = YES;
//        self.sureBtn.hidden = YES;
//        self.addBtn.hidden = YES;
        
        self.bgView_nomal.hidden =YES;
        self.bgView_0.hidden = NO;
        
        
    }else if ([model.type isEqualToString:@"1"]) {//wenzi
        self.bgView_0.hidden = YES;
        self.bgView_nomal.hidden = NO;
     //   self.cententView.type =model.type;
        self.imgView.hidden = YES;
       // self.imageView.image = nil;
        self.textView.hidden = NO;
        
        self.textView.layer.borderWidth = 1;
        self.textView.layer.borderColor = ViewColor(212, 183, 173, 1).CGColor;
        self.textView.backgroundColor = ViewColor(248, 248, 248, 1);

        
        self.cutPicBtn.hidden =YES;
        
        if ([model.centent isEqualToString:@"点击开始输入"]) {
            _textView.textColor = [UIColor lightGrayColor];
        }else{
            _textView.textColor = [UIColor blackColor];
            
        }
        self.textView.text = model.centent;
        
    }else if ([model.type isEqualToString:@"2"]) {//tupian
        self.bgView_0.hidden = YES;
         self.bgView_nomal.hidden = NO;
        self.textView.hidden =YES;
        self.textView.text =@"";
        self.imgView.hidden = NO;
      //  self.cententView.type =model.type;
      // self.imageView.backgroundColor = [UIColor blackColor];
//        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imgView.image = nil;
        self.imgView.image = model.img;
        self.imgView.frame = self.cententView.bounds;
        
        //self.imgView.contentMode = UIViewContentModeScaleAspectFit;
//        self.imgView.clipsToBounds =YES;
//        self.cententView.clipsToBounds = YES;
        
    }
    
}
- (IBAction)addNewcell:(UIButton *)sender {
    
    switch (sender.tag) {
        case 9://wenzi
            if (self.add) {
                self.add(@"text");
            }
            break;
        case 10://图片
            if (self.add) {
                self.add(@"pic");
            }
            
            break;
        default:
            break;
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    //设置行间距
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 10.f;
    NSDictionary *dic = @{
                          
                          NSParagraphStyleAttributeName:style
                          
                          };
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:dic];
    
    if ([textView.text hasPrefix:@"点击开始输入"]) {
        textView.text =@"";
        textView.textColor = [UIColor blackColor];
        return YES;
    }
    

    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView isFirstResponder]) {
        if (self.refrshKeyBoard) {
            self.refrshKeyBoard();
        }
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text hasPrefix:@"点击开始输入"]) {
        textView.textColor = [UIColor lightGrayColor];
    }else if (textView.text.length>0)
    {
        textView.textColor = [UIColor blackColor];
        self.model.centent = textView.text;
    }else{
        self.model.centent = @"";
    }
    
    [textView resignFirstResponder];
}



- (IBAction)deletDate:(UIButton *)sender {
    if (self.add) {
        self.add(@"delet");
    }
}



@end
