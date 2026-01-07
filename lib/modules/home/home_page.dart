import 'package:flutter/material.dart';
import '../absensi/absensi_page.dart';
import '../riwayat/riwayat_page.dart';
import '../jadwal/jadwal_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const primaryColor = Color(0xFF005CB0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(94, 0, 91, 176),
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _menu(
            context,
            Icons.camera_alt,
            'Absensi',
            'Lakukan absensi harian',
            const AbsensiPage(),
          ),
          _menu(
            context,
            Icons.history,
            'Riwayat',
            'Lihat riwayat absensi',
            const RiwayatPage(),
          ),
          _menu(
            context,
            Icons.schedule,
            'Jadwal',
            'Lihat jadwal kegiatan',
            const JadwalPage(),
          ),
        ],
      ),
    );
  }

  Widget _menu(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget page,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (_) => page));

        setState(() {});
      },
      child: Card(
        elevation: 4,
        shadowColor: Colors.black12,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 28, color: primaryColor),
              ),

              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
