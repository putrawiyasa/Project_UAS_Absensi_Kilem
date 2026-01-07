import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position?> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // CEK GPS AKTIF
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('GPS tidak aktif');
    }

    // CEK PERMISSION
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Izin lokasi ditolak');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Izin lokasi ditolak permanen, aktifkan di setting',
      );
    }

    // AMBIL LOKASI
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
