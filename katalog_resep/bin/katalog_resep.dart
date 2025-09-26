import 'dart:io';

// Class
class Resep {
  final String id;
  String judul;
  List<String> bahan;
  List<String> langkah;

  String? kategori;   // nullable
  double? rating;     // --------

  Resep({
    required this.id,
    required this.judul,
    required this.bahan,
    required this.langkah,
    this.kategori,
    this.rating,
  });

  void tampilkanDetail() {
    print("\n=== Detail Resep ===");
    print("Judul     : $judul");
    print("Kategori  : ${kategori ?? "Belum ditentukan"}"); // Null Conditional
    print("Bahan     : ${bahan.join(', ')}");
    print("Langkah   : ${langkah.join(' -> ')}");
    print("Rating    : ${rating?.toStringAsFixed(1) ?? "Belum dinilai"}"); // Null Conditional

    // Ternary operator
    String status = (rating != null && rating! >= 4.0)
        ? "Rekomendasi 👍"
        : "Biasa saja 👌";
    print("Status    : $status");
  }
}

class ResepManager {
  final List<Resep> _resepList = [];

  void tambahResep(Resep r) => _resepList.add(r);

  void tampilkanSemua() {
    if (_resepList.isEmpty) {
      print("Belum ada resep tersimpan.");
      return;
    }
    print("\n=== Daftar Resep ===");
    for (var r in _resepList) {
      print("- ${r.judul} (${r.kategori ?? "Umum"})");
    }
  }

  Resep? cariResep(String judul) {
    try {
      return _resepList.firstWhere(
        (r) => r.judul.toLowerCase() == judul.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }
}

// CLI 
void main() {
  final manager = ResepManager();

  while (true) {
    print("\n=== MENU KATALOG RESEP ===");
    print("1. Tambah Resep");
    print("2. Lihat Semua Resep");
    print("3. Cari Resep");
    print("4. Keluar");

    stdout.write("Pilih menu: ");
    String? pilihan = stdin.readLineSync();

    switch (pilihan) {
      case '1':
        stdout.write("Judul Resep: ");
        String? judul = stdin.readLineSync();

        stdout.write("Bahan (pisahkan dengan koma): ");
        String? inputBahan = stdin.readLineSync();
        List<String> bahan =
            inputBahan?.split(',').map((e) => e.trim()).toList() ?? [];

        stdout.write("Langkah (pisahkan dengan koma): ");
        String? inputLangkah = stdin.readLineSync();
        List<String> langkah =
            inputLangkah?.split(',').map((e) => e.trim()).toList() ?? [];

        stdout.write("Kategori (opsional): ");
        String? kategori = stdin.readLineSync();
        kategori =
            (kategori != null && kategori.isNotEmpty) ? kategori : null;

        stdout.write("Rating (opsional, 0-5): ");
        String? ratingStr = stdin.readLineSync();
        double? rating = double.tryParse(ratingStr ?? '');

        var resep = Resep(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          judul: judul ?? "Tanpa Judul",
          bahan: bahan,
          langkah: langkah,
          kategori: kategori,
          rating: rating,
        );
        manager.tambahResep(resep);
        print("Resep berhasil ditambahkan!");
        break;

      case '2':
        manager.tampilkanSemua();
        break;

      case '3':
        stdout.write("Masukkan judul resep: ");
        String? cari = stdin.readLineSync();
        var hasil = manager.cariResep(cari ?? "");

        if (hasil != null) {
          hasil.tampilkanDetail();
        } else {
          print("Resep tidak ditemukan.");
        }
        break;

      case '4':
        print("Terima kasih, keluar aplikasi.");
        return;

      default:
        print("Pilihan tidak valid!");
    }
  }
}