#import "DiyPlugin.h"
#if __has_include(<diy/diy-Swift.h>)
#import <diy/diy-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "diy-Swift.h"
#endif

@implementation DiyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDiyPlugin registerWithRegistrar:registrar];
}
@end
