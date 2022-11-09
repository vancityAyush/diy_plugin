import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'diy_platform_interface.dart';

/// An implementation of [DiyPlatform] that uses method channels.
class MethodChannelDiy extends DiyPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('diy');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
