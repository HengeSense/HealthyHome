//
//  HIQuestionInfoViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 11/03/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIQuestionInfoViewController.h"

@interface HIQuestionInfoViewController ()
@property(nonatomic, assign) BOOL isFavourite;
@property(nonatomic, strong) UIBarButtonItem *favouriteButton;

- (void)updateFavouriteIcon;
@end

@implementation HIQuestionInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Healthy Info Tip";

    self.favouriteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"star-mini"] style:UIBarButtonItemStylePlain target:self action:@selector(favourite)];

    self.navigationItem.rightBarButtonItem = self.favouriteButton;

    self.infoTitleLabel.text = self.questionModel.infoTitle;

    self.infoView.backgroundColor = [UIColor clearColor];
    self.infoView.opaque = NO;

    if (self.isModal) {

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(close)];

    }

    [self updateFavouriteIcon];

    self.infoView.delegate = self;

    NSString *cssElement = @"<link href=\"default.css\" rel=\"stylesheet\" type=\"text/css\" />";
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];

    UIFont *font = [UIFont systemFontOfSize:21];

    //http://kiefermat.com/2011/09/30/using-uiwebview-for-displaying-rich-text/
    NSString *htmlContentString = [NSString stringWithFormat:
            @"<html>"
                    "<head>"
                    "%@"
                    "</head>"
                    "<body>"
                    "<p>%@</p>"
                    "</body></html>", cssElement, self.questionModel.information];

    NSString *myDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
                                                                     "<head> \n"
                                                                     "<style type=\"text/css\"> \n"
                                                                     "body {font-family: \"%@\"; font-size: %d; padding:5px 10px;}\n"
                                                                     "</style> \n"
                                                                     "</head> \n"
                                                                     "<body>%@</body> \n"
                                                                     "</html>", font.familyName, 18, self.questionModel.information];

    [self.infoView loadHTMLString:myDescriptionHTML baseURL:baseURL];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDataModelChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.managedObjectContext];

}

- (void)updateFavouriteIcon {
    self.isFavourite = [self.delegate isFavourite];
    if (self.isFavourite) {

        self.favouriteButton.style = UIBarButtonItemStyleDone;
        self.favouriteButton.image = [UIImage imageNamed:@"star-mini-white"];

    }
}

- (void)close {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)favourite {
    if (self.isFavourite) {
        if ([self.delegate removeFavourite]) {
            self.favouriteButton.style = UIBarButtonItemStylePlain;
            self.favouriteButton.image = [UIImage imageNamed:@"star-mini"];
        }

    } else {

        if ([self.delegate addFavourite]) {
            self.favouriteButton.style = UIBarButtonItemStyleDone;
            self.favouriteButton.image = [UIImage imageNamed:@"star-mini-white"];
        }
    }
    self.isFavourite = [self.delegate isFavourite];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }

    return YES;
}

- (void)viewDidUnload {
    [self setInfoTitleLabel:nil];
    [super viewDidUnload];
}

- (void)handleDataModelChange:(NSNotification *)note {
//    NSSet *updatedObjects = [[note userInfo] objectForKey:NSUpdatedObjectsKey];
//    NSSet *deletedObjects = [[note userInfo] objectForKey:NSDeletedObjectsKey];
//    NSSet *insertedObjects = [[note userInfo] objectForKey:NSInsertedObjectsKey];
//    [self updateNotesBadge];
//    [self updateImagesBadge];

    // Do something in response to this

//        if (deletedObjects.count > 0) {
//
//            for (id item in deletedObjects) {
//
//               if ([item isKindOfClass:[Favourites class]]);
//
//                Favourites * thisItem = item;
//                if ([thisItem.questionID isEqualToString:self.questionModel.key]) {
//                    self.favouriteButton.style = UIBarButtonItemStylePlain;
//                    self.favouriteButton.image = [UIImage imageNamed:@"star-mini"];
//                }
//            }
//
//        }
}

@end
