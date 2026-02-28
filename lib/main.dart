import 'package:flutter/material.dart';
import 'package:aplikasi_manajemen_tiket_konser/page/home_page.dart';

void main() {
  runApp(const KonserApp());
}

class KonserApp extends StatelessWidget {
  const KonserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konser Island',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
