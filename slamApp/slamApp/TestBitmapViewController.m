//
//  TestBitmapViewController.m
//  slamApp
//
//  Created by 德志 on 2017/12/11.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

#define Mask8(x) ( (x) & 0xFF)
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )
#define RGBAMake(r, g, b, a) ( Mask8(r)<< 16 | Mask8(g) << 8 | Mask8(b)| Mask8(a) << 24 )

#import "TestBitmapViewController.h"

@interface TestBitmapViewController ()

@property(nonatomic ,strong) UIImageView* imageView;

@end

@implementation TestBitmapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = YES;
    // Do any additional setup after loading the view.
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
    [self.view addSubview: self.imageView];
    self.imageView.backgroundColor = [UIColor greenColor];
    
//    UIImage * image = [UIImage imageNamed:@"bitmap"];
//    CFDataRef rawData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
//    NSData *my_nsdata = (__bridge NSData*)rawData;
//
//
//    CGImageRef imagetest =  [self imageRefFromBGRABytes:rawData imageSize:CGSizeMake( CGImageGetWidth(image.CGImage),  CGImageGetHeight(image.CGImage))];
//
//    UIImage * imagetesttwo = [UIImage imageWithCGImage:imagetest];
    
    UIImage* date =  [self createimage:200 height:200];
    [self.imageView setImage:date];
}


- (unsigned char *)pixelBRGABytesFromImageRef:(CGImageRef)imageRef {
    
    NSUInteger iWidth = CGImageGetWidth(imageRef);
    NSUInteger iHeight = CGImageGetHeight(imageRef);
    NSUInteger iBytesPerPixel = 4;
    NSUInteger iBytesPerRow = iBytesPerPixel * iWidth;
    NSUInteger iBitsPerComponent = 8;
    unsigned char *imageBytes = malloc(iWidth * iHeight * iBytesPerPixel);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(imageBytes,
                                                 iWidth,
                                                 iHeight,
                                                 iBitsPerComponent,
                                                 iBytesPerRow,
                                                 colorspace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    
    CGRect rect = CGRectMake(0 , 0 , iWidth , iHeight);
    CGContextDrawImage(context , rect ,imageRef);
    CGColorSpaceRelease(colorspace);
    CGContextRelease(context);
    CGImageRelease(imageRef);

    return imageBytes;
}


- (CGImageRef)imageRefFromBGRABytes:(unsigned char *)imageBytes imageSize:(CGSize)imageSize {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(imageBytes,
                                                 imageSize.width,
                                                 imageSize.height,
                                                 8,
                                                 imageSize.width*4,
                                                 colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return imageRef;
}



#pragma mark -OC创建bitmap
-(UIImage*)createimage:(NSUInteger)width height:(NSUInteger)height{
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel*width;
    NSUInteger bitsPerComponent = 8;
    
    UInt32 * pixels;
    pixels = (UInt32 *) calloc(height*width,sizeof(UInt32));
    
    CGColorSpaceRef colorSpace =     CGColorSpaceCreateDeviceRGB();
    CGContextRef context =     CGBitmapContextCreate(pixels, width, height, bitsPerComponent, bytesPerRow, colorSpace,     kCGImageAlphaPremultipliedLast |     kCGBitmapByteOrder32Big);
    
    for (NSUInteger j = 0; j < width; j++) {
        for (NSUInteger i = 0; i < height; i++) {
            UInt32 *currentPixel = pixels + (width * j) + i;
            *currentPixel = RGBAMake(0, 0, 255, A(1));
        }
    }
    
    CGImageRef newCGImage =     CGBitmapContextCreateImage(context);
    UIImage * processedImage = [UIImage     imageWithCGImage:newCGImage];
    
    // 释放资源
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    free(newCGImage);
    free(pixels);
    
    return processedImage;
}




@end
