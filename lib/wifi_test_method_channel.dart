import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:wifi_test/wifi_test.dart';

import 'wifi_test_platform_interface.dart';

/// An implementation of [WifiTestPlatform] that uses method channels.
class MethodChannelWifiTest extends WifiTestPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wifi_test');

  @override
  Future<WifiState?> getWifiState() async {
    final wifiState = WifiState.values[await methodChannel.invokeMethod<int>('getWifiState') ?? 4];
    return wifiState;
  }
}
