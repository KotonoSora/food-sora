import 'package:flutter/material.dart';
import 'package:foodsora/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('theme');
    switch (theme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme.name);
  }

  /// Loads the User's preferred Locale from local or remote storage.
  Future<Locale> locale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');
    String? countryCode = prefs.getString('countryCode');

    if (languageCode != null) {
      Locale persistsLocale = Locale(languageCode, countryCode);
      if (S.delegate.isSupported(persistsLocale)) return persistsLocale;
    }

    return const Locale.fromSubtags(
      languageCode: 'en',
      countryCode: 'US',
    );
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateLocale(Locale locale) async {
    if (S.delegate.isSupported(locale)) {
      await S.load(locale);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('languageCode', locale.languageCode);
      await prefs.setString('countryCode', locale.countryCode!);
    }
  }
}
