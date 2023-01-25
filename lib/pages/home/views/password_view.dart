import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wassword/provider/password.dart';
import 'package:wassword/provider/password_provider.dart';
import 'package:wassword/styles/dimens.dart';
import 'package:wassword/ui/action_button.dart';
import 'package:wassword/ui/custom_slider_thumb_circle.dart';
import 'package:wassword/ui/option_button.dart';
import 'package:wassword/ui/secret_card.dart';
import 'package:wassword/utils/utils.dart';

class PasswordView extends ConsumerWidget {
  const PasswordView({super.key});

  void _copyToClipboard(String newPassword) {
    Clipboard.setData(ClipboardData(text: newPassword));
    showToast("Password copied to clipboard");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    Password password = ref.watch(passwordProvider);
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: <Widget>[
        SecretCard(secretString: password.password),
        //https://medium.com/flutter-community/flutter-sliders-demystified-4b3ea65879c
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: colorScheme.primaryContainer,
            trackHeight: Dimens.heightSlider * 1.1,
            inactiveTrackColor: colorScheme.surfaceVariant,
            thumbColor: colorScheme.primaryContainer,
            thumbShape: CustomSliderThumbCircle(
              buildContext: context,
              thumbRadius: Dimens.heightSlider,
              value: password.length,
            ),
          ),
          child: Slider(
            min: 8.0,
            max: 128.0,
            divisions: 120,
            value: password.length.toDouble(),
            onChanged: (double value) =>
                ref.read(passwordProvider.notifier).changeLength(value.toInt()),
          ),
        ),
        const SizedBox(
          height: Dimens.mainSpace,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.mainPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              OptionButton(
                title: "Uppercase",
                description: "ABC",
                icon: Icons.title,
                active: password.withUppercase,
                callback: () =>
                    ref.read(passwordProvider.notifier).changeUppercase(),
              ),
              const SizedBox(
                width: Dimens.mainSpace,
              ),
              OptionButton(
                title: "Lowercase",
                description: "abc",
                icon: Icons.format_size,
                active: password.withLowercase,
                callback: () =>
                    ref.read(passwordProvider.notifier).changeLowercase(),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: Dimens.mainSpace,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.mainPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              OptionButton(
                title: "Numbers",
                description: "123",
                icon: Icons.looks_one,
                active: password.withNumbers,
                callback: () =>
                    ref.read(passwordProvider.notifier).changeNumbers(),
              ),
              const SizedBox(
                width: Dimens.mainSpace,
              ),
              OptionButton(
                title: "Special",
                description: "@£*",
                icon: Icons.star,
                active: password.withSpecial,
                callback: () =>
                    ref.read(passwordProvider.notifier).changeSpecial(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.mainPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              ActionButton(
                text: "Generate",
                icon: Icons.sync,
                isMain: true,
                callback: () =>
                    ref.read(passwordProvider.notifier).updatePassword(),
                width: screenWidth * .5,
              ),
              ActionButton(
                text: "Copy",
                icon: Icons.copy,
                isMain: false,
                callback: () => _copyToClipboard(password.password),
                width: screenWidth * .3,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: Dimens.hugeSpace,
        ),
      ],
    );
  }
}
