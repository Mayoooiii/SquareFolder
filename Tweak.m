#import <objc/runtime.h>
#include "substrate.h"

@import Foundation;
@import UIKit;

typedef struct SBIconCoordinate {
    NSInteger row;
    NSInteger col;
} SBIconCoordinate;

@interface SBIconListViewLayoutMetrics : NSObject
@property (assign,nonatomic) CGSize iconSpacing;
@end

@interface SBIconListView : UIView
@property (nonatomic, retain) NSString *iconLocation;
@end
static CGPoint (*orig_originForIcon) (SBIconListView *, SEL, SBIconCoordinate, SBIconListViewLayoutMetrics *);
static CGPoint hooked_originForIcon (SBIconListView *, SEL, SBIconCoordinate, SBIconListViewLayoutMetrics *);
static CGPoint hooked_originForIcon (SBIconListView *self, SEL cmd, SBIconCoordinate arg1, SBIconListViewLayoutMetrics *metrics) {

  if ([self.iconLocation containsString:@"Root"] || [self isKindOfClass:objc_getClass("_SBHLibraryPodCategoryIconListView")] || [self isKindOfClass:objc_getClass("_SBHLibraryPodIconListView")] || [self subviews].count < 1)
    return orig_originForIcon(self, cmd, arg1, metrics);

  metrics.iconSpacing = CGSizeMake(metrics.iconSpacing.width,metrics.iconSpacing.width);
  
  return orig_originForIcon(self, cmd, arg1, metrics);
}

@class SBFloatyFolderBackgroundClipView;
static void (*orig_setFrame) (SBFloatyFolderBackgroundClipView *, SEL, CGRect);
static void hooked_setFrame (SBFloatyFolderBackgroundClipView *, SEL, CGRect);
static void hooked_setFrame (SBFloatyFolderBackgroundClipView *self, SEL cmd, CGRect frame) {

  orig_setFrame(self, cmd, CGRectMake(frame.origin.x,frame.origin.y,frame.size.width,frame.size.width));

}

static __attribute__((constructor)) void init (int argc, char **argv, char **envp) {
  
  MSHookMessageEx(
    objc_getClass("SBIconListView"),
    @selector(originForIconAtCoordinate:metrics:),
    (IMP) &hooked_originForIcon,
    (IMP *) &orig_originForIcon
  );

  MSHookMessageEx(
    objc_getClass("SBFloatyFolderBackgroundClipView"),
    @selector(setFrame:),
    (IMP) &hooked_setFrame,
    (IMP *) &orig_setFrame
  );

}