//
//  eidtFanJuModel.m
//  yuefan
//
//  Created by zhangz on 15/11/13.
//  Copyright © 2015年 dtdxunlei. All rights reserved.
//

#import "eidtFanJuModel.h"

@implementation eidtFanJuModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type =@"0";//choose
        
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.centent forKey:@"centent"];
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeObject:self.tag forKey:@"tag"];
    [aCoder encodeObject:self.gifData forKey:@"gifData"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.centent = [aDecoder decodeObjectForKey:@"centent"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.tag = [aDecoder decodeObjectForKey:@"tag"];
         self.gifData = [aDecoder decodeObjectForKey:@"gifData"];
    }
    return self;
}

+(eidtFanJuModel *)addTextCellModel{
    eidtFanJuModel *model = [[eidtFanJuModel alloc]init];
    model.type = @"1";//wenzi
    model.centent = @"点击开始输入";
    return model;
}

+(eidtFanJuModel *)addPicCellModel:(UIImage*)img{
    eidtFanJuModel *model = [[eidtFanJuModel alloc]init];
    model.type = @"2";//图片
    model.img = [self imageCompressForWidth:img targetWidth:570.0];
    return model;
}
//+(eidtFanJuModel *)coverModel:(UIImage*)img{
//    eidtFanJuModel *model = [[eidtFanJuModel alloc]init];
//    model.type = @"2";//图片
//    model.img = [self imageCompressForWidth:img targetWidth:570.0];
//    return model;
//}

#pragma mark - 等比例压缩
+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

@end
