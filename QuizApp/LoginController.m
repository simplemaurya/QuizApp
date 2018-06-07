//
//  LoginController.m
//  QuizApp
//
//  Created by Sword Software on 16/01/18.
//  Copyright © 2018 Sword Software. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()
@property (weak, nonatomic) IBOutlet UITextField *emailIdTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
- (IBAction)logIn:(UIButton *)sender;
@property (strong,nonatomic) NSString *user ;

@end

@implementation LoginController

- (void)setViewMovedUp:(BOOL)moved{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect rect = self.view.frame;
    if(moved)
    {
        rect.origin.y -= 40;
        rect.size.height += 40;
    }
    else{
        rect.origin.y += 40;
        rect.size.height -= 40;
    }
    self.view.frame = rect;
    [UIView commitAnimations];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == self.passwordTF)
    {
        if(self.view.frame.origin.y >= 0)
        {  
            [self setViewMovedUp:YES];
            }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if([textField isEqual:self.passwordTF])
    {
        if(self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }}
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)logIn:(UIButton *)sender {
   NSArray *result = [[DBManager db]fetchFromRegister:self.emailIdTF.text];
    self.user = [result objectAtIndex:0];
    NSLog(@"%@", self.user);
    NSString *pass = [result objectAtIndex:1];
    [[NSUserDefaults standardUserDefaults]setObject:self.user forKey:@"User"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if(pass)
    {
    if([pass isEqualToString:self.passwordTF.text])
     {
        [self performSegueWithIdentifier:@"QuizStart" sender:self];
     }
    else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"ALERT"  message:@"Please enter correct password." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
     }
   }
    else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"ALERT"  message:@"User does not exist." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"QuizStart"]){
        StartQuizController *des = [segue destinationViewController];
        des.name = self.user;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.passwordTF.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
