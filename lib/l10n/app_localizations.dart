import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Shelf Life'**
  String get appTitle;

  /// No description provided for @yourProducts.
  ///
  /// In en, this message translates to:
  /// **'Your Products'**
  String get yourProducts;

  /// No description provided for @addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// No description provided for @noTagsCreated.
  ///
  /// In en, this message translates to:
  /// **'No Tags Created'**
  String get noTagsCreated;

  /// No description provided for @filterByTags.
  ///
  /// In en, this message translates to:
  /// **'Filter by Tags'**
  String get filterByTags;

  /// No description provided for @manageTags.
  ///
  /// In en, this message translates to:
  /// **'Manage Tags'**
  String get manageTags;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @testAlert.
  ///
  /// In en, this message translates to:
  /// **'Test alert'**
  String get testAlert;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @addNewTag.
  ///
  /// In en, this message translates to:
  /// **'Add a new tag'**
  String get addNewTag;

  /// No description provided for @tagCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Tag cannot be empty!'**
  String get tagCannotBeEmpty;

  /// No description provided for @tagAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'{tag} already exists'**
  String tagAlreadyExists(String tag);

  /// No description provided for @selectColor.
  ///
  /// In en, this message translates to:
  /// **'Select a Color'**
  String get selectColor;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @notificationTime.
  ///
  /// In en, this message translates to:
  /// **'Notification Time'**
  String get notificationTime;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @addNewProduct.
  ///
  /// In en, this message translates to:
  /// **'Add New Product'**
  String get addNewProduct;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get productName;

  /// No description provided for @productPurpose.
  ///
  /// In en, this message translates to:
  /// **'Product Purpose'**
  String get productPurpose;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @monthsToReplacement.
  ///
  /// In en, this message translates to:
  /// **'Months to Replacement'**
  String get monthsToReplacement;

  /// No description provided for @getAgain.
  ///
  /// In en, this message translates to:
  /// **'Get Again'**
  String get getAgain;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @editTags.
  ///
  /// In en, this message translates to:
  /// **'Edit Tags'**
  String get editTags;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @selectTags.
  ///
  /// In en, this message translates to:
  /// **'Select Tags'**
  String get selectTags;

  /// No description provided for @noTagsToSelect.
  ///
  /// In en, this message translates to:
  /// **'No Tags to Select'**
  String get noTagsToSelect;

  /// No description provided for @getAgainYes.
  ///
  /// In en, this message translates to:
  /// **'Get Again: Yes'**
  String get getAgainYes;

  /// No description provided for @getAgainNo.
  ///
  /// In en, this message translates to:
  /// **'Get Again: No'**
  String get getAgainNo;

  /// No description provided for @monthsToReplacementLabel.
  ///
  /// In en, this message translates to:
  /// **'Months to Replacement: {months}'**
  String monthsToReplacementLabel(String months);

  /// No description provided for @cost.
  ///
  /// In en, this message translates to:
  /// **'Cost: {currency}{price}'**
  String cost(String currency, String price);

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'{name} reaching the end of its shelf life'**
  String notificationTitle(String name);

  /// No description provided for @notificationBody.
  ///
  /// In en, this message translates to:
  /// **'To extend its shelf-life, open the app to reset.'**
  String get notificationBody;

  /// No description provided for @notificationChannelName.
  ///
  /// In en, this message translates to:
  /// **'ShelfLife Notification'**
  String get notificationChannelName;

  /// No description provided for @notificationChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'Channel for notification of a product drawing to the end of its shelf-life'**
  String get notificationChannelDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
