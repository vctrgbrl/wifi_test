import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:wifi_test/wifi_test.dart';

import 'wifi_test_method_channel.dart';

abstract class WifiTestPlatform extends PlatformInterface {
  /// Constructs a WifiTestPlatform.
  WifiTestPlatform() : super(token: _token);

  static final Object _token = Object();

  static WifiTestPlatform _instance = MethodChannelWifiTest();

  /// The default instance of [WifiTestPlatform] to use.
  ///
  /// Defaults to [MethodChannelWifiTest].
  static WifiTestPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WifiTestPlatform] when
  /// they register themselves.
  static set instance(WifiTestPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<WifiState?> getWifiState() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
