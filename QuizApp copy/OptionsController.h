//
//  OptionsController.h
//  QuizApp
//
//  Created by Sword Software on 17/01/18.
//  Copyright © 2018 Sword Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionViewController.h"
@interface OptionsController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
@property (nonatomic) long cate;

@end
