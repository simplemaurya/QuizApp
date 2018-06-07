//
//  DBManager.m
//  QuizApp
//
//  Created by Sword Software on 15/01/18.
//  Copyright © 2018 Sword Software. All rights reserved.
//

#import "DBManager.h"

@interface DBManager(){
    sqlite3_stmt *statement;
    sqlite3 *sqldatabase;
}
@end
@implementation DBManager
static DBManager *database;
NSString *dbFilename = @"QuizApp.sqlite";

+ (DBManager*)db{
    if(database == nil)
     database = [[DBManager alloc]init];
        return database;
}

- (NSString*)getDBPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucmentsDir = [paths objectAtIndex:0];
    return [doucmentsDir stringByAppendingPathComponent:dbFilename];
}

- (void)createDatabase{
    NSString *path = [self getDBPath];
    NSLog(@"Path : %@",path);
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == FALSE)
    {
        if(sqlite3_open([path UTF8String],&sqldatabase) == SQLITE_OK)
        {
            char *errMSg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS REGISTER (USERID INTEGER PRIMARY KEY AUTOINCREMENT,USERNAME TEXT,EMAIL_ID TEXT,CONTACT TEXT,PASSWORD TEXT,RE_PASSWORD TEXT)";
            NSLog(@"%s SQL error '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(sqldatabase), sqlite3_errcode(sqldatabase));
            if(sqlite3_exec(sqldatabase, sql_stmt, NULL, NULL, &errMSg) != SQLITE_OK){
                NSLog(@"Failed to create table");
            }
            sqlite3_close(sqldatabase);
    }
        else{
            NSLog(@"Failed to open/create database");
        }
    }
}

- (void)insertToRegister:(NSString*)Username email:(NSString*)Email_ID contact:(NSString*)Contact password:(NSString*)Password rePassword:(NSString*)Re_Password{
    NSString *path = [self getDBPath];
    if(sqlite3_open([path UTF8String], &sqldatabase) == SQLITE_OK)
    {
        const char *insert = "Insert into REGISTER( USERNAME,EMAIL_ID,CONTACT,PASSWORD,RE_PASSWORD) VALUES (?,?,?,?,?)";
       if(sqlite3_prepare_v2(sqldatabase, insert, -1, &statement, NULL) != SQLITE_OK)
           NSLog(@"Error while creating add statement");
        sqlite3_bind_text(statement, 1, [Username UTF8String], -1, SQLITE_TRANSIENT);
         sqlite3_bind_text(statement, 2, [Email_ID UTF8String], -1, SQLITE_TRANSIENT);
         sqlite3_bind_text(statement, 3, [Contact UTF8String], -1, SQLITE_TRANSIENT);
         sqlite3_bind_text(statement, 4, [Password UTF8String], -1, SQLITE_TRANSIENT);
         sqlite3_bind_text(statement, 5, [Re_Password UTF8String], -1, SQLITE_TRANSIENT);
        if(sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Data added..!");
        }
        else {
            NSLog(@"Data not added...!");
        }
        sqlite3_finalize(statement);
        sqlite3_close(sqldatabase);
    }
}

- (NSArray*)fetchFromRegister:(NSString*)Email_ID
{
    NSString *path = [self getDBPath];
    if(sqlite3_open([path UTF8String], &sqldatabase) == SQLITE_OK)
    {
        NSString *fetchQuery = [NSString stringWithFormat:@"select USERNAME,PASSWORD from REGISTER where EMAIL_ID=\"%@\"",Email_ID];
        NSString *password,*username;
        NSMutableArray *result;
        if(sqlite3_prepare_v2(sqldatabase, [fetchQuery UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {   result = [[NSMutableArray alloc]init];
                username = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                  password = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                [result addObject:username];
                [result addObject:password];
                return result;
            }
            else{
                NSLog(@"No user exist with this name,Please try again");
                return nil;
            }
          }
        else{
          NSLog(@"%s SQL error '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(sqldatabase), sqlite3_errcode(sqldatabase));
            return nil;
        }
    }
    else{
        NSLog(@"%s SQL error '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(sqldatabase), sqlite3_errcode(sqldatabase));
        return nil;
    }
}

@end
