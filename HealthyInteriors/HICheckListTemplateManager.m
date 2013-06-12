//
//  HICheckListTemplateManager.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 10/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HICheckListTemplateManager.h"
#import "HICheckListsXMLReader.h"
#import "HICheckListXMLReader.h"

@interface HICheckListTemplateManager ()
    @property(nonatomic, strong) NSArray *checkLists;

    - (void)readCheckLists;

    - (BOOL)loadCheckListModel:(HICheckListModel *)model;

    - (NSString *)templateFileDirectoryForFileNamed:(NSString *)name;

    - (NSDate *)getDateForFile:(NSString *)name;
@end

@implementation HICheckListTemplateManager

    - (id)init {
        if (self = [super init]) {
            [self readCheckLists];
        }
        return self;
    }

    - (void)readCheckLists {

        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error = nil;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"CheckLists.xml"];
        BOOL fileSuccess = [fileManager fileExistsAtPath:documentsDirectory];

        if (!fileSuccess) {
            [fileManager copyItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"CheckLists.xml"] toPath:documentsDirectory error:&error];
        } else {
            //file exists but it might be an older version, so check the date of it and if it is older, copy over
            NSDate *docFileDate = [self getDateForFile:documentsDirectory];
            NSString *bundleFileName = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"CheckLists.xml"];
            NSDate *bundleFileDate = [self getDateForFile:bundleFileName];
            if ([bundleFileDate compare:docFileDate] == 1) {
                [fileManager removeItemAtPath:documentsDirectory error:&error];
                [fileManager copyItemAtPath:bundleFileName toPath:documentsDirectory error:&error];
            }
        }

        //make sure the file exists
        fileSuccess = [fileManager fileExistsAtPath:documentsDirectory];
        if (fileSuccess) {

            //NSXMLParser *xmlEngine = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name]]];
            NSXMLParser *xmlEngine = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:documentsDirectory]];
            HICheckListsXMLReader *reader = [[HICheckListsXMLReader alloc] initXMLParser];
            xmlEngine.delegate = reader;

            //Start parsing the XML file.

            BOOL success = [xmlEngine parse];

            if (success) {

                self.checkLists = [[NSArray alloc] initWithArray:reader.templates];

                for (HICheckListModel *model in self.checkLists) {

                    [self loadCheckListModel:model];
                }

            } else {

                NSLog(@"Error Error Error!!!");

            }
        }
    }

    - (NSString *)getTemplateNameWithIndex:(int)index {
        return ((HICheckListModel *) [self.checkLists objectAtIndex:index]).name;
    }

    - (HICheckListModel *)getTemplateWithIndex:(int)index {
        return ((HICheckListModel *) [self.checkLists objectAtIndex:index]);
    }

    - (BOOL)loadCheckListModel:(HICheckListModel *)model {

        NSString *filename = [self templateFileDirectoryForFileNamed:model.filename];

        if (![filename isEqualToString:@""]) {

            NSXMLParser *xmlEngine = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:filename]];
            HICheckListXMLReader *reader = [[HICheckListXMLReader alloc] initXMLParser];
            reader.checkList = model;
            xmlEngine.delegate = reader;

            //Start parsing the XML file.
            BOOL success = [xmlEngine parse];
            if (success) {
                NSLog(@"No Errors");
                model.isPurchased = YES;
                return YES;
            } else {
                NSLog(@"Error reading file %@", filename);
                model.isPurchased = NO;
                return NO;
            }

        } else {

            model.isPurchased = NO;
            return NO;

        }

    }

    - (int)getNumberOfTemplates {
        return self.checkLists.count;
    }

    - (HICheckListModel *)checkListWithName:(NSString *)name {
        for (HICheckListModel *checkList in self.checkLists) {
            if ([checkList.name isEqualToString:name]) {
                return checkList;
            }
        }

        return nil;

    }

    - (HICheckListModel *)checkListWithID:(NSString *)key {
        for (HICheckListModel *checkList in self.checkLists) {
            if ([checkList.key isEqualToString:key]) {
                return checkList;
            }
        }

        return nil;
    }

    - (HICheckListModel *)checkListWithIndex:(NSUInteger)index {
        return [self.checkLists objectAtIndex:index];
    }

    - (NSString *)templateFileDirectoryForFileNamed:(NSString *)name {

        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error = nil;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDirectoryFileName = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];
        BOOL fileSuccess = [fileManager fileExistsAtPath:docsDirectoryFileName];

        if (!fileSuccess) {
            [fileManager copyItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name] toPath:docsDirectoryFileName error:&error];
        } else {
            //file exists but it might be an older version, so check the date of it and if it is older, copy over
            NSDate *docFileDate = [self getDateForFile:docsDirectoryFileName];
            NSString *bundleFileName = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
            NSDate *bundleFileDate = [self getDateForFile:bundleFileName];
            if ([bundleFileDate compare:docFileDate] == 1) {
                [fileManager removeItemAtPath:docsDirectoryFileName error:&error];
                [fileManager copyItemAtPath:bundleFileName toPath:docsDirectoryFileName error:&error];
            }
        }

        //make sure the file exists
        fileSuccess = [fileManager fileExistsAtPath:docsDirectoryFileName];
        if (fileSuccess) {
            return docsDirectoryFileName;
        } else {
            return @"";
        }

    }

    - (NSDate *)getDateForFile:(NSString *)name {

        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:name error:nil];
        return [attributes fileModificationDate];

    }

    - (HICheckListQuestionModel *)findQuestionWithKey:(NSString *)key {

        for (HICheckListModel *checkList in self.checkLists) {

            HICheckListQuestionModel *question = [checkList findQuestionWithKey:key];
            if (question) {
                return question;
            }
        }
        return nil;
    }

@end
