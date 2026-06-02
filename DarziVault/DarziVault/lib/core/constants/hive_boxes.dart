class HiveBoxes {
  HiveBoxes._();
  
  static const String clients = 'clients_box';
  static const String measurements = 'measurements_box';
  static const String orders = 'orders_box';
  static const String settings = 'settings_box';
  static const String shopProfile = 'shop_profile_box';
  static const String notifications = 'notifications_box';
}

class HiveTypeIds {
  HiveTypeIds._();
  
  static const int client = 0;
  static const int measurement = 5; // Incremented from 1 to 5 for custom fields migration
  static const int order = 2;
  static const int settings = 3;
  static const int shopProfile = 4;
  static const int notification = 6;
}
