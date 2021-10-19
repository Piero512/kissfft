#import "KissfftPlugin.h"
#if __has_include(<kissfft/kissfft-Swift.h>)
#import <kissfft/kissfft-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "kissfft-Swift.h"
#endif

@implementation KissfftPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKissfftPlugin registerWithRegistrar:registrar];
}
@end
