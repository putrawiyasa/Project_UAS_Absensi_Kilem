import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/services/api_service.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  static const primaryColor = Color(0xFF005CB0);

  @override
  Widget build(BuildContext context) {
    final riwayat = ApiService.riwayatAbsensi;

    return Scaffold(
      backgroundColor: const Color.fromARGB(94, 0, 91, 176),
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Riwayat Absensi',
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: riwayat.isEmpty
          ? const Center(
              child: Text(
                'Belum ada riwayat absensi',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: riwayat.length,
              itemBuilder: (context, index) {
                final item = riwayat[index];

                return Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(item['foto']),
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['waktu'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: primaryColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      'Lat: ${item['lat']} | Lng: ${item['lng']}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
