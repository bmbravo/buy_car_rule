import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(int screenIndex) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.secondaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.car_detailed,
                  size: 60,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Text(
                    '20/4/10',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 28,
                        ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.straighten,
              size: 26,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              AppLocalizations.of(context)!.newCalculation,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 26,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              AppLocalizations.of(context)!.settingsScreenTitle,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen(1);
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                '${AppLocalizations.of(context)!.developedBy} Bill Bravo',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 18,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
