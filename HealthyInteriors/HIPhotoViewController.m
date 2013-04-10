//
//  HIPhotoViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 8/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIPhotoViewController.h"
#import "CheckListAnswerImages.h"

@interface HIPhotoViewController ()
@property (nonatomic, assign) BOOL pageControlBeingUsed;
@property (nonatomic, strong) NSArray * imagesArray;
@end

@implementation HIPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imagesArray = [self.answer.answerImages allObjects];
    for (int i = 0; i < self.imagesArray.count; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIImageView *subview = [[UIImageView alloc] initWithFrame:frame];
        CheckListAnswerImages *image = [self.imagesArray objectAtIndex:i];
        NSString * path = image.thumbPathName;
        subview.contentMode = UIViewContentModeScaleAspectFit;
        subview.image = [UIImage imageWithContentsOfFile:path];
        [self.scrollView addSubview:subview];
        self.pageControlBeingUsed = NO;
        self.pageControl.numberOfPages = self.imagesArray.count;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.imagesArray.count, self.scrollView.frame.size.height);
    self.pageControl.currentPage = [self.selectedIndex integerValue];
    [self changePage:self.pageControl];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deletePhoto)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (IBAction)changePage:(id)sender {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    self.pageControlBeingUsed = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControlBeingUsed = NO;
}

-(void) deletePhoto
{
//    int currentIndex = self.pageControl.currentPage;
//    //get the photo managed object
//    NSManagedObject * mo = [self.imagesArray objectAtIndex:currentIndex];
//    //delete it
//    [self.answer removeAnswerImagesObject:mo];
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [self setPageControl:nil];
    [super viewDidUnload];
}

@end
