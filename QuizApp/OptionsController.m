//
//  OptionsController.m
//  QuizApp
//
//  Created by Sword Software on 17/01/18.
//  Copyright © 2018 Sword Software. All rights reserved.
//

#import "OptionsController.h"
#import "QuestionViewController.h"
#import "TrueFalseQusController.h"

@interface OptionsController (){
    NSArray *noOfQus;
    NSArray *difficultyLevel;
    NSArray *typeOfQus;
    NSMutableData *responseData;
}
@property (weak, nonatomic) IBOutlet UITextField *numberOfQusTF;
@property (weak, nonatomic) IBOutlet UITextField *difficultyLevelTF;
@property (weak, nonatomic) IBOutlet UITextField *typeOfQusTF;
@property (weak, nonatomic) IBOutlet UIPickerView *NumberOfQusPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *DifficultyLevelPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *TypeOfQusPicker;
//@property (nonatomic, strong) NSMutableData *receivedData;
- (IBAction)PlayButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong,nonatomic) NSArray *results;

@property (nonatomic) BOOL isFinished;

typedef void(^myCompletion)(BOOL);

@end

@implementation OptionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicator.hidden = YES;
    self.numberOfQusTF.delegate = self;
    self.difficultyLevelTF.delegate =self;
    self.typeOfQusTF.delegate = self;
    // Do any additional setup after loading the view.
    noOfQus = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40", nil];
    difficultyLevel = [[NSArray alloc] initWithObjects:@"easy",@"medium",@"hard", nil];
    typeOfQus = [[NSArray alloc] initWithObjects:@"Multiple Choice",@"True/False",nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView == self.NumberOfQusPicker)
    return noOfQus.count;
    else if(pickerView.tag == 2)
        return difficultyLevel.count;
    else return [typeOfQus count];
}

- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag == 1)
    return noOfQus[row];
    else if(pickerView.tag == 2)
        return difficultyLevel[row];
    else return typeOfQus[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView.tag == 1)
    {
        self.numberOfQusTF.text = noOfQus[row];
        self.NumberOfQusPicker.hidden = YES;
    }
    else if(pickerView.tag == 2){
        self.difficultyLevelTF.text = difficultyLevel[row];
        self.DifficultyLevelPicker.hidden = YES;
    }
    else {
        self.typeOfQusTF.text = typeOfQus[row];
        self.TypeOfQusPicker.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.view endEditing:YES];
    if(textField.tag == 1)
    {
        //self.numberOfQusTF.inputView = self.NumberOfQus;
        self.TypeOfQusPicker.hidden = YES;
        self.DifficultyLevelPicker.hidden = YES;
        self.NumberOfQusPicker.hidden = NO;
    }
    else if(textField.tag == 2)
    {
        self.NumberOfQusPicker.hidden = YES;
        self.TypeOfQusPicker.hidden = YES;
        self.DifficultyLevelPicker.hidden = NO;
    }
    else
    {
        self.DifficultyLevelPicker.hidden = YES;
        self.NumberOfQusPicker.hidden = YES;
        self.TypeOfQusPicker.hidden = NO;
    }
}

- (void)calltoTrivia:(long)amount category:(long)category difficulty:(NSString*)difficulty type:(NSString*)type  {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://opentdb.com/api.php?amount=%ld&category=%ld&difficulty=%@&type=%@",amount,category,difficulty,type]];
    NSLog(@"URL = %@", url);
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(nonnull NSURLResponse *)response{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    if([httpResponse statusCode]>400)
        NSLog(@"Error while getting data");
    responseData = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection * )connection didFailWithError:(nonnull NSError *)error{
    NSLog(@"Error :%@",error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSError *error;
    NSDictionary *jsonString = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSLog(@"jsonString on optionsVC = %@",jsonString);
    self.results = [jsonString objectForKey:@"results"];
     self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
    self.isFinished = YES;
}

- (IBAction)PlayButton:(id)sender {
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    if([self.typeOfQusTF.text isEqualToString:@"Multiple Choice"])
    {
        [self calltoTrivia:[self.numberOfQusTF.text integerValue] category:self.cate difficulty:self.difficultyLevelTF.text type:@"multiple"];
        if(self.isFinished)
        {
          if(self.results == nil){
            [self performSegueWithIdentifier:@"ConnectionError" sender:self];
           }
          else{
            [self performSegueWithIdentifier:@"Optional" sender:self];
           }
        }}
    else if([self.typeOfQusTF.text isEqualToString:@"True/False"]) {
        [self calltoTrivia:[self.numberOfQusTF.text integerValue] category:self.cate difficulty:self.difficultyLevelTF.text type:@"boolean" ];
        if(self.isFinished)
        {
          if(self.results == nil){
                    [self performSegueWithIdentifier:@"ConnectionError" sender:self];
                }
          else{
                    [self performSegueWithIdentifier:@"TrueFalse" sender:self];
              }
        }
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
      if ([segue.identifier isEqualToString:@"Optional"]) {
          QuestionViewController *destViewController = segue.destinationViewController;
          destViewController.resultArray = self.results;
          //NSLog(@"Result array : %@", destViewController.resultArray);
          }
      else if([segue.identifier isEqualToString:@"TrueFalse"]){
          TrueFalseQusController *optional = [segue destinationViewController];
          optional.optionalArray = self.results;
      }
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation

 */
@end
