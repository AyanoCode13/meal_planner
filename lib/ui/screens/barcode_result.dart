// home_screen.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _scannedBarcode;
  String? _productName;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_scannedBarcode != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Scanned Barcode',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _scannedBarcode!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, letterSpacing: 1.1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
            Text(_productName != null ? 'Product: $_productName' : 'No product information'),
            ElevatedButton.icon(
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scan Barcode'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () async {
                final result = await context.push<String>('/scanner');
                if (result != null) {
                  setState(() => _scannedBarcode = result);
                  final dio = Dio();
                  final response = await dio.get('https://world.openfoodfacts.org/api/v2/product/$result');
                  setState(() {
                    _productName = (response.data['product']['_keywords'] as List<String>).join(', ');
                    
                  });
                  print(response.data);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
