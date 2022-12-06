import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:wifi_test/wifi_test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _wsMessage = '...';
  final _wifiTestPlugin = WifiTest();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getWifiState() async {
    WifiState wifiState;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      wifiState = await _wifiTestPlugin.getWifiState() ?? WifiState.UNKNOWN;
    } on PlatformException {
      wifiState = WifiState.UNKNOWN;
    }

    setState(() {
      switch (wifiState) {
        case WifiState.DISABLED:
          _wsMessage = 'Disabled';
          break;
        case WifiState.DISABLING:
          _wsMessage = 'Disabling';
          break;
        case WifiState.ENABLED:
          _wsMessage = 'Enabled';
          break;
        case WifiState.ENABLING:
          _wsMessage = 'Enabling';
          break;
        case WifiState.UNKNOWN:
          _wsMessage = 'Unknown';
          break;
        default:
          _wsMessage = '???';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                child: Text("Check Wifi State"),
                onPressed: getWifiState,
              ),
              Text(_wsMessage)
            ],
          ),
        ),
      ),
    );
  }
}
