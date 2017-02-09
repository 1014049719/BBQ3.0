//
//  MHBlurTutorialsViewController.h
//  Pods
//
//  Created by Mathilde Henriot on 09/06/2015.
//
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, BBQTutorialsType) {
    BBQTutorialsTypeParent,
    BBQTutorialsTypeTeacherHomePage,
    BBQTutorialsTypeDynamic,
};

typedef void(^OpenGalleryBlock)();

@interface MHBlurTutorialsViewController : UIViewController

@property (assign, nonatomic) BBQTutorialsType tutorialsType;
@property (copy, nonatomic) OpenGalleryBlock block;


- (void)setBackgroundColor:(UIColor *)color;
- (void)setExplanationLabelFont:(UIFont *)font;
- (void)setAnimations:(NSArray *)animations;
- (void)displayTutorial;


@end
