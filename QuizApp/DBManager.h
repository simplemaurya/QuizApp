//
//  DBManager.h
//  QuizApp
//
//  Created by Sword Software on 15/01/18.
//  Copyright © 2018 Sword Software. All rights reserved.
//

#import <Foundation/Foundation.h>
# import "sqlite3.h"
@interface DBManager : NSObject
- (NSString*)getDBPath;
- (void)createDatabase;
+ (DBManager*)db;
-(void) insertToRegister:(NSString*)Username email:(NSString*)Email_ID contact:(NSString*)Contact password:(NSString*)Password rePassword:(NSString*)Re_Password;
- (NSArray*)fetchFromRegister:(NSString*)Email_ID;
@end
