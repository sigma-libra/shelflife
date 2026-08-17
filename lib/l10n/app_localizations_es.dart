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
  String monthsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Quedan $count meses',
      one: 'Queda 1 mes',
    );
    return '$_temp0';
  }

  @override
  String get overdue => 'Vencido';

  @override
  String get emptyShelfTitle => 'Tu estante está vacío';

  @override
  String get emptyShelfBody =>
      'Añade lo que vuelves a comprar y Shelf Life te avisará cuando toque reemplazarlo.';

  @override
  String get duplicateProduct => 'Duplicar';

  @override
  String get editProduct => 'Editar';

  @override
  String get deleteProduct => 'Eliminar';

  @override
  String productDeleted(String name) {
    return '$name eliminado';
  }

  @override
  String get undo => 'Deshacer';

  @override
  String get clearFilter => 'Borrar filtro';

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
