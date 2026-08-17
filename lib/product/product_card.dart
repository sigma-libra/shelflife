import 'package:flutter/material.dart';
import 'package:shelflife/colors.dart';
import 'package:shelflife/l10n/app_localizations.dart';
import 'package:shelflife/product/jar_gauge.dart';
import 'package:shelflife/product/product.dart';
import 'package:shelflife/tag/tag.dart';

/// Header/title clearance for the corner actions. Matches the visible 24dp
/// squares' original footprint (8dp from the top edge), not the larger
/// invisible touch target around them.
const double _actionClearance = 28.0;

/// Android's minimum touch target. The visible control stays 24dp at its
/// original position — 8dp from the top and right edges, 32dp pitch between
/// the two — and this invisible area is centred on top of it, rather than
/// growing the visible footprint outward.
const double _touchTarget = 48.0;
const double _touchInset = (_touchTarget - 24.0) / 2;
const double _actionTop = 8.0 - _touchInset;
const double _editRight = 8.0 - _touchInset;
const double _duplicateRight = 8.0 + 32.0 - _touchInset;

/// The jar's own top offset. It shares no horizontal space with the corner
/// buttons, so it doesn't need their clearance — instead its centre lines up
/// with the product name's line (title text starts at _actionClearance and
/// runs about 24dp tall), which leaves less empty header space above it than
/// borrowing the title's clearance did.
const double _jarHeight = 56.0;
const double _jarTop = _actionClearance + 24.0 / 2 - _jarHeight / 2;

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onDuplicate;
  final List<Tag> tags;
  final String currencySymbol;

  const ProductCard(
      {super.key,
      required this.product,
      required this.onDelete,
      required this.onEdit,
      required this.onDuplicate,
      required this.tags,
      required this.currencySymbol});

  @override
  Widget build(BuildContext context) {
    final tagMap = {for (var v in tags) v.name: v};
    final life = ShelfLife.of(product);
    return Dismissible(
      key: Key(product.productId.toString()),
      // One direction only, so a stray horizontal flick while scrolling a
      // reorderable list cannot destroy a product from either side.
      direction: DismissDirection.endToStart,
      background: _swipeToDelete(context),
      onDismissed: (dismissed) => onDelete(),
      child: Card(
        color: SHELF_BROWN,
        elevation: 4,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  tileColor: SHELF_TOP_BROWN,
                  leading: Padding(
                    padding: const EdgeInsets.only(top: _jarTop),
                    child: JarGauge(life: life, height: _jarHeight),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: _actionClearance),
                    child: Text(
                      product.name,
                      style: defaultTextStyle(),
                    ),
                  ),
                  subtitle: Text(
                    product.purpose,
                    style: defaultTextStyle(),
                  ),
                ),
                Padding(
                  // A uniform gap after every line, rather than each optional
                  // field carrying its own padding, so the block reads the
                  // same whichever fields a product happens to have.
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final line in [
                        if (life.state != ShelfLifeState.untracked)
                          Text(
                            life.state == ShelfLifeState.overdue
                                ? AppLocalizations.of(context)!.overdue
                                : AppLocalizations.of(context)!.monthsLeft(life.monthsLeft),
                            style: lifeTextStyle(context),
                          ),
                        // Only spoken when true. "No" is the absence of the line.
                        if (product.replace)
                          Text(
                            AppLocalizations.of(context)!.getAgainYes,
                            style: defaultTextStyle(),
                          ),
                        if (product.price != null)
                          Text(
                            AppLocalizations.of(context)!.cost(currencySymbol, product.price.toString()),
                            style: defaultTextStyle(),
                          ),
                      ]) ...[
                        line,
                        const SizedBox(height: 8.0),
                      ],
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (String tag in product.tags.where((tag) => tagMap.keys.contains(tag)))
                              Builder(builder: (context) {
                                final tagColor = Color(tagMap[tag]!.color);
                                return Chip(
                                  label: Text(tag),
                                  backgroundColor: tagColor,
                                  labelStyle: TextStyle(color: labelOn(tagColor)),
                                  side: const BorderSide(color: SHELF_BROWN),
                                  visualDensity: VisualDensity.compact,
                                );
                              }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // Delete is deliberately absent here. It is the one irreversible
            // action, so it lives on the swipe rather than sitting 8dp from
            // Edit at the top of the thumb's arc.
            Positioned(
              top: _actionTop,
              right: _duplicateRight,
              child: _cornerAction(
                icon: Icons.copy,
                label: AppLocalizations.of(context)!.duplicateProduct,
                onTap: onDuplicate,
              ),
            ),
            Positioned(
              top: _actionTop,
              right: _editRight,
              child: _cornerAction(
                icon: Icons.edit,
                label: AppLocalizations.of(context)!.editProduct,
                onTap: onEdit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// A 24dp square lid on a 48dp target. The square is the visible control;
  /// the surrounding space is invisible but tappable, so the corner meets
  /// Android's minimum without growing.
  Widget _cornerAction({required IconData icon, required String label, required VoidCallback onTap}) {
    return Tooltip(
      message: label,
      child: Semantics(
        button: true,
        label: label,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: _touchTarget,
            height: _touchTarget,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: defaultBoxDecoration(),
                child: Icon(icon, size: 16, color: BLACK_BROWN),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Revealed as the card slides away, so the consequence is visible before
  /// the gesture completes.
  Widget _swipeToDelete(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.onError),
    );
  }

  TextStyle defaultTextStyle() {
    return const TextStyle(color: BLACK_BROWN);
  }

  /// One size at every state: the jar carries urgency, so the line does not
  /// need to jump. Resolved from a Material role rather than a literal size so
  /// system font scaling still governs.
  TextStyle? lifeTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium?.copyWith(color: BLACK_BROWN);
  }

  BoxDecoration defaultBoxDecoration() {
    return const BoxDecoration(
      shape: BoxShape.rectangle,
      color: JAR_GREEN,
      // JAR_GREEN sits at 1.53:1 against SHELF_BROWN — well under the 3:1 a
      // control boundary needs — so the square's own edge carries the
      // separation with the one color in the system built for that job.
      border: Border.fromBorderSide(BorderSide(color: BLACK_BROWN, width: 1)),
    );
  }
}
