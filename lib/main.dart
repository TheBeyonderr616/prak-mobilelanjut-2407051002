import 'package:flutter/material.dart';
import 'package:prkatikum_1_syawal_putra_akbar/coloumn_widget.dart';
import 'package:prkatikum_1_syawal_putra_akbar/row_widget.dart';
import 'first_widget.dart';
import 'form_widget.dart';
// 1. Tambahkan import file media Anda di sini
import 'assets_media.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum Mobile Lanjut',
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ), 

      home: const AssetsMediaPage(),
    ); 
  }
}