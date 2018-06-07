//
//  ViewController.m
//  QuizApp
//
//  Created by Sword Software on 15/01/18.
//  Copyright © 2018 Sword Software. All rights reserved.
//

#import "SignUpController.h"

@interface SignUpController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailIDTF;
@property (weak, nonatomic) IBOutlet UITextField *contactTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTF;
- (IBAction)signUp:(UIButton *)sender;

@end

@implementation SignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[DBManager db]createDatabase];
    self.usernameTF.delegate =self;
    self.emailIDTF.delegate =self;
    self.contactTF.delegate =self;
    self.passwordTF.delegate =self;
    self.rePasswordTF.delegate =self;
    
//    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [scrollview addSubview:self.usernameTF];
//    [scrollview addSubview:self.emailIDTF];
//    [scrollview addSubview:self.contactTF];
//    [scrollview addSubview:self.passwordTF];
//    [scrollview addSubview:self.rePasswordTF];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown) name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
//
    }

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:UIKeyboardWillHideNotification object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//- (void)keyboardWasShown{
//    if(self.view.frame.origin.y >=0){
//        [self setViewMovedUp :YES];
//    }
//    else if(self.view.frame.origin.y < 0)
//    {
//        [self setViewMovedUp :NO];
//    }
//}
//
//-(void)keyboardWillHide{
//    if(self.view.frame.origin.y >=0){
//        [self setViewMovedUp :YES];
//    }
//    else if(self.view.frame.origin.y < 0)
//    {
//        [self setViewMovedUp :NO];
//    }
//}

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

-(void)textFieldDidBeginEditing:(UITextField*)sender {
    if([sender isEqual:self.usernameTF])
    {
        if(self.view.frame.origin.y >=0)
            [self setViewMovedUp:YES];
    }
    else if([sender isEqual:self.emailIDTF])
    {
        if(self.view.frame.origin.y >=0)
            [self setViewMovedUp:YES];
    }
    else if([sender isEqual:self.contactTF])
    {
        if(self.view.frame.origin.y >=0)
            [self setViewMovedUp:YES];
    }
    else if([sender isEqual:self.rePasswordTF])
    {
        if(self.view.frame.origin.y >=0)
            [self setViewMovedUp:YES];
    }
    else if([sender isEqual:self.passwordTF])
    {
        if(self.view.frame.origin.y >=0)
            [self setViewMovedUp:YES];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)sender{
    if([sender isEqual:self.usernameTF])
    {
        if(self.view.frame.origin.y < 0)
            [self setViewMovedUp:NO];
    }
    else if([sender isEqual:self.emailIDTF])
    {
        if(self.view.frame.origin.y < 0)
            [self setViewMovedUp:NO];
    }
    else if([sender isEqual:self.contactTF])
    {
        if(self.view.frame.origin.y < 0)
            [self setViewMovedUp:NO];
    }
    else if([sender isEqual:self.rePasswordTF])
    {
        if(self.view.frame.origin.y < 0)
            [self setViewMovedUp:NO];
    }
    else if([sender isEqual:self.passwordTF])
    {
        if(self.view.frame.origin.y < 0)
            [self setViewMovedUp:NO];
    }
}

- (IBAction)signUp:(UIButton *)sender {
    if(([self.usernameTF.text isEqualToString:@""] ||[self.passwordTF.text isEqualToString:@""] ||[self.rePasswordTF.text isEqualToString:@""] ||[self.contactTF.text isEqualToString:@""] ||[self.emailIDTF.text isEqualToString:@""])){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"ALERT"  message:@"Please fill all details..!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if(!([self.passwordTF.text isEqualToString:self.rePasswordTF.text])){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"ALERT"  message:@"Please enter the password same as password." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{ [[DBManager db]insertToRegister:self.usernameTF.text email:self.emailIDTF.text contact:self.contactTF.text password:self.passwordTF.text rePassword:self.rePasswordTF.text  ];
        [self performSegueWithIdentifier:@"logIn" sender:self];
    }
}
@end
