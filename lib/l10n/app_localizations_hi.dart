// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'शेल्फ लाइफ';

  @override
  String get yourProducts => 'आपके उत्पाद';

  @override
  String get addProduct => 'उत्पाद जोड़ें';

  @override
  String get noTagsCreated => 'कोई टैग नहीं बनाया गया';

  @override
  String get filterByTags => 'टैग के अनुसार फ़िल्टर करें';

  @override
  String get manageTags => 'टैग प्रबंधित करें';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get testAlert => 'परीक्षण अलर्ट';

  @override
  String get tags => 'टैग';

  @override
  String get addNewTag => 'नया टैग जोड़ें';

  @override
  String get tagCannotBeEmpty => 'टैग खाली नहीं हो सकता!';

  @override
  String tagAlreadyExists(String tag) {
    return '$tag पहले से मौजूद है';
  }

  @override
  String get selectColor => 'एक रंग चुनें';

  @override
  String get changeTagColor => 'टैग का रंग बदलें';

  @override
  String get deleteTag => 'टैग हटाएं';

  @override
  String tagDeleted(String tag) {
    return '$tag हटा दिया गया';
  }

  @override
  String get done => 'हो गया';

  @override
  String get notificationTime => 'सूचना समय';

  @override
  String get currency => 'मुद्रा';

  @override
  String get addNewProduct => 'नया उत्पाद जोड़ें';

  @override
  String get productName => 'उत्पाद का नाम';

  @override
  String get productPurpose => 'उत्पाद का उद्देश्य';

  @override
  String get price => 'कीमत';

  @override
  String get monthsToReplacement => 'बदलने तक के महीने';

  @override
  String get getAgain => 'फिर से लें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get editTags => 'टैग संपादित करें';

  @override
  String get save => 'सहेजें';

  @override
  String get add => 'जोड़ें';

  @override
  String get selectTags => 'टैग चुनें';

  @override
  String get noTagsToSelect => 'चुनने के लिए कोई टैग नहीं';

  @override
  String get getAgainYes => 'फिर से लें: हाँ';

  @override
  String get getAgainNo => 'फिर से लें: नहीं';

  @override
  String monthsToReplacementLabel(String months) {
    return 'बदलने तक के महीने: $months';
  }

  @override
  String monthsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count महीने बचे हैं',
      one: '1 महीना बचा है',
    );
    return '$_temp0';
  }

  @override
  String get overdue => 'समय सीमा समाप्त';

  @override
  String get emptyShelfTitle => 'आपकी शेल्फ पर अभी कुछ नहीं है';

  @override
  String get emptyShelfBody =>
      'जो चीज़ें आप दोबारा खरीदते हैं उन्हें जोड़ें, और शेल्फ लाइफ आपको बताएगा कि उन्हें कब बदलना है।';

  @override
  String get duplicateProduct => 'डुप्लिकेट';

  @override
  String get editProduct => 'संपादित करें';

  @override
  String get deleteProduct => 'हटाएं';

  @override
  String productDeleted(String name) {
    return '$name हटा दिया गया';
  }

  @override
  String get undo => 'पूर्ववत करें';

  @override
  String get clearFilter => 'फ़िल्टर साफ़ करें';

  @override
  String cost(String currency, String price) {
    return 'लागत: $currency$price';
  }

  @override
  String notificationTitle(String name) {
    return '$name की शेल्फ लाइफ समाप्त होने वाली है';
  }

  @override
  String get notificationBody =>
      'इसकी शेल्फ लाइफ बढ़ाने के लिए, रीसेट करने हेतु ऐप खोलें।';

  @override
  String get notificationChannelName => 'शेल्फ लाइफ सूचना';

  @override
  String get notificationChannelDescription =>
      'किसी उत्पाद की शेल्फ लाइफ समाप्त होने के बारे में सूचना के लिए चैनल';
}
