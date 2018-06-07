//
//  QuestionViewController.m
//  QuizApp
//
//  Created by Sword Software on 18/01/18.
//  Copyright © 2018 Sword Software. All rights reserved.
//

#import "QuestionViewController.h"
#import "ShowScoreController.h"

@interface QuestionViewController ()
@property(strong,nonatomic) NSString *correctAnswer;
@property(strong,nonatomic) NSString *incorrectAnswer1;
@property(strong,nonatomic) NSString *incorrectAnswer2;
@property(strong,nonatomic) NSString *incorrectAnswer3;
@property(strong,nonatomic) NSString *question;
@property(strong,nonatomic) NSMutableArray *answers;
- (IBAction)option1:(id)sender;
- (IBAction)option2:(id)sender;
- (IBAction)option3:(id)sender;
- (IBAction)option4:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *option1Label;
@property (weak, nonatomic) IBOutlet UIButton *option2Label;
@property (weak, nonatomic) IBOutlet UIButton *option3Label;
@property (weak, nonatomic) IBOutlet UIButton *option4Label;
- (IBAction)nextButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *nextButtonLabel;
- (IBAction)submitButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitButtonLabel;

@end

@implementation QuestionViewController
int count = 0;
int correctScore = 0;
int incorrectScore = 0;
int unattempted = 0;


- (void)printFirst:(NSArray*)results{
        NSArray *button = [NSArray arrayWithObjects: self.option3Label,self.option1Label,self.option2Label,self.option4Label, nil];
        NSDictionary *result = [results objectAtIndex:0];
        self.correctAnswer = [result objectForKey:@"correct_answer"] ;
        NSLog(@"correct : %@",self.correctAnswer);
        [self.answers addObject:self.correctAnswer];
        NSArray *incorrect = [result objectForKey:@"incorrect_answers"] ;
        self.incorrectAnswer1 = [incorrect objectAtIndex:0];
        self.incorrectAnswer2 = [incorrect objectAtIndex:1];
        self.incorrectAnswer3 = [incorrect objectAtIndex:2];
        [self.answers addObject:self.incorrectAnswer1];
        [self.answers addObject:self.incorrectAnswer2];
        [self.answers addObject:self.incorrectAnswer3];
        NSLog(@"Answers=%@",self.answers);
        self.question = [result objectForKey:@"question"] ;
        self.questionLabel.text = self.question;
        for(UIButton *but in button)
        {
            int random = arc4random_uniform([self.answers count]);
            [but setTitle:self.answers[random] forState:UIControlStateNormal];
            [self.answers removeObjectAtIndex:random];
        }
//        [self.option2Label setTitle:self.incorrectAnswer1 forState:UIControlStateNormal];
//        [self.option3Label setTitle:self.incorrectAnswer2 forState:UIControlStateNormal];
//        [self.option4Label setTitle:self.incorrectAnswer3 forState:UIControlStateNormal];
        [self.answers removeAllObjects];
}

- (void)printOnLabel:(NSArray*)results{
     NSArray *button = [NSArray arrayWithObjects: self.option3Label,self.option1Label,self.option2Label,self.option4Label, nil];
   [self.option1Label setBackgroundColor:[UIColor colorWithRed:0/255.f green:51/255.f blue:51/255.f alpha:1]];
   [self.option2Label setBackgroundColor:[UIColor colorWithRed:0/255.f green:51/255.f blue:51/255.f alpha:1]];
   [self.option3Label setBackgroundColor:[UIColor colorWithRed:0/255.f green:51/255.f blue:51/255.f alpha:1]];
   [self.option4Label setBackgroundColor:[UIColor colorWithRed:0/255.f green:51/255.f blue:51/255.f alpha:1]];
     self.option3Label.enabled = YES;
     self.option4Label.enabled = YES;
     self.option2Label.enabled = YES;
     self.option1Label.enabled = YES;
   if(count < [self.resultArray count]){
        NSDictionary *result = [results objectAtIndex:count];
        self.correctAnswer = [result objectForKey:@"correct_answer"] ;
        NSLog(@"correct : %@",self.correctAnswer);
        [self.answers addObject:self.correctAnswer];
        NSArray *incorrect = [result objectForKey:@"incorrect_answers"] ;
        self.incorrectAnswer1 = [incorrect objectAtIndex:0];
        self.incorrectAnswer2 = [incorrect objectAtIndex:1];
        self.incorrectAnswer3 = [incorrect objectAtIndex:2];
        [self.answers addObject:self.incorrectAnswer1];
        [self.answers addObject:self.incorrectAnswer2];
        [self.answers addObject:self.incorrectAnswer3];
        NSLog(@"Answers=%@",self.answers);
        self.question = [result objectForKey:@"question"] ;
        self.questionLabel.text = self.question;
        for(UIButton *but in button)
        {
           int random = arc4random_uniform([self.answers count]);
           [but setTitle:self.answers[random] forState:UIControlStateNormal];
           [self.answers removeObjectAtIndex:random];
        }
        [self.answers removeAllObjects];
      }
}


- (void)viewDidLoad {
    [super viewDidLoad];
   // [self.questionLabel setBackgroundColor:[UIColor blueColor]];
    self.navigationItem.hidesBackButton = YES;
    self.answers = [[NSMutableArray alloc]init];
    NSLog(@"Json String on QuestionVC: %@",self.resultArray);
    [self printFirst:self.resultArray];
}

- (IBAction)nextButton:(UIButton *)sender {
    count++;
     if(count == [self.resultArray count]-1)
        {
            sender.hidden = YES;
            self.submitButtonLabel.hidden = NO;
            
        }
    [self printOnLabel:self.resultArray];
//    NSString *buttonName = [sender titleForState:UIControlStateNormal];
//    if([buttonName isEqualToString:@"Submit"])
//        [self performSegueWithIdentifier:@"ShowScore" sender:self];
}

- (IBAction)submitButton:(UIButton *)sender {
    [self performSegueWithIdentifier:@"ShowScore" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ShowScore"])
    {
    ShowScoreController *score = [segue destinationViewController];
    score.correct = correctScore;
    score.inCorrect = incorrectScore;
    score.attempted = correctScore+incorrectScore;
    score.unattempted = (int)[self.resultArray count] -  score.attempted;
}
}

- (IBAction)option1:(id)sender {
    self.option1Label.enabled = NO;
    self.option2Label.enabled = NO;
    self.option3Label.enabled = NO;
    self.option4Label.enabled = NO;
    [sender setBackgroundColor:[UIColor grayColor]];
    NSString *buttonName = [sender titleForState:UIControlStateNormal];
   if([buttonName isEqualToString:self.correctAnswer])
       correctScore++;
    else
    incorrectScore++;
}

- (IBAction)option2:(id)sender {
     self.option1Label.enabled = NO;
    self.option2Label.enabled = NO;
    self.option3Label.enabled = NO;
    self.option4Label.enabled = NO;
    [sender setBackgroundColor:[UIColor grayColor]];
    NSString *buttonName = [sender titleForState:UIControlStateNormal];
    if([buttonName isEqualToString:self.correctAnswer])
        correctScore++;
    else
        incorrectScore++;
}

- (IBAction)option3:(id)sender {
    self.option1Label.enabled = NO;
    self.option2Label.enabled = NO;
    self.option3Label.enabled = NO;
    self.option4Label.enabled = NO;
    [sender setBackgroundColor:[UIColor grayColor]];
    NSString *buttonName = [sender titleForState:UIControlStateNormal];
    if([buttonName isEqualToString:self.correctAnswer])
        correctScore++;
    else
        incorrectScore++;
}

- (IBAction)option4:(id)sender {
    self.option1Label.enabled = NO;
    self.option2Label.enabled = NO;
    self.option3Label.enabled = NO;
    self.option4Label.enabled = NO;
   [sender setBackgroundColor:[UIColor grayColor]];
    NSString *buttonName = [sender titleForState:UIControlStateNormal];
    if([buttonName isEqualToString:self.correctAnswer])
        correctScore++;
    else
        incorrectScore++;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
