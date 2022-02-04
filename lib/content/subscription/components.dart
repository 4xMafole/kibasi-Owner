import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:kibasi/utils/custom_color.dart' as color;

class SubComponent {
  static final SubComponent _subComponent = SubComponent._internal();

  bool? isPremium = false;
  bool? isPro = false;
  bool? isVerified = false;

  factory SubComponent() {
    return _subComponent;
  }

  SubComponent._internal();
}

final subCommponent = SubComponent();
