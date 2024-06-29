import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({super.key, required this.text, this.trailingIcon});

  final String text;
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: ListTile(
        leading: const Icon(CupertinoIcons.circle),
        trailing: trailingIcon,
        title: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 20,
              ),
        ),
      ),
    );
  }
}
