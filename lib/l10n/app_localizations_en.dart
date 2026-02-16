// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Shelf Life';

  @override
  String get yourProducts => 'Your Products';

  @override
  String get addProduct => 'Add Product';

  @override
  String get noTagsCreated => 'No Tags Created';

  @override
  String get filterByTags => 'Filter by Tags';

  @override
  String get manageTags => 'Manage Tags';

  @override
  String get settings => 'Settings';

  @override
  String get testAlert => 'Test alert';

  @override
  String get tags => 'Tags';

  @override
  String get addNewTag => 'Add a new tag';

  @override
  String get tagCannotBeEmpty => 'Tag cannot be empty!';

  @override
  String tagAlreadyExists(String tag) {
    return '$tag already exists';
  }

  @override
  String get selectColor => 'Select a Color';

  @override
  String get done => 'Done';

  @override
  String get notificationTime => 'Notification Time';

  @override
  String get currency => 'Currency';

  @override
  String get addNewProduct => 'Add New Product';

  @override
  String get productName => 'Product Name';

  @override
  String get productPurpose => 'Product Purpose';

  @override
  String get price => 'Price';

  @override
  String get monthsToReplacement => 'Months to Replacement';

  @override
  String get getAgain => 'Get Again';

  @override
  String get cancel => 'Cancel';

  @override
  String get editTags => 'Edit Tags';

  @override
  String get save => 'Save';

  @override
  String get add => 'Add';

  @override
  String get selectTags => 'Select Tags';

  @override
  String get noTagsToSelect => 'No Tags to Select';

  @override
  String get getAgainYes => 'Get Again: Yes';

  @override
  String get getAgainNo => 'Get Again: No';

  @override
  String monthsToReplacementLabel(String months) {
    return 'Months to Replacement: $months';
  }

  @override
  String cost(String currency, String price) {
    return 'Cost: $currency$price';
  }

  @override
  String notificationTitle(String name) {
    return '$name reaching the end of its shelf life';
  }

  @override
  String get notificationBody =>
      'To extend its shelf-life, open the app to reset.';

  @override
  String get notificationChannelName => 'ShelfLife Notification';

  @override
  String get notificationChannelDescription =>
      'Channel for notification of a product drawing to the end of its shelf-life';
}
