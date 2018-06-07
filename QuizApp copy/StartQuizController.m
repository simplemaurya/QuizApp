//
//  StartQuizController.m
//  QuizApp
//
//  Created by Sword Software on 16/01/18.
//  Copyright © 2018 Sword Software. All rights reserved.
//

#import "StartQuizController.h"

@interface StartQuizController ()
@property (weak, nonatomic) IBOutlet UILabel *username;

@end

@implementation StartQuizController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.username.text = self.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
