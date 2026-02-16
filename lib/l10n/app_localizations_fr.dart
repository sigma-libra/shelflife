// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Durée de conservation';

  @override
  String get yourProducts => 'Vos produits';

  @override
  String get addProduct => 'Ajouter un produit';

  @override
  String get noTagsCreated => 'Aucune étiquette créée';

  @override
  String get filterByTags => 'Filtrer par étiquettes';

  @override
  String get manageTags => 'Gérer les étiquettes';

  @override
  String get settings => 'Paramètres';

  @override
  String get testAlert => 'Alerte de test';

  @override
  String get tags => 'Étiquettes';

  @override
  String get addNewTag => 'Ajouter une nouvelle étiquette';

  @override
  String get tagCannotBeEmpty => 'L\'étiquette ne peut pas être vide!';

  @override
  String tagAlreadyExists(String tag) {
    return '$tag existe déjà';
  }

  @override
  String get selectColor => 'Sélectionner une couleur';

  @override
  String get done => 'Terminé';

  @override
  String get notificationTime => 'Heure de notification';

  @override
  String get currency => 'Devise';

  @override
  String get addNewProduct => 'Ajouter un nouveau produit';

  @override
  String get productName => 'Nom du produit';

  @override
  String get productPurpose => 'Utilisation du produit';

  @override
  String get price => 'Prix';

  @override
  String get monthsToReplacement => 'Mois avant remplacement';

  @override
  String get getAgain => 'Racheter';

  @override
  String get cancel => 'Annuler';

  @override
  String get editTags => 'Modifier les étiquettes';

  @override
  String get save => 'Enregistrer';

  @override
  String get add => 'Ajouter';

  @override
  String get selectTags => 'Sélectionner les étiquettes';

  @override
  String get noTagsToSelect => 'Aucune étiquette à sélectionner';

  @override
  String get getAgainYes => 'Racheter: Oui';

  @override
  String get getAgainNo => 'Racheter: Non';

  @override
  String monthsToReplacementLabel(String months) {
    return 'Mois avant remplacement: $months';
  }

  @override
  String cost(String currency, String price) {
    return 'Coût: $currency$price';
  }

  @override
  String notificationTitle(String name) {
    return '$name arrive à la fin de sa durée de conservation';
  }

  @override
  String get notificationBody =>
      'Pour prolonger sa durée de conservation, ouvrez l\'application pour réinitialiser.';

  @override
  String get notificationChannelName => 'Notification Durée de conservation';

  @override
  String get notificationChannelDescription =>
      'Canal pour la notification d\'un produit arrivant à la fin de sa durée de conservation';
}
