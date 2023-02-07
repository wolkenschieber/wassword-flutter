import 'package:flutter/material.dart';
import 'package:wassword/styles/dimens.dart';

class AboutRow extends StatelessWidget {
  const AboutRow(
      {Key? key,
      required this.title,
      required this.icon,
      required this.callback})
      : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: Dimens.mainMargin,
        vertical: Dimens.tinyMargin,
      ),
      elevation: 2,
      child: ListTile(
        onTap: callback,
        leading: Icon(
          icon,
          size: 24,
          color: colorScheme.onSurface,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
