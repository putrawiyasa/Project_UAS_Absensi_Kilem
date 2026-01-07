import 'dart:io';
import 'package:flutter/material.dart';

import '../../core/services/location_service.dart';
import '../../core/services/api_service.dart';
import 'camera_page.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({super.key});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  File? foto;
  double? lat;
  double? lng;
  bool loading = false;
  Future<void> ambilFoto() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CameraPage()),
    );

    if (result != null && result is String) {
      setState(() {
        foto = File(result);
      });
    }
  }

  Future<void> ambilLokasi() async {
    try {
      final position = await LocationService.getLocation();

      if (position == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Gagal mengambil lokasi')));
        return;
      }

      setState(() {
        lat = position.latitude;
        lng = position.longitude;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> kirimAbsensi() async {
    if (foto == null || lat == null || lng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto & lokasi wajib diisi')),
      );
      return;
    }

    setState(() => loading = true);

    try {
      await ApiService.postAbsensi(
        foto: foto!,
        latitude: lat!,
        longitude: lng!,
      );

      ApiService.riwayatAbsensi.insert(0, {
        'foto': foto!.path,
        'lat': lat,
        'lng': lng,
        'waktu': DateTime.now().toString(),
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Absensi berhasil')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal kirim absensi: $e')));
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005CB0);

    return Scaffold(
      backgroundColor: const Color.fromARGB(94, 0, 91, 176),
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Absensi', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: foto != null
                    ? Image.file(foto!, height: 220, fit: BoxFit.cover)
                    : Container(
                        height: 220,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 8),
                              Text('Belum ada foto'),
                            ],
                          ),
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: lat != null ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        lat != null
                            ? 'Lokasi: $lat , $lng'
                            : 'Lokasi belum diambil',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: ambilFoto,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Ambil Foto Absensi'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: ambilLokasi,
              icon: const Icon(Icons.my_location),
              label: const Text('Pilih Lokasi Terkini'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: loading ? null : kirimAbsensi,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: loading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Kirim Absensi',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}
