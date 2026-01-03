// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Vida útil';

  @override
  String get yourProducts => 'Sus productos';

  @override
  String get addProduct => 'Añadir producto';

  @override
  String get noTagsCreated => 'No hay etiquetas creadas';

  @override
  String get filterByTags => 'Filtrar por etiquetas';

  @override
  String get manageTags => 'Gestionar etiquetas';

  @override
  String get settings => 'Configuración';

  @override
  String get testAlert => 'Alerta de prueba';

  @override
  String get tags => 'Etiquetas';

  @override
  String get addNewTag => 'Añadir una nueva etiqueta';

  @override
  String get tagCannotBeEmpty => '¡La etiqueta no puede estar vacía!';

  @override
  String tagAlreadyExists(String tag) {
    return '$tag ya existe';
  }

  @override
  String get selectColor => 'Seleccionar un color';

  @override
  String get done => 'Hecho';

  @override
  String get notificationTime => 'Hora de notificación';

  @override
  String get currency => 'Moneda';

  @override
  String get addNewProduct => 'Añadir nuevo producto';

  @override
  String get productName => 'Nombre del producto';

  @override
  String get productPurpose => 'Uso del producto';

  @override
  String get price => 'Precio';

  @override
  String get monthsToReplacement => 'Meses hasta el reemplazo';

  @override
  String get getAgain => 'Comprar de nuevo';

  @override
  String get cancel => 'Cancelar';

  @override
  String get editTags => 'Editar etiquetas';

  @override
  String get save => 'Guardar';

  @override
  String get add => 'Añadir';

  @override
  String get selectTags => 'Seleccionar etiquetas';

  @override
  String get noTagsToSelect => 'No hay etiquetas para seleccionar';

  @override
  String get getAgainYes => 'Comprar de nuevo: Sí';

  @override
  String get getAgainNo => 'Comprar de nuevo: No';

  @override
  String monthsToReplacementLabel(String months) {
    return 'Meses hasta el reemplazo: $months';
  }

  @override
  String cost(String currency, String price) {
    return 'Costo: $currency$price';
  }

  @override
  String notificationTitle(String name) {
    return '$name llegando al final de su vida útil';
  }

  @override
  String get notificationBody =>
      'Para extender su vida útil, abra la aplicación para reiniciar.';

  @override
  String get notificationChannelName => 'Notificación de Vida útil';

  @override
  String get notificationChannelDescription =>
      'Canal para la notificación de un producto que llega al final de su vida útil';
}
