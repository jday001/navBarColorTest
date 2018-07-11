//
//  DetailViewController.m
//  NavBarColorTest
//
//  Created by Jeff Day on 3/11/15.
//  Copyright (c) 2015 JDay Apps, LLC. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *foregroundImageView;
@end



@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRoundImageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.backgroundImageView.image = self.backgroundImage;
    
    // set navBar color based on a pixel in the background image
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    // TODO: if navBar has a background image, just set it to nil?
    /*self.navigationController.navigationBar.barTintColor = [self pixelColorInImage:self.backgroundImage
                                                                               atX:0
                                                                               atY:0
                                                                         withAlpha:0.2f];
     */
}

    
- (void)setupRoundImageView {
    
    // create layer mask for the image/button
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    self.foregroundImageView.layer.mask = maskLayer;
    
    // create shape layer for circle we'll draw on top of image (the boundary of the circle)
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.lineWidth = 3.0;
    circleLayer.fillColor = [[UIColor clearColor] CGColor];
    circleLayer.strokeColor = [[UIColor blackColor] CGColor];
    [self.foregroundImageView.layer addSublayer:circleLayer];
    
    // create circle path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(self.foregroundImageView.bounds.size.width / 2.0, self.foregroundImageView.bounds.size.height / 2.0)
                    radius:self.foregroundImageView.bounds.size.width * 0.50
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    
    maskLayer.path = [path CGPath];
}

- (UIColor *)pixelColorInImage:(UIImage *)image atX:(int)x atY:(int)y withAlpha:(float)alpha {
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    const UInt8 *data = CFDataGetBytePtr(pixelData);
    
    int pixelInfo = ((image.size.width  * y) + x ) * 4; // 4 bytes per pixel
    
    UInt8 red   = data[pixelInfo + 0];
    UInt8 green = data[pixelInfo + 1];
    UInt8 blue  = data[pixelInfo + 2];
    CFRelease(pixelData);
    
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f]; // The pixel color info
}

@end
