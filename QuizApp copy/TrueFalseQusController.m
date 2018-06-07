//
//  TrueFalseQusController.m
//  QuizApp
//
//  Created by Sword Software on 24/01/18.
//  Copyright © 2018 Sword Software. All rights reserved.
//

#import "TrueFalseQusController.h"
#import "ShowScoreController.h"

@interface TrueFalseQusController ()
@property (strong,nonatomic) NSString *correctAnswer;
@property (strong,nonatomic) NSString *incorrectAnswer;
@property (strong,nonatomic) NSString *question;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *option1Label;
@property (weak, nonatomic) IBOutlet UIButton *option2Label;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)nextButton:(UIButton *)sender;
- (IBAction)submitButton:(UIButton *)sender;
- (IBAction)option1Button:(id)sender;
- (IBAction)option2Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBox1;
@property (weak, nonatomic) IBOutlet UIButton *checkBox2;
@end

@implementation TrueFalseQusController
int counting =0;
int correctTick = 0;
int incorrectTick = 0;


- (void)printFirst:(NSArray*)results{
    NSDictionary *result = [results objectAtIndex:0];
    self.correctAnswer = [result objectForKey:@"correct_answer"] ;
    NSLog(@"correct : %@",self.correctAnswer);
    NSArray *incorrect = [result objectForKey:@"incorrect_answers"];
    self.incorrectAnswer = [incorrect objectAtIndex:0];
    self.question = [result objectForKey:@"question"] ;
    self.questionLabel.text = self.question;
    [self.option1Label setTitle:@"True" forState:UIControlStateNormal];
    [self.option2Label setTitle:@"False" forState:UIControlStateNormal];
}

- (void)printall:(NSArray*)results{
    self.option1Label.enabled = YES;
    self.option2Label.enabled = YES;
    [self.checkBox1 setBackgroundImage:[UIImage imageNamed:@"Check_box_icon.png"] forState:UIControlStateNormal];
    [self.checkBox2 setBackgroundImage:[UIImage imageNamed:@"Check_box_icon.png"] forState:UIControlStateNormal];
    if(counting < [results count]){
    NSDictionary *result = [results objectAtIndex:counting];
    self.correctAnswer = [result objectForKey:@"correct_answer"] ;
    NSLog(@"correct : %@",self.correctAnswer);
    NSArray *incorrect = [result objectForKey:@"incorrect_answers"];
    self.incorrectAnswer = [incorrect objectAtIndex:0];
    self.question = [result objectForKey:@"question"] ;
    self.questionLabel.text = self.question;
    [self.option1Label setTitle:@"True" forState:UIControlStateNormal];
    [self.option2Label setTitle:@"False" forState:UIControlStateNormal];
   }
}

- (IBAction)nextButton:(UIButton *)sender{
    counting++;
    if(counting == [self.optionalArray count]-1){
        sender.hidden = YES;
        self.submitButton.hidden = NO;
    }
    [self printall:self.optionalArray];
}

- (IBAction)submitButton:(UIButton *)sender{
    [self performSegueWithIdentifier:@"optionalToScore" sender:self ];
}

- (IBAction)option1Button:(id)sender {
    self.option1Label.enabled = NO;
    self.option2Label.enabled = NO;
    [self.checkBox2 setBackgroundImage:[UIImage imageNamed:@"Check_box_icon.png"] forState:UIControlStateNormal];
    [self.checkBox1 setBackgroundImage:[UIImage imageNamed:@"Checkbox_with_Check.png"] forState:UIControlStateNormal];
    NSString *button = [sender titleForState:UIControlStateNormal];
    if([button isEqualToString:self.correctAnswer])
        correctTick++;
    else
        incorrectTick++;
}

- (IBAction)option2Button:(id)sender {
    self.option1Label.enabled = NO;
    self.option2Label.enabled = NO;
    NSString *button = [sender titleForState:UIControlStateNormal];
    [self.checkBox1 setBackgroundImage:[UIImage imageNamed:@"Check_box_icon.png"] forState:UIControlStateNormal];
    [self.checkBox2 setBackgroundImage:[UIImage imageNamed:@"Checkbox_with_Check.png"] forState:UIControlStateNormal];
    if([button isEqualToString:self.correctAnswer])
        correctTick++;
    else
        incorrectTick++;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"optionalToScore"])
    {
        ShowScoreController *score = [segue destinationViewController];
        score.correct = correctTick;
        score.inCorrect = incorrectTick;
        score.attempted = correctTick+incorrectTick;
        score.unattempted = (int)[self.optionalArray count] -  score.attempted;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self printFirst:self.optionalArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
