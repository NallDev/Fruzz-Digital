import 'package:flutter/material.dart';

import '../data/local/preferences_helper.dart';

void showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

Future<bool> checkSession() async {
  PreferencesHelper preferencesHelper = PreferencesHelper();
  var session = await preferencesHelper.getSession();
  return session != null;
}