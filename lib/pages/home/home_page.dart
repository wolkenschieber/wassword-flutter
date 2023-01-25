import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wassword/pages/home/views/passphrase_view.dart';
import 'package:wassword/pages/home/views/password_view.dart';
import 'package:wassword/provider/tab_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedTab = ref.watch(tabProvider);
    List<Widget> tabList = <Widget>[
      const PasswordView(),
      const PassphraseView(),
    ];
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        // status bar colortatus bar brightness
        title: const Text("Wassword"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
                iconSize: 24,
                icon: const Icon(Icons.settings),
                onPressed: () => context.push('/about')),
          ),
        ],
      ),
      body: tabList[selectedTab],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: colorScheme.primary.withAlpha(170),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            ref.read(tabProvider.notifier).update((state) => index);
          },
          selectedIndex: selectedTab,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.vpn_key),
              label: 'Password',
            ),
            NavigationDestination(
              icon: Icon(Icons.text_fields),
              label: 'Passphrase',
            ),
          ],
        ),
      ),
    );
  }
}
