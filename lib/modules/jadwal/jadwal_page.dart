import 'package:flutter/material.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  static const primaryColor = Color(0xFF005CB0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(94, 0, 91, 176),
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Jadwal Kerja',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _ItemJadwal(hari: 'Senin', jam: '08:00 - 17:00'),
          _ItemJadwal(hari: 'Selasa', jam: '08:00 - 17:00'),
          _ItemJadwal(hari: 'Rabu', jam: '08:00 - 17:00'),
          _ItemJadwal(hari: 'Kamis', jam: '08:00 - 17:00'),
          _ItemJadwal(hari: 'Jumat', jam: '08:00 - 16:00'),
        ],
      ),
    );
  }
}

class _ItemJadwal extends StatelessWidget {
  final String hari;
  final String jam;

  const _ItemJadwal({required this.hari, required this.jam});

  static const primaryColor = Color(0xFF005CB0);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.calendar_today,
                color: primaryColor,
                size: 24,
              ),
            ),

            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hari,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    jam,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
