import 'package:buy_car_rule/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageState = ref.watch(languageProvider);
    final languageNotifier = ref.read(languageProvider.notifier);

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              RadioListTile(
                title: Text(
                  AppLocalizations.of(context)!.english,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                value: 'en',
                groupValue: languageState['language'],
                onChanged: (value) {
                  languageNotifier.setLanguage(value!);
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
                groupValue: languageState['language'],
                onChanged: (value) {
                  languageNotifier.setLanguage(value!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
