//
//  TOCropViewController.m
//
//  Copyright 2015-2018 Timothy Oliver. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
//  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "TOCropViewController.h"

#import "TOCropViewControllerTransitioning.h"
#import "TOActivityCroppedImageProvider.h"
#import "UIImage+CropRotate.h"
#import "TOCroppedImageAttributes.h"

static const CGFloat kTOCropViewControllerTitleTopPadding = 14.0f;

@interface TOCropViewController () <UIActionSheetDelegate, UIViewControllerTransitioningDelegate, TOCropViewDelegate>

/* The target image */
@property (nonatomic, readwrite) UIImage *image;

/* The cropping style of the crop view */
@property (nonatomic, assign, readwrite) TOCropViewCroppingStyle croppingStyle;

/* Views */
@property (nonatomic, strong, readwrite) TOCropView *cropView;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;

/* Transition animation controller */
@property (nonatomic, copy) void (^prepareForTransitionHandler)(void);
@property (nonatomic, strong) TOCropViewControllerTransitioning *transitionController;
@property (nonatomic, assign) BOOL inTransition;

/* State for whether content is being laid out vertically or horizontally */
@property (nonatomic, readonly) BOOL verticalLayout;

/* Convenience method for managing status bar state */
@property (nonatomic, readonly) BOOL overrideStatusBar; // Whether the view controller needs to touch the status bar
@property (nonatomic, readonly) BOOL statusBarHidden;   // Whether it should be hidden or visible at this point
@property (nonatomic, readonly) CGFloat statusBarHeight; // The height of the status bar when visible

/* Convenience method for getting the vertical inset for both iPhone X and status bar */
@property (nonatomic, readonly) UIEdgeInsets statusBarSafeInsets;

/* Flag to perform initial setup on the first run */
@property (nonatomic, assign) BOOL firstTime;

/* On iOS 7, the popover view controller that appears when tapping 'Done' */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, strong) UIPopoverController *activityPopoverController;
#pragma clang diagnostic pop

@end

@implementation TOCropViewController

- (instancetype)initWithCroppingStyle:(TOCropViewCroppingStyle)style image:(UIImage *)image
{
  NSParameterAssert(image);
  
  self = [super init];
  if (self) {
    // Init parameters
    _image = image;
    _croppingStyle = style;
    
    // Set up base view controller behaviour
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Controller object that handles the transition animation when presenting / dismissing this app
    _transitionController = [[TOCropViewControllerTransitioning alloc] init];
  }
  
  return self;
}

- (instancetype)initWithImage:(UIImage *)image
{
  return [self initWithCroppingStyle:TOCropViewCroppingStyleDefault image:image];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Set up view controller properties
  self.transitioningDelegate = self;
  self.view.backgroundColor = self.cropView.backgroundColor;
  
  BOOL circularMode = (self.croppingStyle == TOCropViewCroppingStyleCircular);
  
  // Layout the views initially
  self.cropView.frame = [self frameForCropViewWithVerticalLayout:self.verticalLayout];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  // If we're animating onto the screen, set a flag
  // so we can manually control the status bar fade out timing
  if (animated) {
    self.inTransition = YES;
    [self setNeedsStatusBarAppearanceUpdate];
  }
  
  // If this controller is pushed onto a navigation stack, set flags noting the
  // state of the navigation controller bars before we present, and then hide them
  if (self.navigationController) {
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
  }
  else {
    // Hide the background content when transitioning for performance
    [self.cropView setBackgroundImageViewHidden:YES animated:NO];
    
    // The title label will fade
    self.titleLabel.alpha = animated ? 0.0f : 1.0f;
  }
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  // Disable the transition flag for the status bar
  self.inTransition = NO;
  
  // Re-enable translucency now that the animation has completed
  self.cropView.simpleRenderMode = NO;
  
  // Now that the presentation animation will have finished, animate
  // the status bar fading out, and if present, the title label fading in
  void (^updateContentBlock)(void) = ^{
    [self setNeedsStatusBarAppearanceUpdate];
    self.titleLabel.alpha = 1.0f;
  };
  
  if (animated) {
    [UIView animateWithDuration:0.3f animations:updateContentBlock];
  }
  else {
    updateContentBlock();
  }
  
  // Make the grid overlay view fade in
  if (self.cropView.gridOverlayHidden) {
    [self.cropView setGridOverlayHidden:NO animated:animated];
  }
  
  // Fade in the background view content
  if (self.navigationController == nil) {
    [self.cropView setBackgroundImageViewHidden:NO animated:animated];
  }
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  // Set the transition flag again so we can defer the status bar
  self.inTransition = YES;
  [UIView animateWithDuration:0.5f animations:^{ [self setNeedsStatusBarAppearanceUpdate]; }];
}

- (void)viewDidDisappear:(BOOL)animated
{
  [super viewDidDisappear:animated];
  
  // Reset the state once the view has gone offscreen
  self.inTransition = NO;
  [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Status Bar -
- (UIStatusBarStyle)preferredStatusBarStyle
{
  if (self.navigationController) {
    return UIStatusBarStyleLightContent;
  }
  
  // Even though we are a dark theme, leave the status bar
  // as black so it's not obvious that it's still visible during the transition
  return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden
{
  // Disregard the transition animation if we're not actively overriding it
  if (!self.overrideStatusBar) {
    return self.statusBarHidden;
  }
  
  // Work out whether the status bar needs to be visible
  // during a transition animation or not
  BOOL hidden = YES; // Default is yes
  hidden = hidden && !(self.inTransition); // Not currently in a presentation animation (Where removing the status bar would break the layout)
  hidden = hidden && !(self.view.superview == nil); // Not currently waiting to be added to a super view
  return hidden;
}

- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures
{
  return UIRectEdgeAll;
}

- (CGRect)frameForCropViewWithVerticalLayout:(BOOL)verticalLayout
{
  //On an iPad, if being presented in a modal view controller by a UINavigationController,
  //at the time we need it, the size of our view will be incorrect.
  //If this is the case, derive our view size from our parent view controller instead
  UIView *view = nil;
  if (self.parentViewController == nil) {
    view = self.view;
  }
  else {
    view = self.parentViewController.view;
  }
  
  UIEdgeInsets insets = self.statusBarSafeInsets;
  
  CGRect bounds = view.bounds;
  CGRect frame = CGRectZero;
  
  // Horizontal layout (eg landscape)
  if (!verticalLayout) {
    frame.origin.x = insets.left;
    frame.size.width = CGRectGetWidth(bounds) - frame.origin.x;
    frame.size.height = CGRectGetHeight(bounds);
  }
  else { // Vertical layout
    frame.size.height = CGRectGetHeight(bounds);
    frame.size.width = CGRectGetWidth(bounds);
    
    // Set Y and adjust for height
    frame.size.height -= (insets.bottom);
  }
  
  return frame;
}

- (CGRect)frameForTitleLabelWithSize:(CGSize)size verticalLayout:(BOOL)verticalLayout
{
  CGRect frame = (CGRect){CGPointZero, size};
  CGFloat viewWidth = self.view.bounds.size.width;
  CGFloat x = 0.0f; // Additional X offset in landscape mode
  
  // Adjust for landscape layout
  if (!verticalLayout) {
    x = kTOCropViewControllerTitleTopPadding;
    if (@available(iOS 11.0, *)) {
      x += self.view.safeAreaInsets.left;
    }
    
    viewWidth -= x;
  }
  
  // Work out horizontal position
  frame.origin.x = ceilf((viewWidth - frame.size.width) * 0.5f);
  if (!verticalLayout) { frame.origin.x += x; }
  
  // Work out vertical position
  if (@available(iOS 11.0, *)) {
    frame.origin.y = self.view.safeAreaInsets.top + kTOCropViewControllerTitleTopPadding;
  }
  else {
    frame.origin.y = self.statusBarHeight + kTOCropViewControllerTitleTopPadding;
  }
  
  return frame;
}

- (void)adjustCropViewInsets
{
  UIEdgeInsets insets = self.statusBarSafeInsets;
  
  if (!self.titleLabel.text.length) {
    if (self.verticalLayout) {
      self.cropView.cropRegionInsets = UIEdgeInsetsMake(insets.top, 0.0f, 0.0, 0.0f);
    }
    else {
      self.cropView.cropRegionInsets = UIEdgeInsetsMake(0.0f, 0.0f, insets.bottom, 0.0f);
    }
    
    return;
  }
  
  // Work out the size of the title label based on the crop view size
  CGRect frame = self.titleLabel.frame;
  frame.size = [self.titleLabel sizeThatFits:self.cropView.frame.size];
  self.titleLabel.frame = frame;
  
  // Set out the appropriate inset for that
  CGFloat verticalInset = self.statusBarHeight;
  verticalInset += kTOCropViewControllerTitleTopPadding;
  verticalInset += self.titleLabel.frame.size.height;
  self.cropView.cropRegionInsets = UIEdgeInsetsMake(verticalInset, 0, insets.bottom, 0);
}

- (void)viewSafeAreaInsetsDidChange
{
  [super viewSafeAreaInsetsDidChange];
  [self adjustCropViewInsets];
}

- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];
  
  self.cropView.frame = [self frameForCropViewWithVerticalLayout:self.verticalLayout];
  [self adjustCropViewInsets];
  [self.cropView moveCroppedContentToCenterAnimated:NO];
  
  if (self.firstTime == NO) {
    [self.cropView performInitialSetup];
    self.firstTime = YES;
  }
  
  if (self.title.length) {
    self.titleLabel.frame = [self frameForTitleLabelWithSize:self.titleLabel.frame.size verticalLayout:self.verticalLayout];
    [self.cropView moveCroppedContentToCenterAnimated:NO];
  }
}

#pragma mark - Rotation Handling -

//TODO: Deprecate iOS 7 properly at the right time
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
  [self.cropView prepareforRotation];
  self.cropView.frame = [self frameForCropViewWithVerticalLayout:!UIInterfaceOrientationIsPortrait(toInterfaceOrientation)];
  self.cropView.simpleRenderMode = YES;
  self.cropView.internalLayoutDisabled = YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
  
  // On iOS 11, since these layout calls are done multiple times, if we don't aggregate from the
  // current state, the animation breaks.
  [UIView animateWithDuration:duration
                        delay:0.0f
                      options:UIViewAnimationOptionBeginFromCurrentState
                   animations:
   ^{
     self.cropView.frame = [self frameForCropViewWithVerticalLayout:!UIInterfaceOrientationIsLandscape(toInterfaceOrientation)];
     [self.cropView performRelayoutForRotation];
   } completion:nil];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
  [self.cropView setSimpleRenderMode:NO animated:YES];
  self.cropView.internalLayoutDisabled = NO;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
  
  // If the size doesn't change (e.g, we did a 180 degree device rotation), don't bother doing a relayout
  if (CGSizeEqualToSize(size, self.view.bounds.size)) { return; }
  
  UIInterfaceOrientation orientation = UIInterfaceOrientationPortrait;
  CGSize currentSize = self.view.bounds.size;
  if (currentSize.width < size.width) {
    orientation = UIInterfaceOrientationLandscapeLeft;
  }
  
  [self willRotateToInterfaceOrientation:orientation duration:coordinator.transitionDuration];
  [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
    [self willAnimateRotationToInterfaceOrientation:orientation duration:coordinator.transitionDuration];
  } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
    [self didRotateFromInterfaceOrientation:orientation];
  }];
}
#pragma clang diagnostic pop

#pragma mark - Reset -
- (void)resetCropViewLayout
{
  BOOL animated = (self.cropView.angle == 0);
  
  if (self.resetAspectRatioEnabled) {
    self.aspectRatioLockEnabled = NO;
  }
  
  [self.cropView resetLayoutToDefaultAnimated:animated];
}

- (void)rotateCropViewClockwise
{
  [self.cropView rotateImageNinetyDegreesAnimated:YES clockwise:YES];
}

- (void)rotateCropViewCounterclockwise
{
  [self.cropView rotateImageNinetyDegreesAnimated:YES clockwise:NO];
}

#pragma mark - Presentation Handling -
- (void)presentAnimatedFromParentViewController:(UIViewController *)viewController
                                       fromView:(UIView *)fromView
                                      fromFrame:(CGRect)fromFrame
                                          setup:(void (^)(void))setup
                                     completion:(void (^)(void))completion
{
  [self presentAnimatedFromParentViewController:viewController fromImage:nil fromView:fromView fromFrame:fromFrame
                                          angle:0 toImageFrame:CGRectZero setup:setup completion:nil];
}

- (void)presentAnimatedFromParentViewController:(UIViewController *)viewController
                                      fromImage:(UIImage *)image
                                       fromView:(UIView *)fromView
                                      fromFrame:(CGRect)fromFrame
                                          angle:(NSInteger)angle
                                   toImageFrame:(CGRect)toFrame
                                          setup:(void (^)(void))setup
                                     completion:(void (^)(void))completion
{
  self.transitionController.image     = image ? image : self.image;
  self.transitionController.fromFrame = fromFrame;
  self.transitionController.fromView  = fromView;
  self.prepareForTransitionHandler    = setup;
  
  if (self.angle != 0 || !CGRectIsEmpty(toFrame)) {
    self.angle = angle;
    self.imageCropFrame = toFrame;
  }
  
  __weak typeof (self) weakSelf = self;
  [viewController presentViewController:self.parentViewController ? self.parentViewController : self
                               animated:YES
                             completion:^
   {
     typeof (self) strongSelf = weakSelf;
     if (completion) {
       completion();
     }
     
     [strongSelf.cropView setCroppingViewsHidden:NO animated:YES];
     if (!CGRectIsEmpty(fromFrame)) {
       [strongSelf.cropView setGridOverlayHidden:NO animated:YES];
     }
   }];
}

- (void)dismissAnimatedFromParentViewController:(UIViewController *)viewController
                                         toView:(UIView *)toView
                                        toFrame:(CGRect)frame
                                          setup:(void (^)(void))setup
                                     completion:(void (^)(void))completion
{
  [self dismissAnimatedFromParentViewController:viewController withCroppedImage:nil toView:toView toFrame:frame setup:setup completion:completion];
}

- (void)dismissAnimatedFromParentViewController:(UIViewController *)viewController
                               withCroppedImage:(UIImage *)image
                                         toView:(UIView *)toView
                                        toFrame:(CGRect)frame
                                          setup:(void (^)(void))setup
                                     completion:(void (^)(void))completion
{
  // If a cropped image was supplied, use that, and only zoom out from the crop box
  if (image) {
    self.transitionController.image     = image ? image : self.image;
    self.transitionController.fromFrame = [self.cropView convertRect:self.cropView.cropBoxFrame toView:self.view];
  }
  else { // else use the main image, and zoom out from its entirety
    self.transitionController.image     = self.image;
    self.transitionController.fromFrame = [self.cropView convertRect:self.cropView.imageViewFrame toView:self.view];
  }
  
  self.transitionController.toView    = toView;
  self.transitionController.toFrame   = frame;
  self.prepareForTransitionHandler    = setup;
  
  [viewController dismissViewControllerAnimated:YES completion:^ {
    if (completion) { completion(); }
  }];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
  if (self.navigationController || self.modalTransitionStyle == UIModalTransitionStyleCoverVertical) {
    return nil;
  }
  
  self.cropView.simpleRenderMode = YES;
  
  __weak typeof (self) weakSelf = self;
  self.transitionController.prepareForTransitionHandler = ^{
    typeof (self) strongSelf = weakSelf;
    TOCropViewControllerTransitioning *transitioning = strongSelf.transitionController;
    
    transitioning.toFrame = [strongSelf.cropView convertRect:strongSelf.cropView.cropBoxFrame toView:strongSelf.view];
    if (!CGRectIsEmpty(transitioning.fromFrame) || transitioning.fromView) {
      strongSelf.cropView.croppingViewsHidden = YES;
    }
    
    if (strongSelf.prepareForTransitionHandler) {
      strongSelf.prepareForTransitionHandler();
    }
    
    strongSelf.prepareForTransitionHandler = nil;
  };
  
  self.transitionController.isDismissing = NO;
  return self.transitionController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
  if (self.navigationController || self.modalTransitionStyle == UIModalTransitionStyleCoverVertical) {
    return nil;
  }
  
  __weak typeof (self) weakSelf = self;
  self.transitionController.prepareForTransitionHandler = ^{
    typeof (self) strongSelf = weakSelf;
    TOCropViewControllerTransitioning *transitioning = strongSelf.transitionController;
    
    if (!CGRectIsEmpty(transitioning.toFrame) || transitioning.toView) {
      strongSelf.cropView.croppingViewsHidden = YES;
    }
    else {
      strongSelf.cropView.simpleRenderMode = YES;
    }
    
    if (strongSelf.prepareForTransitionHandler) {
      strongSelf.prepareForTransitionHandler();
    }
  };
  
  self.transitionController.isDismissing = YES;
  return self.transitionController;
}

#pragma mark - Button Feedback -
- (void)cancelButtonTapped
{
  bool isDelegateOrCallbackHandled = NO;
  
  // Check if the delegate method was implemented and call if so
  if ([self.delegate respondsToSelector:@selector(cropViewController:didFinishCancelled:)]) {
    [self.delegate cropViewController:self didFinishCancelled:YES];
    isDelegateOrCallbackHandled = YES;
  }
  
  // Check if the block version was implemented and call if so
  if (self.onDidFinishCancelled != nil) {
    self.onDidFinishCancelled(YES);
    isDelegateOrCallbackHandled = YES;
  }
  
  // If neither callbacks were implemented, perform a default dismissing animation
  if (!isDelegateOrCallbackHandled) {
    if (self.navigationController) {
      [self.navigationController popViewControllerAnimated:YES];
    }
    else {
      self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
      [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
  }
}

- (void)doneButtonTapped
{
  CGRect cropFrame = self.cropView.imageCropFrame;
  NSInteger angle = self.cropView.angle;
  
  BOOL isCallbackOrDelegateHandled = NO;
  
  //If the delegate/block that only supplies crop data is provided, call it
  if ([self.delegate respondsToSelector:@selector(cropViewController:didCropImageToRect:angle:)]) {
    [self.delegate cropViewController:self didCropImageToRect:cropFrame angle:angle];
    isCallbackOrDelegateHandled = YES;
  }
  
  if (self.onDidCropImageToRect != nil) {
    self.onDidCropImageToRect(cropFrame, angle);
    isCallbackOrDelegateHandled = YES;
  }
  
  // Check if the circular APIs were implemented
  BOOL isCircularImageDelegateAvailable = [self.delegate respondsToSelector:@selector(cropViewController:didCropToCircularImage:withRect:angle:)];
  BOOL isCircularImageCallbackAvailable = self.onDidCropToCircleImage != nil;
  
  // Check if non-circular was implemented
  BOOL isDidCropToImageDelegateAvailable = [self.delegate respondsToSelector:@selector(cropViewController:didCropToImage:withRect:angle:)];
  BOOL isDidCropToImageCallbackAvailable = self.onDidCropToRect != nil;
  
  //If cropping circular and the circular generation delegate/block is implemented, call it
  if (self.croppingStyle == TOCropViewCroppingStyleCircular && (isCircularImageDelegateAvailable || isCircularImageCallbackAvailable)) {
    UIImage *image = [self.image croppedImageWithFrame:cropFrame angle:angle circularClip:YES];
    
    //Dispatch on the next run-loop so the animation isn't interuppted by the crop operation
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      if (isCircularImageDelegateAvailable) {
        [self.delegate cropViewController:self didCropToCircularImage:image withRect:cropFrame angle:angle];
      }
      if (isCircularImageCallbackAvailable) {
        self.onDidCropToCircleImage(image, cropFrame, angle);
      }
    });
    
    isCallbackOrDelegateHandled = YES;
  }
  //If the delegate/block that requires the specific cropped image is provided, call it
  else if (isDidCropToImageDelegateAvailable || isDidCropToImageCallbackAvailable) {
    UIImage *image = nil;
    if (angle == 0 && CGRectEqualToRect(cropFrame, (CGRect){CGPointZero, self.image.size})) {
      image = self.image;
    }
    else {
      image = [self.image croppedImageWithFrame:cropFrame angle:angle circularClip:NO];
    }
    
    //Dispatch on the next run-loop so the animation isn't interuppted by the crop operation
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      if (isDidCropToImageDelegateAvailable) {
        [self.delegate cropViewController:self didCropToImage:image withRect:cropFrame angle:angle];
      }
      
      if (isDidCropToImageCallbackAvailable) {
        self.onDidCropToRect(image, cropFrame, angle);
      }
    });
    
    isCallbackOrDelegateHandled = YES;
  }
  
  if (!isCallbackOrDelegateHandled) {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
  }
}

#pragma mark - Property Methods -

- (void)setTitle:(NSString *)title
{
  [super setTitle:title];
  
  if (self.title.length == 0) {
    [_titleLabel removeFromSuperview];
    _cropView.cropRegionInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _titleLabel = nil;
    return;
  }
  
  self.titleLabel.text = self.title;
  [self.titleLabel sizeToFit];
  self.titleLabel.frame = [self frameForTitleLabelWithSize:self.titleLabel.frame.size verticalLayout:self.verticalLayout];
}

- (TOCropView *)cropView {
  // Lazily create the crop view in case we try and access it before presentation, but
  // don't add it until our parent view controller view has loaded at the right time
  if (!_cropView) {
    _cropView = [[TOCropView alloc] initWithCroppingStyle:self.croppingStyle image:self.image];
    _cropView.delegate = self;
    _cropView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_cropView];
  }
  return _cropView;
}

- (UILabel *)titleLabel
{
  if (!self.title.length) { return nil; }
  if (_titleLabel) { return _titleLabel; }
  
  _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
  _titleLabel.backgroundColor = [UIColor clearColor];
  _titleLabel.textColor = [UIColor whiteColor];
  _titleLabel.numberOfLines = 1;
  _titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
  _titleLabel.clipsToBounds = YES;
  _titleLabel.textAlignment = NSTextAlignmentCenter;
  _titleLabel.text = self.title;
  
  [self.view insertSubview:self.titleLabel aboveSubview:self.cropView];
  
  return _titleLabel;
}

- (void)setAspectRatioLockEnabled:(BOOL)aspectRatioLockEnabled
{
  self.cropView.aspectRatioLockEnabled = aspectRatioLockEnabled;
}

- (void)setAspectRatioLockDimensionSwapEnabled:(BOOL)aspectRatioLockDimensionSwapEnabled
{
  self.cropView.aspectRatioLockDimensionSwapEnabled = aspectRatioLockDimensionSwapEnabled;
}

- (BOOL)aspectRatioLockEnabled
{
  return self.cropView.aspectRatioLockEnabled;
}

- (void)setResetAspectRatioEnabled:(BOOL)resetAspectRatioEnabled
{
  self.cropView.resetAspectRatioEnabled = resetAspectRatioEnabled;
}

- (void)setCustomAspectRatio:(CGSize)customAspectRatio
{
  _customAspectRatio = customAspectRatio;
}

- (BOOL)resetAspectRatioEnabled
{
  return self.cropView.resetAspectRatioEnabled;
}

- (void)setAngle:(NSInteger)angle
{
  self.cropView.angle = angle;
}

- (NSInteger)angle
{
  return self.cropView.angle;
}

- (void)setImageCropFrame:(CGRect)imageCropFrame
{
  self.cropView.imageCropFrame = imageCropFrame;
}

- (CGRect)imageCropFrame
{
  return self.cropView.imageCropFrame;
}

- (BOOL)verticalLayout
{
  return CGRectGetWidth(self.view.bounds) < CGRectGetHeight(self.view.bounds);
}

- (BOOL)overrideStatusBar
{
  // If we're pushed from a navigation controller, we'll defer
  // to its handling of the status bar
  if (self.navigationController) {
    return NO;
  }
  
  // If the view controller presenting us already hid it, we don't need to
  // do anything ourselves
  if (self.presentingViewController.prefersStatusBarHidden) {
    return NO;
  }
  
  // We'll handle the status bar
  return YES;
}

- (BOOL)statusBarHidden
{
  // Defer behavioir to the hosting navigation controller
  if (self.navigationController) {
    return self.navigationController.prefersStatusBarHidden;
  }
  
  //If our presenting controller has already hidden the status bar,
  //hide the status bar by default
  if (self.presentingViewController.prefersStatusBarHidden) {
    return YES;
  }
  
  // Our default behaviour is to always hide the status bar
  return YES;
}

- (CGFloat)statusBarHeight
{
  if (self.statusBarHidden) {
    return 0.0f;
  }
  
  CGFloat statusBarHeight = 0.0f;
  if (@available(iOS 11.0, *)) {
    statusBarHeight = self.view.safeAreaInsets.top;
  }
  else {
    statusBarHeight = self.topLayoutGuide.length;
  }
  
  return statusBarHeight;
}

- (UIEdgeInsets)statusBarSafeInsets
{
  UIEdgeInsets insets = UIEdgeInsetsZero;
  if (@available(iOS 11.0, *)) {
    insets = self.view.safeAreaInsets;
    
    // Since iPhone X insets are always 44, check if this is merely
    // accounting for a non-X status bar and cancel it
    if (insets.top <= 20.0f + FLT_EPSILON) {
      insets.top = self.statusBarHeight;
    }
  }
  else {
    insets.top = self.statusBarHeight;
  }
  
  return insets;
}

- (void)setMinimumAspectRatio:(CGFloat)minimumAspectRatio
{
  self.cropView.minimumAspectRatio = minimumAspectRatio;
}

- (CGFloat)minimumAspectRatio
{
  return self.cropView.minimumAspectRatio;
}

@end
