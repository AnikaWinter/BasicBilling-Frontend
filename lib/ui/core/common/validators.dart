typedef Validator = String? Function(String?);

class AppValidators {
  static Validator required(String fieldName) {
    return (value) =>
        (value == null || value.isEmpty) ? 'Please enter $fieldName' : null;
  }

  static Validator regex(String pattern, String errorMsg) {
    return (value) =>
        value != null && RegExp(pattern).hasMatch(value) ? null : errorMsg;
  }

  static Validator number(String fieldName) {
    return (value) {
      if (value == null || value.isEmpty) return 'Please enter $fieldName';
      if (int.tryParse(value) == null) return '$fieldName must be a number';
      return null;
    };
  }

  static Validator requiredPositive(String fieldName) {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    final number = int.tryParse(value);
    if (number == null || number <= 0) {
      return '$fieldName must be a positive number';
    }
    return null;
  };
}

  static Validator periodFormat() {
    return (value) {
      if (value == null || value.isEmpty) return 'Enter a period';
      if (!RegExp(r'^\d{6}$').hasMatch(value)) return 'Format must be YYYYMM';
      return null;
    };
  }
}
