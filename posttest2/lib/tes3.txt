import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Resep',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomePage(),
    );
  }
}

// page 1 / home 
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void showComingSoon(BuildContext context, String fitur) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Fitur $fitur"),
        content: const Text("Coming Soon 🚧"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget resepItem(BuildContext context, String judul, String kategori,
      String rating, String deskripsi) {
    return Container(
      width: 320,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey[700]!, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // tempat gambar
          Container(
            height: 120,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            judul,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Kategori: $kategori"),
              Text(rating),
            ],
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(
                    judul: judul,
                    kategori: kategori,
                    rating: rating,
                    deskripsi: deskripsi,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              color: Colors.grey[800],
              child: const Text(
                "Lihat Detail",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Katalog Resep"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showComingSoon(context, "Cari Resep"),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //fitur
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () => showComingSoon(context, "Tambah Resep"),
                        icon: const Icon(Icons.add_circle, size: 40),
                        color: Colors.grey[800],
                      ),
                      const Text("Tambah Resep"),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () =>
                            showComingSoon(context, "Lihat Semua Resep"),
                        icon: const Icon(Icons.list_alt, size: 40),
                        color: Colors.grey[800],
                      ),
                      const Text("Lihat Semua"),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () =>
                            showComingSoon(context, "Edit/Hapus Resep"),
                        icon: const Icon(Icons.edit, size: 40),
                        color: Colors.grey[800],
                      ),
                      const Text("Edit Resep"),
                    ],
                  ),
                ],
              ),
            ),

            //resep
            resepItem(
              context,
              "Sate Ayam Madura",
              "Makanan Utama",
              "⭐ 4.7",
              "Daging Kecil ditusuk, lalu dibakar dan diberi kacang oleh madura",
            ),
            resepItem(
              context,
              "Es Campur Segar",
              "Minuman",
              "⭐ 4.5",
              "Es dicampur dengan kesegaran murni dari tembakau pilihan",
            ),
            resepItem(
              context,
              "Nasi Goreng Spesial",
              "Makanan Utama",
              "⭐ 4.8",
              "Makanan sejuta umat yang gampang dibikin",
            ),
            resepItem(
              context,
              "Pisang Goreng Crispy",
              "Dessert",
              "⭐ 4.6",
              "Hihang khoreng nama aslinya",
            ),
          ],
        ),
      ),
    );
  }
}

//Page2 detail Makanan
class DetailPage extends StatelessWidget {
  final String judul;
  final String kategori;
  final String rating;
  final String deskripsi;

  const DetailPage({
    super.key,
    required this.judul,
    required this.kategori,
    required this.rating,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 320,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.grey[700]!, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 3 gambar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey[400],
                      child: const Center(
                        child: Text("1", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey[500],
                      child: const Center(
                        child: Text("2", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey[600],
                      child: const Center(
                        child: Text("3", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  judul,
                  style:
                      const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Kategori: $kategori"),
                    Text(rating),
                  ],
                ),
                const SizedBox(height: 10),
                Text("Deskripsi: $deskripsi"),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    color: Colors.grey[800],
                    child: const Text(
                      "Kembali",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
