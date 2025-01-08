import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class CompressMixin {
  StreamController<double> _progressStream = StreamController.broadcast();

  final _channel = const MethodChannel('video_compress');

  Stream<double> get progressStream => _progressStream.stream;

  @protected
  void initProcessCallback() {
    _channel.setMethodCallHandler(_progressCallback);
  }

  MethodChannel get channel => _channel;

  bool _isCompressing = false;

  bool get isCompressing => _isCompressing;

  @protected
  void setProcessingStatus(bool status) {
    _isCompressing = status;
  }

  Future<void> _progressCallback(MethodCall call) async {
    switch (call.method) {
      case 'updateProgress':
        final progress = double.tryParse(call.arguments.toString());
        if (progress != null) _progressStream.add(progress);
        break;
    }
  }
}
