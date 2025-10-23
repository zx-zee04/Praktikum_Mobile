import 'package:flutter/material.dart';

void main() {
  runApp(const ChefApp());
}

class ChefApp extends StatelessWidget {
  const ChefApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Resep Chef',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      routes: {
        '/signin': (_) => const SignInPage(),
        '/home': (_) => const HomeShell(),
        '/settings': (_) => const SettingsPage(),
      },
      initialRoute: '/signin',
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool agree = false;
  bool remember = false;
  bool showPassword = false;

  void _login() {
    if (emailC.text.isEmpty || passC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Di-isilah itu!')),
      );
      return;
    }
    if (!agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ketentuan diklik dulu!')),
      );
      return;
    }
    if (emailC.text == 'admin123' && passC.text == 'admin123') {
      Navigator.pushReplacementNamed(context, '/home');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selamat datang Chef!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ingat" yang benar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Chef')),
      body: Center(
        child: Container(
          width: 340,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.grey[700]!, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Selamat Datang Chef!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailC,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Chef',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: passC,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(showPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() => showPassword = !showPassword);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: agree,
                    onChanged: (v) => setState(() => agree = v ?? false),
                  ),
                  const Expanded(
                    child: Text('Saya menyetujui kebijakan dan ketentuan.'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Ingat saya'),
                  Switch(
                    value: remember,
                    activeColor: Colors.black,
                    onChanged: (v) => setState(() => remember = v),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text('MASUK SEBAGAI CHEF'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  final List<Map<String, String>> _recipes = [
    {
      'title': 'Sate Ayam Madura',
      'category': 'Makanan Utama',
      'desc': 'Ayam bakar dengan bumbu kacang khas Madura.'
    },
    {
      'title': 'Nasi Goreng Spesial',
      'category': 'Makanan Utama',
      'desc': 'Nasi goreng sederhana yang jadi favorit semua orang.'
    },
    {
      'title': 'Pisang Goreng Crispy',
      'category': 'Dessert',
      'desc': 'Pisang goreng renyah dan manis untuk sore hari.'
    },
  ];
  final List<Map<String, String>> _recommended = [];

  void _addToRecommendation(Map<String, String> recipe) {
    if (!_recommended.contains(recipe)) {
      setState(() {
        _recommended.add(recipe);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${recipe['title']} ditambahkan ke rekomendasi!')),
      );
    }
  }

  void _addNewRecipe(Map<String, String> newRecipe) {
    setState(() {
      _recipes.add(newRecipe);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Resep "${newRecipe['title']}" berhasil ditambahkan!')),
    );
  }

  void _deleteRecipe(Map<String, String> recipe) {
    setState(() {
      _recipes.remove(recipe);
      _recommended.remove(recipe);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Resep "${recipe['title']}" dihapus!')),
    );
  }

  void _onTap(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final pages = [
      RecipesPage(
        recipes: _recipes,
        onAddToRekom: _addToRecommendation,
        onAddRecipe: _addNewRecipe,
        onDeleteRecipe: _deleteRecipe,
      ),
      RecommendationsPage(rekomendasi: _recommended),
      const ProfilePage(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(['Resep Chef', 'Rekomendasi', 'Profil Chef'][_index]),
        centerTitle: true,
        actions: [
          if (_index == 0)
            IconButton(
              onPressed: () {
                (pages[0] as RecipesPage).showAddRecipeDialog(context);
              },
              icon: const Icon(Icons.add_circle_outline),
            ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _onTap,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu), label: 'Resep'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border), label: 'Rekomendasi'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}

class RecipesPage extends StatelessWidget {
  final List<Map<String, String>> recipes;
  final Function(Map<String, String>) onAddToRekom;
  final Function(Map<String, String>) onAddRecipe;
  final Function(Map<String, String>) onDeleteRecipe;

  const RecipesPage({
    super.key,
    required this.recipes,
    required this.onAddToRekom,
    required this.onAddRecipe,
    required this.onDeleteRecipe,
  });

  void showAddRecipeDialog(BuildContext context) {
    final titleC = TextEditingController();
    final categoryC = TextEditingController();
    final descC = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Tambah Resep Baru"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleC,
                decoration: const InputDecoration(labelText: 'Judul Resep'),
              ),
              TextField(
                controller: categoryC,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              TextField(
                controller: descC,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleC.text.isEmpty || categoryC.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Judul dan kategori wajib diisi!')),
                );
                return;
              }
              final newRecipe = {
                'title': titleC.text,
                'category': categoryC.text,
                'desc': descC.text.isNotEmpty
                    ? descC.text
                    : 'Deskripsi belum ditambahkan.',
              };
              onAddRecipe(newRecipe);
              Navigator.pop(ctx);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return recipes.isEmpty
        ? const Center(
            child: Text(
              'Belum ada resep.\nTambahkan resep menggunakan tombol + di atas.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: recipes.length,
            itemBuilder: (context, i) {
              final r = recipes[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey[700]!, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 120, color: Colors.grey[400]),
                    const SizedBox(height: 8),
                    Text(
                      r['title']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Kategori: ${r['category']}'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailPage(
                                    title: r['title']!,
                                    category: r['category']!,
                                    rating: '',
                                    desc: r['desc']!,
                                  ),
                                ),
                              );
                            },
                            child: const Text('Lihat Detail'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => onAddToRekom(r),
                            icon: const Icon(Icons.star_border),
                            label: const Text('Rekomendasi'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => onDeleteRecipe(r),
                            icon: const Icon(Icons.delete_outline),
                            label: const Text('Hapus'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final String category;
  final String rating;
  final String desc;

  const DetailPage({
    super.key,
    required this.title,
    required this.category,
    required this.rating,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 340,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.grey[700]!, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 90, height: 90, color: Colors.grey[400]),
                    Container(width: 90, height: 90, color: Colors.grey[500]),
                    Container(width: 90, height: 90, color: Colors.grey[600]),
                  ],
                ),
                const SizedBox(height: 16),
                Text(title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Kategori: $category'),
                const SizedBox(height: 8),
                Text('Deskripsi: $desc'),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Kembali'),
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

class RecommendationsPage extends StatelessWidget {
  final List<Map<String, String>> rekomendasi;

  const RecommendationsPage({super.key, required this.rekomendasi});

  @override
  Widget build(BuildContext context) {
    return rekomendasi.isEmpty
        ? const Center(
            child: Text(
              'Belum ada rekomendasi.\nTambahkan dari halaman Resep!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          )
        : ListView(
            padding: const EdgeInsets.all(16),
            children: rekomendasi
                .map(
                  (r) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey[700]!, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "⭐ ${r['title']} (${r['category']})",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
                .toList(),
          );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: Stack(
              children: [
                Container(height: 140, color: Colors.grey[300]),
                Align(
                  alignment: const Alignment(0, 1.1),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          Container(
            width: 340,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.grey[700]!, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chef Madhan', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('Email: mnrdhan04@gmail.com'),
                SizedBox(height: 6),
                Text('Tentang: Seorang chef profesional yang suka masak memasak dan membagikan resepnya hehe.'),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan Chef'), centerTitle: true),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.grey[700]!, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Pengaturan Aplikasi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('• Mode: Terang\n• Notifikasi: Aktif\n• Bahasa: Indonesia'),
            ],
          ),
        ),
      ),
    );
  }
}