//
//  HIPhotosCollectionViewController.m
//  HealthyInteriors
//
//  Created by Mark O'Flynn on 7/04/13.
//  Copyright (c) 2013 Mark O'Flynn. All rights reserved.
//

#import "HIPhotosCollectionViewController.h"
#import "HIPhotoCollectionViewCell.h"
#import "CheckListAnswerImages.h"
#import "HIPhotoViewController.h"

static NSString *CellIdentifier = @"imageCell";

@interface HIPhotosCollectionViewController () {
    NSMutableArray *_objectChanges;
    NSMutableArray *_sectionChanges;
}
    @property(nonatomic, strong) MBProgressHUD *hud;
@end

@implementation HIPhotosCollectionViewController

    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
        self = [super initWithCollectionViewLayout:layout];
        if (self) {

        }
        return self;
    }

    - (void)viewDidLoad {
        [super viewDidLoad];

        self.collectionView.backgroundColor = [UIColor clearColor];

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(cameraAction)];

        [self.collectionView registerClass:[HIPhotoCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];

        self.navigationItem.title = @"Images";

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(close)];

    }

    - (void)viewDidAppear:(BOOL)animated {
        [super viewDidAppear:animated];
        [self.collectionView reloadData];
    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

    - (void)close {
        [self dismissModalViewControllerAnimated:YES];
    }

#pragma mark - UICollectionVIew

    - (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
        return 1;
    }

    - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return self.answer.answerImages.count;
    }

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    - (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        HIPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];

        CheckListAnswerImages *image = [[self.answer.answerImages allObjects] objectAtIndex:indexPath.row];
        NSString *path = image.thumbPathName;
        cell.image = [UIImage imageWithContentsOfFile:path];
        return cell;
    }

    - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
        HIPhotoViewController *photo = [[HIPhotoViewController alloc] init];
        photo.questionModel = self.questionModel;
        photo.answer = self.answer;
        photo.delegate = self.delegate;
        photo.selectedIndex = [NSNumber numberWithInt:indexPath.row];
        [self.navigationController pushViewController:photo animated:YES];
    }

    - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        int size = (screenBounds.size.width - 4 * 5) / 3;
        return CGSizeMake(size, size);
    }

    - (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
        return UIEdgeInsetsMake(5, 5, 5, 5);
    }

    - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
        return 5.0;
    }

    - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
        return 5.0;
    }

    - (void)cameraAction {
        BOOL isCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        UIActionSheet *actionSheet;
        if (isCamera) {

            actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add Image"
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"Take Photo", @"Select from Library", nil];
        } else {
            actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add Image"
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"Select from Library", nil];

        }

        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        [actionSheet showInView:self.view];
    }

#pragma mark -
#pragma mark UIActionSheetDelegate
    - (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
        int i = buttonIndex;
        switch (i) {
            case 0: {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = (id) self;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:^{
                }];
            }
                break;
            case 1: {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = (id) self;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:picker animated:YES completion:^{
                }];
            }
            default:
                // Do Nothing.........
                break;
        }
    }

    - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
        [picker dismissViewControllerAnimated:YES completion:^{
        }];

        self.hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:self.hud];

        self.hud.dimBackground = YES;
        self.hud.labelText = @"Saving Image ...";

        // Register for HUD callbacks so we can remove it from the window at the right time
        self.hud.delegate = self;

        // Show the HUD while the provided method executes in a new thread
        [self.hud showWhileExecuting:@selector(saveImageWithInfo:) onTarget:self withObject:info animated:YES];
    }

    - (void)saveImageWithInfo:(NSDictionary *)info {
        // Picking Image from Camera/ Library
        UIImage *selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];

        if (!selectedImage) {
            return;
        }

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *imagesPath = [documentsDirectory stringByAppendingPathComponent:@"Images"];

        if (![[NSFileManager defaultManager] fileExistsAtPath:imagesPath]) {

            NSError *error;
            if ([[NSFileManager defaultManager] createDirectoryAtPath:imagesPath withIntermediateDirectories:NO attributes:nil error:&error]);// success
            else {
                NSLog(@"[%@] ERROR: attempting to write create Images directory", [self class]);
                NSAssert( FALSE, @"Failed to create directory maybe out of disk space?");
            }
        }

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
        NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
        NSString *current = [imagesPath stringByAppendingPathComponent:dateString];
        NSData *fullSize = UIImagePNGRepresentation(selectedImage);
        NSString *fullName = [current stringByAppendingString:@".png"];
        [fullSize writeToFile:fullName atomically:YES];

        NSData *thumbSize = UIImagePNGRepresentation([self generateThumbnailFromImage:selectedImage]);
        NSString *thumbNail = [current stringByAppendingString:@"_thumb.png"];
        [thumbSize writeToFile:thumbNail atomically:YES];

        [self.delegate addImageWithFullName:fullName andThumbnailName:thumbNail];
        [self.collectionView reloadData];
    }

    - (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }

    - (UIImage *)generateThumbnailFromImage:(UIImage *)theImage {
        UIImage *thumbnail;
        CGSize imageSize = theImage.size;
        CGSize maxThumbSize = CGSizeMake(160, 160);
        CGSize destinationSize;
        float thumbAspectRatio = maxThumbSize.width / maxThumbSize.height;
        float imageAspectRatio = imageSize.width / imageSize.height;

        if (imageAspectRatio == thumbAspectRatio) {
            destinationSize = maxThumbSize;
        }
        else if (imageAspectRatio > thumbAspectRatio) {
            destinationSize = CGSizeMake(maxThumbSize.width, maxThumbSize.height / imageAspectRatio);
        }
        else if (imageAspectRatio < thumbAspectRatio) {
            destinationSize = CGSizeMake(maxThumbSize.width * imageAspectRatio, maxThumbSize.height);
        }

        UIGraphicsBeginImageContext(destinationSize);
        [theImage drawInRect:CGRectMake(0, 0, destinationSize.width, destinationSize.height)];
        thumbnail = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        return thumbnail;
    }

@end
