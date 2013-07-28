//
//  DetailViewController.h
//  TestiPadApp
//
//  Created by Mark O'Flynn on 13/07/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property(strong, nonatomic) id detailItem;

@property(weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
