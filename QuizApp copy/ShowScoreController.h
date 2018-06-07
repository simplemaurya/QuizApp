//
//  ShowScoreController.h
//  QuizApp
//
//  Created by Sword Software on 23/01/18.
//  Copyright © 2018 Sword Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowScoreController : UIViewController
@property(nonatomic) int correct;
@property(nonatomic) int inCorrect;
@property(nonatomic) int attempted;
@property(nonatomic) int unattempted;
@end
