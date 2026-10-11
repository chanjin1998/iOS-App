//
//  ProfileViewController.m
//  MTS
//
//  Created by 정찬진 on 10/12/26.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@end

@implementation ProfileViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    // 로그아웃 버튼 추가
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [logoutButton setTitle:@"로그아웃" forState:UIControlStateNormal];
    logoutButton.frame = CGRectMake(0, 0, 200, 50);
    logoutButton.center = self.view.center;
    [logoutButton addTarget:self action:@selector(logoutButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
}

- (void)logoutButtonTapped {
    // 로그인 상태 해제
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLoggedIn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 탭바 컨트롤러(현재 모달) 전체 닫기
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
