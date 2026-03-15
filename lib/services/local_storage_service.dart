import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_storage_service.g.dart';

class LocalStorageService {
  LocalStorageService(this._prefs);

  final SharedPreferences _prefs;

  static const _themeModeKey = 'theme_mode';

  Future<void> setThemeMode(String mode) async {
    await _prefs.setString(_themeModeKey, mode);
  }

  String? getThemeMode() {
    return _prefs.getString(_themeModeKey);
  }
}

@riverpod
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) async {
  return SharedPreferences.getInstance();
}

@riverpod
Future<LocalStorageService> localStorageService(
  LocalStorageServiceRef ref,
) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return LocalStorageService(prefs);
}

