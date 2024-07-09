import 'package:buy_car_rule/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.languageSettings,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                height: 30,
                thickness: 1,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              RadioListTile(
                title: Text(
                  AppLocalizations.of(context)!.english,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                value: 'en',
                groupValue: settingsState['language'] as String,
                onChanged: (value) {
                  settingsNotifier.setLanguage(value!);
                },
              ),
              RadioListTile(
                title: Text(
                  AppLocalizations.of(context)!.spanish,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                value: 'es',
                groupValue: settingsState['language'] as String,
                onChanged: (value) {
                  settingsNotifier.setLanguage(value!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
