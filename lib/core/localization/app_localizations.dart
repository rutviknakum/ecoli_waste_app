import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'Waste Management',
      'home': 'Home',
      'services': 'Services',
      'about_us': 'About Us',
      'contact_us': 'Contact Us',
      'schedule_pickup': 'Schedule Pickup',
      'user_profile': 'User Profile',
      'ewaste': 'E-Waste Recycling',
      'plastic_waste': 'Plastic Waste',
      'biomedical_waste': 'Bio-Medical Waste',
      'submit': 'Submit',
      'save': 'Save',
      'cancel': 'Cancel',
    },
    'hi': {
      'app_title': 'अपशिष्ट प्रबंधन',
      'home': 'होम',
      'services': 'सेवाएं',
      'about_us': 'हमारे बारे में',
      'contact_us': 'संपर्क करें',
      'schedule_pickup': 'पिकअप शेड्यूल करें',
      'user_profile': 'उपयोगकर्ता प्रोफ़ाइल',
      'ewaste': 'ई-वेस्ट रीसाइक्लिंग',
      'plastic_waste': 'प्लास्टिक कचरा',
      'biomedical_waste': 'बायो-मेडिकल कचरा',
      'submit': 'जमा करें',
      'save': 'सहेजें',
      'cancel': 'रद्द करें',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
