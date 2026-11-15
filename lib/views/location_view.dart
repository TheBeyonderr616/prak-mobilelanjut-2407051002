import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  final LocationService _locationService = LocationService();
  Position? _position;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _getLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final position = await _locationService.getCurrentLocation();
      if (!mounted) return;
      setState(() => _position = position);
    } on PermissionDeniedException {
      _errorMessage =
          'Izin lokasi ditolak. Izinkan lokasi melalui pengaturan situs browser.';
    } on LocationServiceDisabledException {
      _errorMessage = 'Layanan lokasi tidak aktif atau tidak tersedia.';
    } catch (e) {
      _errorMessage = 'Lokasi gagal diperoleh: $e';
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informasi Lokasi Perangkat')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on, size: 72, color: Colors.blue),
              const SizedBox(height: 16),
              const Text(
                'Device Location Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              if (_isLoading) const CircularProgressIndicator(),
              if (_position != null && !_isLoading) ...[
                Text('Latitude: ${_position!.latitude}'),
                const SizedBox(height: 8),
                Text('Longitude: ${_position!.longitude}'),
                const SizedBox(height: 8),
                Text(
                  'Akurasi: ${_position!.accuracy.toStringAsFixed(2)} meter',
                ),
              ],
              if (_errorMessage != null) ...[
                const Icon(Icons.info_outline, color: Colors.orange, size: 32),
                const SizedBox(height: 8),
                Text(_errorMessage!, textAlign: TextAlign.center),
              ],
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _getLocation,
                icon: const Icon(Icons.my_location),
                label: const Text('Ambil Lokasi Saya'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}