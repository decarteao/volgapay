import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const VolgaPay());
}

class VolgaPay extends StatelessWidget {
  const VolgaPay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (ctx) => const Home()
      },
    );
  }
}
