String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Please enter your email';
  if (!value.contains('@')) return 'Email must contain the "@" symbol';
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Please enter your password';
  if (value.length < 8) return 'At least 8 characters long';
  if (!value.contains(RegExp(r'[A-Z]'))) return 'At least one uppercase letter';
  if (!value.contains(RegExp(r'[a-z]'))) return 'At least one lowercase letter';
  if (!value.contains(RegExp(r'[0-9]'))) return 'At least one digit';
  if (!value.contains(RegExp(r'[!@#\$&*~]'))) return 'At least one special character';
  return null;
}

String? validateConfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) return 'Please confirm your password';
  if (value != password) return 'Passwords do not match';
  return null;
}
