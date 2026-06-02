import '../constants/app_constants.dart';

class Validators {
  Validators._();
  
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < AppConstants.minNameLength) {
      return 'Name must be at least ${AppConstants.minNameLength} characters';
    }
    return null;
  }
  
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    final cleanNumber = value.replaceAll(RegExp(r'[\s-]'), '');
    
    if (cleanNumber.length != AppConstants.phoneNumberLength) {
      return 'Phone number must be ${AppConstants.phoneNumberLength} digits';
    }
    
    if (!RegExp(r'^03\d{9}$').hasMatch(cleanNumber)) {
      return 'Invalid phone number format (must start with 03)';
    }
    
    return null;
  }
  
  static String? validateCNIC(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    final cleanCNIC = value.replaceAll(RegExp(r'[\s-]'), '');
    
    if (cleanCNIC.length != AppConstants.cnicLength) {
      return 'CNIC must be ${AppConstants.cnicLength} digits';
    }
    
    if (!RegExp(r'^\d{13}$').hasMatch(cleanCNIC)) {
      return 'CNIC must contain only digits';
    }
    
    return null;
  }
  
  static String? validateMeasurement(String? value, {double? min, double? max}) {
    if (value == null || value.isEmpty) {
      return null;
    }
    
    final measurement = double.tryParse(value);
    
    if (measurement == null) {
      return 'Invalid number';
    }
    
    if (min != null && measurement < min) {
      return 'Value must be at least $min cm';
    }
    
    if (max != null && measurement > max) {
      return 'Value must be at most $max cm';
    }
    
    return null;
  }
  
  static String? validatePhone(String? value) => validatePhoneNumber(value);
  static String? validateCnic(String? value) => validateCNIC(value);

  static String? validateAmount(String? value, {bool required = false}) {
    if (value == null || value.isEmpty) {
      return required ? 'Amount is required' : null;
    }
    
    final amount = double.tryParse(value);
    
    if (amount == null) {
      return 'Invalid amount';
    }
    
    if (amount < 0) {
      return 'Amount cannot be negative';
    }
    
    return null;
  }
}
