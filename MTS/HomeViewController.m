//
//  HomeViewController.m
//  MTS
//
//  Created by 정찬진 on 10/12/26.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"메인 홈 화면입니다";
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, 300, 50);
    label.center = self.view.center;
    [self.view addSubview:label];
}

@end
