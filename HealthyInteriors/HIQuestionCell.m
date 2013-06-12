//
//  HIQuestionCell.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/06/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIQuestionCell.h"

@interface HIQuestionCell (/* private */)

    @property(strong, nonatomic) IBOutlet UIImageView *cameraIcon;
    @property(strong, nonatomic) IBOutlet UIImageView *notesIcon;
    @property(strong, nonatomic) IBOutlet UIImageView *answerIcon;
    @property(strong, nonatomic) IBOutlet UILabel *questionLabel;
    @property (strong, nonatomic) IBOutlet UIImageView *favouriteIcon;

    - (void)hasNotes:(BOOL)value;

    - (void)hasImages:(BOOL)value;

    - (void)isNotAnswered;

    - (void)isChallenge;

    - (void)isAsset;

@end

@implementation HIQuestionCell

    - (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"HIQuestionCell" owner:self options:nil];
            self = [nibArray objectAtIndex:0];
        }
        return self;
    }

    - (void)setSelected:(BOOL)selected animated:(BOOL)animated {
        [super setSelected:selected animated:animated];

        // Configure the view for the selected state
    }

    - (void)setQuestionText:(NSString *)value {
        self.questionLabel.text = value;
        self.questionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }

    - (void)hasNotes:(BOOL)value {
        self.notesIcon.hidden = !value;
    }

    - (void)hasImages:(BOOL)value {
        self.cameraIcon.hidden = !value;
    }

    - (void)isNotAnswered {
        self.answerIcon.image = [UIImage imageNamed:@"question_24"];
    }

    - (void)isChallenge {
        self.answerIcon.image = [UIImage imageNamed:@"thumb_dn_24"];
    }

    - (void)isAsset {
        self.answerIcon.image = [UIImage imageNamed:@"thumb_up_24"];
    }

    - (void)isFavourite:(BOOL)value {
        self.favouriteIcon.hidden = !value;
    }

    - (UIImageView *)cameraIcon {
        return _cameraIcon;
    }

    - (void)setQuestion:(HICheckListQuestionModel *)question andAnswer:(CheckListAnswers *)answers {
        self.questionLabel.text = question.text;

        if ([answers isAnswerToQuestionAChallenge:question]) {
            [self isChallenge];
        } else if ([answers isAnswerToQuestionAnAsset:question]) {
            [self isAsset];
        } else {
            [self isNotAnswered];
        }

        [self hasImages:[answers questionHasImages:question]];
        [self hasNotes:[answers questionHasNotes:question]];

        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }

@end
