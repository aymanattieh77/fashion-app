import 'package:fashion_app/view/Wallets/widgets/wallet_appbar.dart';
import 'package:flutter/material.dart';

class MyWalletsScreen extends StatelessWidget {
  const MyWalletsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WalletAppbar(),
      body: Container(),
    );
  }
}
