#import "WifiTestPlugin.h"
#if __has_include(<wifi_test/wifi_test-Swift.h>)
#import <wifi_test/wifi_test-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "wifi_test-Swift.h"
#endif

@implementation WifiTestPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWifiTestPlugin registerWithRegistrar:registrar];
}
@end
