import 'package:flutter/foundation.dart';
import 'package:my_story_app/util/constant.dart';

class FormProvider extends ChangeNotifier {
  final Map<String, String> _values = {};
  final Map<String, String?> _errorTexts = {};
  final Map<String, bool> _isValid = {};

  String getValue(String field) => _values[field] ?? textEmpty;
  String? getErrorText(String field) => _errorTexts[field];
  bool? isValid(String field) => _isValid[field];

  void setValue(String field, String newValue) {
    _values[field] = newValue;
    notifyListeners();
  }

  void validateEmail(String field, String value) {
    final emailRegex = RegExp(
      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
    );

    if (!emailRegex.hasMatch(value)) {
      _isValid[field] = false;
      _errorTexts[field] = emailValidatorMsg;
    } else {
      _isValid[field] = true;
      _errorTexts[field] = null;
    }
    notifyListeners();
  }

  void validateMinEightChar(String field, String value) {
    if (value.length < 8) {
      _isValid[field] = false;
      _errorTexts[field] = charLengthValidatorMsg;
    } else {
      _isValid[field] = true;
      _errorTexts[field] = null;
    }
    notifyListeners();
  }

  void validateEmpty(String field, String value) {
    if (value.isEmpty) {
      _isValid[field] = false;
      _errorTexts[field] = textEmptyValidatorMsg;
    } else {
      _isValid[field] = true;
      _errorTexts[field] = null;
    }
    notifyListeners();
  }
}