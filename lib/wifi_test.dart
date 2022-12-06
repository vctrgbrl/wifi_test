
import 'wifi_test_platform_interface.dart';

enum WifiState {
  DISABLING, 
  DISABLED, 
  ENABLING, 
  ENABLED, 
  UNKNOWN
}

class WifiTest {
  Future<WifiState?> getWifiState() {
    return WifiTestPlatform.instance.getWifiState();
  }
}
