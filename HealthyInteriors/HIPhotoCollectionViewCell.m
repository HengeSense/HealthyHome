//
//  HIPhotoCollectionViewCell.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIPhotoCollectionViewCell.h"

@implementation HIPhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.autoresizesSubviews = YES;
        self.imageView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                       UIViewAutoresizingFlexibleHeight);
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:self.imageView];
        
    }
    return self;
}

-(void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

@end
