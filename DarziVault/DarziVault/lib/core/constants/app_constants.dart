class AppConstants {
  AppConstants._();
  
  static const String appName = 'DarziVault';
  static const String appTagline = 'Your Digital Measurement Vault';
  static const String version = '1.0.0';
  
  static const int splashDuration = 3000;
  static const int toastDuration = 2000;
  
  static const int minNameLength = 3;
  static const int phoneNumberLength = 11;
  static const int cnicLength = 13;
  
  static const int maxPhotosPerMeasurement = 5;
  static const int maxImageSizeKB = 2048;
  
  static const double minHeight = 100.0;
  static const double maxHeight = 250.0;
  static const double minMeasurement = 10.0;
  static const double maxMeasurement = 200.0;
  
  static const String orderIdPrefix = 'DV-';
  static const int orderIdLength = 4;
}
