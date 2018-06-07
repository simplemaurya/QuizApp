//
//  ShowScoreController.m
//  QuizApp
//
//  Created by Sword Software on 23/01/18.
//  Copyright © 2018 Sword Software. All rights reserved.
//

#import "ShowScoreController.h"
#import "StartQuizController.h"

@interface ShowScoreController ()
@property (weak, nonatomic) IBOutlet UILabel *attemptedLabel;
@property (weak, nonatomic) IBOutlet UILabel *unattemptedLabel;
@property (weak, nonatomic) IBOutlet UILabel *correctLabel;
@property (weak, nonatomic) IBOutlet UILabel *incorrectLabel;


@end

@implementation ShowScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    NSString *user = [[NSUserDefaults standardUserDefaults] stringForKey:@"User"];
    self.correctLabel.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithInt: self.correct]] ;
    self.incorrectLabel.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithInt: self.inCorrect]] ;
    self.attemptedLabel.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithInt: self.attempted]] ;
    self.unattemptedLabel.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithInt: self.unattempted]] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionReTest:(id)sender {
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        //Do not forget to import AnOldViewController.h
        if ([controller isKindOfClass:[StartQuizController class]]) {
            
            [self.navigationController popToViewController:controller
                           animated:YES];
            break;
        }
    }
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
