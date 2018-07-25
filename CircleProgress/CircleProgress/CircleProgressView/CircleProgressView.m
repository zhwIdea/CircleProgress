//
//  CircleProgressView.m
//  LocatorWatch
//
//  Created by hongwei Zheng on 2018/7/19.
//  Copyright © 2018年 hongwei Zheng. All rights reserved.
//

#import "CircleProgressView.h"
#import <QuartzCore/QuartzCore.h>

#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self;

@interface CircleProgressView ()<CAAnimationDelegate>
{
    UIBezierPath *path;
        NSTimer  *progressTimer;
        CGFloat  xCenter;
        CGFloat  yCenter;
}

@property (nonatomic,assign) CGFloat      i;
@property (nonatomic,strong) CAShapeLayer *arcLayer;
@property (nonatomic,strong) UILabel      *walkLab;
@property (nonatomic,strong) UILabel      *stepLabel;


@end

@implementation CircleProgressView


 #define ViewWidth self.frame.size.width   //环形进度条的视图宽度
 #define ProgressWidth 6.0                 //环形进度条的圆环宽度
 #define Radius ViewWidth/2-ProgressWidth  //环形进度条的半径


 -(id)initWithFrame:(CGRect)frame
 {
       self = [super initWithFrame:frame];
        if (self) {
                self.backgroundColor = [UIColor clearColor];
           }
       return self;
}

 -(void)drawRect:(CGRect)rect{
     if (path) {
         [path removeAllPoints]; //刷新重绘时，移除之前所有的点
     }
     if (_arcLayer) {
        [_arcLayer removeFromSuperlayer];//刷新重绘时，移除之前的Layer
     }
     
         _i = 0;
    
         CGContextRef progressContext = UIGraphicsGetCurrentContext();
         CGContextSetLineWidth(progressContext, ProgressWidth);
         CGContextSetRGBStrokeColor(progressContext,157.0/255.0, 227.0/255.0, 226.0/255.0, 0.6);
  
         xCenter = rect.size.width * 0.5;
         yCenter = rect.size.height * 0.5;
   
         //绘制环形进度条底框
         CGContextAddArc(progressContext, xCenter, yCenter, Radius, 0.5 * M_PI, 2.5 * M_PI, 0);
         CGContextDrawPath(progressContext, kCGPathStroke);
    
         //绘制环形进度环
         CGFloat to = (self.progress * M_PI * 2.0) + 0.5 * M_PI; // - M_PI * 0.5为改变初始位置
     
   
        path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(xCenter,yCenter) radius:Radius startAngle:0.5 * M_PI  endAngle:to  clockwise:YES];
    
         _arcLayer = [CAShapeLayer layer];
         _arcLayer.path = path.CGPath;
         _arcLayer.fillColor = [UIColor clearColor].CGColor;
         _arcLayer.strokeColor = [UIColor greenColor].CGColor;
         _arcLayer.lineWidth = ProgressWidth;
         [self.layer addSublayer:_arcLayer];
   
          WS(weakSelf);
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [weakSelf drawLineAnimation:weakSelf.arcLayer];
            });
     
      //加载label
      [self CreateLabel];
    
       if (self.progress > 1) {
               NSLog(@"传入数值范围为 0-1");
               self.progress = 1;
            }else if (self.progress < 0){
                     NSLog(@"传入数值范围为 0-1");
                    self.progress = 0;
                    return;
               }
   
       if (self.progress > 0) {
                 NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(newThread) object:nil];
                [thread start];
             }
   
}


-(void)CreateLabel{
    
    //walk
    if (!_walkLab) {
        _walkLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,Radius+10, ViewWidth/6)];
        _walkLab.center = CGPointMake(xCenter - 5 , yCenter - 30);
        _walkLab.textColor = [UIColor greenColor];
        _walkLab.textAlignment = NSTextAlignmentCenter;
        _walkLab.text = @"Walk";
        _walkLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:_walkLab];
    }
  
    if (!_stepLabel) {
        //运动步数
        _stepLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,Radius+10, ViewWidth/6)];
        _stepLabel.textColor = [UIColor greenColor];
        _stepLabel.center = CGPointMake(xCenter , yCenter + 15);
        _stepLabel.textAlignment = NSTextAlignmentCenter;
        _stepLabel.font = [UIFont systemFontOfSize:25];
        _stepLabel.text = @"0 步";
        [self addSubview:_stepLabel];
    }
  
    
}


 -(void)newThread
 {
         @autoreleasepool {
                progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.0001 target:self selector:@selector(timeLabel) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] run];
            }
 }

//计时器方法调用
 -(void)timeLabel
 {
     _i += 0.0001;
     
     //当 “i” 的值大于等于 progress，销毁定时器，终止循环
     if ((_i + 0.0001) >= self.progress) {
         [progressTimer invalidate];
         progressTimer = nil;
      //   NSLog(@"_i == %f",_i);
      //   NSLog(@"progress == %f",self.progress);
       }else{
           WS(weakSelf);
           dispatch_async(dispatch_get_main_queue(), ^{
              weakSelf.stepLabel.text = [NSString stringWithFormat:@"%.0f 步",weakSelf.i * 10000];
               //将 “步” 字号设为15
               NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:weakSelf.stepLabel.text];
               [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(weakSelf.stepLabel.text.length - 1 , 1)];
              weakSelf.stepLabel.attributedText = str;
           });
       }
}


//定义动画过程
 -(void)drawLineAnimation:(CALayer*)layer
{
         CABasicAnimation *bas = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
         bas.duration = 1.0;//动画时间
         bas.delegate = self;
         bas.fromValue = [NSNumber numberWithInteger:0];
         bas.toValue = [NSNumber numberWithInteger:1];
        [layer addAnimation:bas forKey:@"key"];
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
