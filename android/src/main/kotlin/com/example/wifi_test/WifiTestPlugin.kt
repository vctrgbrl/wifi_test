package com.example.wifi_test

import android.app.Activity
import android.content.Context
import android.net.ConnectivityManager
import android.net.ConnectivityManager.NetworkCallback
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.net.wifi.WifiEnterpriseConfig
import android.net.wifi.WifiManager
import android.net.wifi.WifiNetworkSpecifier
import android.net.wifi.WifiNetworkSuggestion
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** WifiTestPlugin */
class WifiTestPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var activity: Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "wifi_test")
    channel.setMethodCallHandler(this)
  }

  @RequiresApi(Build.VERSION_CODES.Q)
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getWifiState") {
      result.success(getWifiState())
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  @RequiresApi(Build.VERSION_CODES.Q)
  fun getWifiState(): Int {
    var wifiManager = this.activity.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
    var wec = WifiEnterpriseConfig()
    wec.identity = ""
    wec.password = ""
    wec.eapMethod = WifiEnterpriseConfig.Eap.PEAP
    wec.phase2Method = WifiEnterpriseConfig.Phase2.MSCHAPV2
    var build = WifiNetworkSuggestion.Builder()
      .setSsid("eduroam")
      .setWpa2EnterpriseConfig(wec)
//      .setWpa2Passphrase("#sti@2021")
      .build()

    var status = wifiManager.addNetworkSuggestions(listOf(build))
//    var n = NetworkRequest.Builder().addTransportType(NetworkCapabilities.TRANSPORT_WIFI).setNetworkSpecifier(build).build()
//
//    var connectivityManager = this.activity.applicationContext.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
//
//    var cb = object: ConnectivityManager.NetworkCallback() {
//      override fun onAvailable(network: Network) {
//        super.onAvailable(network)
//        connectivityManager.bindProcessToNetwork(network)
//      }
//    }
//
//    connectivityManager.requestNetwork(n, cb)
    return wifiManager.wifiState
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }
}
