import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shop_profile_model.dart';
import '../services/hive_service.dart';

class SettingsRepository {
  final HiveService _hiveService;

  SettingsRepository(this._hiveService);

  // Shop Profile
  ShopProfileModel? getShopProfile() {
    return _hiveService.shopProfileBox.values.firstOrNull;
  }

  Future<void> saveShopProfile(ShopProfileModel profile) async {
    await _hiveService.shopProfileBox.put('profile', profile);
  }

  // Settings key-value
  T? get<T>(String key) => _hiveService.settingsBox.get(key) as T?;

  Future<void> set(String key, dynamic value) async {
    await _hiveService.settingsBox.put(key, value);
  }

  // Theme
  String getTheme() => get<String>('theme') ?? 'light';
  Future<void> setTheme(String theme) => set('theme', theme);

  // Language
  String getLanguage() => get<String>('language') ?? 'en';
  Future<void> setLanguage(String language) => set('language', language);

  // Notifications
  bool getNotificationsEnabled() => get<bool>('notifications') ?? true;
  Future<void> setNotificationsEnabled(bool enabled) =>
      set('notifications', enabled);
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final hiveService = ref.watch(hiveServiceProvider);
  return SettingsRepository(hiveService);
});
