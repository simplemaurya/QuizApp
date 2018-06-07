//
//  ConnectionErrorController.m
//  QuizApp
//
//  Created by Sword Software on 25/01/18.
//  Copyright © 2018 Sword Software. All rights reserved.
//

#import "ConnectionErrorController.h"
#import "StartQuizController.h"

@interface ConnectionErrorController ()
- (IBAction)tryAgainButton:(id)sender;

@end

@implementation ConnectionErrorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tryAgainButton:(id)sender {
   for(UIViewController *controller in self.navigationController.viewControllers)
   {
       if([controller isKindOfClass:[StartQuizController class]])
       {
           [self.navigationController popToViewController:controller animated:YES];
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
