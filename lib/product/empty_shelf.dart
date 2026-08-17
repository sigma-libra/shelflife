import 'package:flutter/material.dart';
import 'package:shelflife/l10n/app_localizations.dart';
import 'package:shelflife/product/jar_gauge.dart';

/// What a first-time user sees: one empty jar, flagged, and a line telling
/// them what the app is for.
class EmptyShelf extends StatelessWidget {
  const EmptyShelf({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const JarGauge(life: ShelfLife.none, height: 132, alert: true),
            const SizedBox(height: 32),
            Text(
              AppLocalizations.of(context)!.emptyShelfTitle,
              textAlign: TextAlign.center,
              style: text.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.emptyShelfBody,
              textAlign: TextAlign.center,
              style: text.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
