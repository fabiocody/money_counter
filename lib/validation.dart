typedef Validator = String? Function(String);

String? getErrorText(List<Validator> validators, String text) {
  for (final validator in validators) {
    final String? result = validator(text);
    if (result != null) {
      return result;
    }
  }
  return null;
}

bool validate(List<Validator> validators, String text) {
  return getErrorText(validators, text) == null;
}

String? _patternValidator(String pattern, String errorMessage, String text, {bool caseSensitive = false}) {
  final RegExp regex = RegExp(pattern, caseSensitive: caseSensitive);
  return regex.hasMatch(text) ? null : errorMessage;
}

String? numberValidator(String text) {
  const pattern = r'^[0-9]+$';
  return _patternValidator(pattern, 'Number not valid', text);
}

String? decimalValidator(String text) {
  const pattern = r'^[0-9]+(\.[0-9]+)?$';
  return _patternValidator(pattern, 'Number not valid', text);
}

Validator optionalValidator(Validator validator) {
  return (String text) => text.isEmpty ? null : validator.call(text);
}
