import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'diy_method_channel.dart';

abstract class DiyPlatform extends PlatformInterface {
  /// Constructs a DiyPlatform.
  DiyPlatform() : super(token: _token);

  static final Object _token = Object();

  static DiyPlatform _instance = MethodChannelDiy();

  /// The default instance of [DiyPlatform] to use.
  ///
  /// Defaults to [MethodChannelDiy].
  static DiyPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DiyPlatform] when
  /// they register themselves.
  static set instance(DiyPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
