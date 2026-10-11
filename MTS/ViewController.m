//
//  ViewController.m
//  MTS
//
//  Created by 정찬진 on 10/9/26.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "ProfileViewController.h"

@interface ViewController ()

// 코드로 생성할 UI 요소들 선언
@property (nonatomic, strong) UITextField *idTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"viewDidLoad 실행됨");
    // 1. UI 요소 생성 및 화면에 추가
    [self setupUI];
    
    // 2. Auto Layout 제약 조건 설정 (위치 및 크기 지정)
    [self setupConstraints];
    
    // 3. 기존 로그인 상태 체크x
    BOOL isLoggedIn = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"];
    if (isLoggedIn) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMainViewController];
        });
    }
}

#pragma - UI Setup

- (void)setupUI {
    // 1. 아이디 입력 텍스트필드
    self.idTextField = [[UITextField alloc] init];
    self.idTextField.placeholder = @"아이디를 입력하세요";
    self.idTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.idTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // 첫 글자 자동 대문자 방지
    self.idTextField.translatesAutoresizingMaskIntoConstraints = NO; // 코드로 Auto Layout 설정 시 필수
    [self.view addSubview:self.idTextField];
    
    // 2. 비밀번호 입력 텍스트필드
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.placeholder = @"비밀번호를 입력하세요";
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.secureTextEntry = YES; // 비밀번호 가리기
    self.passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.passwordTextField];
    
    // 3. 로그인 버튼
    self.loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.loginButton setTitle:@"로그인" forState:UIControlStateNormal];
    self.loginButton.backgroundColor = [UIColor systemBlueColor];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius = 8.0; // 모서리 둥글게
    self.loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    // 버튼 클릭 이벤트 연결
    [self.loginButton addTarget:self action:@selector(loginButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    // 4. 상태 표시 라벨
    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.text = @"";
    self.statusLabel.textColor = [UIColor systemRedColor];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.numberOfLines = 0; // 여러 줄 허용
    self.statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.statusLabel];
}

#pragma - Auto Layout Constraints

- (void)setupConstraints {
    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
    
    [NSLayoutConstraint activateConstraints:@[
        // 1. 아이디 텍스트필드 제약 조건
        [self.idTextField.topAnchor constraintEqualToAnchor:safeArea.topAnchor constant:100],
        [self.idTextField.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:40],
        [self.idTextField.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-40],
        [self.idTextField.heightAnchor constraintEqualToConstant:44],
        
        // 2. 비밀번호 텍스트필드 제약 조건 (아이디 아래 16pt)
        [self.passwordTextField.topAnchor constraintEqualToAnchor:self.idTextField.bottomAnchor constant:16],
        [self.passwordTextField.leadingAnchor constraintEqualToAnchor:self.idTextField.leadingAnchor],
        [self.passwordTextField.trailingAnchor constraintEqualToAnchor:self.idTextField.trailingAnchor],
        [self.passwordTextField.heightAnchor constraintEqualToConstant:44],
        
        // 3. 로그인 버튼 제약 조건 (비밀번호 아래 24pt)
        [self.loginButton.topAnchor constraintEqualToAnchor:self.passwordTextField.bottomAnchor constant:24],
        [self.loginButton.leadingAnchor constraintEqualToAnchor:self.idTextField.leadingAnchor],
        [self.loginButton.trailingAnchor constraintEqualToAnchor:self.idTextField.trailingAnchor],
        [self.loginButton.heightAnchor constraintEqualToConstant:50],
        
        // 4. 상태 라벨 제약 조건 (로그인 버튼 아래 20pt)
        [self.statusLabel.topAnchor constraintEqualToAnchor:self.loginButton.bottomAnchor constant:20],
        [self.statusLabel.leadingAnchor constraintEqualToAnchor:self.idTextField.leadingAnchor],
        [self.statusLabel.trailingAnchor constraintEqualToAnchor:self.idTextField.trailingAnchor]
    ]];
}

#pragma - Actions

- (void)loginButtonTapped {
    NSString *userID = self.idTextField.text;
    NSString *password = self.passwordTextField.text;
    
    // 테스트용 검증 (admin / 1234)
    if ([userID isEqualToString:@"admin"] && [password isEqualToString:@"1234"]) {
        // 로그인 성공 시 로컬 저장
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLoggedIn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        self.statusLabel.textColor = [UIColor systemGreenColor];
        self.statusLabel.text = @"로그인 성공!";
        
        // 메인 화면으로 이동
        [self showMainViewController];
    } else {
        self.statusLabel.textColor = [UIColor systemRedColor];
        self.statusLabel.text = @"아이디 또는 비밀번호가 올바르지 않습니다.";
    }
}

// 메인 화면으로 전환하는 메소드
- (void)showMainViewController {
    // 1. 첫 번째 탭 화면 생성 (홈)
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"홈"
                                                      image:[UIImage systemImageNamed:@"house"]
                                                        tag:0];
    
    // 2. 두 번째 탭 화면 생성 (마이페이지/로그아웃)
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    profileVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"마이페이지"
                                                         image:[UIImage systemImageNamed:@"person"]
                                                           tag:1];
    
    // 3. 탭 바 컨트롤러 생성 및 뷰 컨트롤러 배열 연결
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[homeVC, profileVC];
    tabBarController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    // 4. 탭 바 전체를 화면에 띄우기
    [self presentViewController:tabBarController animated:YES completion:nil];
}

- (void)logoutButtonTapped:(UIButton *)sender {
    // 로그인 상태 해제
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLoggedIn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 모달 닫기
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
