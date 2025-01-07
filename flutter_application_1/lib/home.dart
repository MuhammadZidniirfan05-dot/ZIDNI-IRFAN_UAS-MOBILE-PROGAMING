import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Photobook',
      'price': 'Rp. 5.000',
      'image': 'assets/photobook.jpg',
      'isAsset': true,
    },
    {
      'name': 'Merchandise',
      'price': 'Rp. 55.000',
      'image': 'assets/merchandise.jpg',
      'isAsset': true,
    },
    {
      'name': 'Co Card',
      'price': 'Rp. 70.000/m',
      'image': 'assets/co-card.jpg',
      'isAsset': true,
    },
    // Tambahkan elemen lainnya...
  ];

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _price = '';
  XFile? _image;

  void _showProductOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.edit, color: Colors.blue),
            title: Text('Edit'),
            onTap: () {
              Navigator.pop(context); // Tutup bottom sheet
              _showEditProductDialog(index);
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text('Delete'),
            onTap: () {
              Navigator.pop(context); // Tutup bottom sheet
              _deleteProduct(index);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showEditProductDialog(int index) async {
    final product = _products[index];
    _name = product['name'];
    _price = product['price'];
    // Jika gambar berasal dari assets, set _image ke null, jika tidak, ambil dari path
    _image = product['isAsset'] == true ? null : XFile(product['image']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Produk'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Nama Produk'),
                onChanged: (value) => _name = value,
              ),
              TextFormField(
                initialValue: _price,
                decoration: InputDecoration(labelText: 'Harga Produk'),
                onChanged: (value) => _price = value,
              ),
              SizedBox(height: 8),
              ElevatedButton.icon(
                icon: Icon(Icons.image),
                label: Text('Ganti Gambar'),
                onPressed: _pickImage,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              _updateProduct(index);
              Navigator.of(context).pop();
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _updateProduct(int index) {
    setState(() {
      _products[index] = {
        'name': _name,
        'price': _price,
        'image': _image?.path ??
            _products[index]['image'], // Menggunakan path dari gambar baru
        'isAsset': _image == null
            ? true
            : false, // Menandakan gambar baru berasal dari assets atau bukan
      };
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 50,
            ),
            SizedBox(width: 4),
            Text(
              'Masterprint Studio',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(128, 158, 158,
                          158), // 128 adalah alpha, dan 158 adalah RGB dari Colors.grey
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.red),
                    hintText: 'Cari Produk ...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),

            // Banner
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(128, 158, 158,
                          158), // 128 adalah alpha, dan 158 adalah RGB dari Colors.grey
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/photobook_new.jpg',
                    fit: BoxFit.cover,
                    height: 125,
                    width: double.infinity,
                  ),
                ),
              ),
            ),

            // Product Categories
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              child: Text(
                'PRODUK PER KATEGORI',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 2.3,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, index) {
                final icons = [
                  Icons.print,
                  Icons.label,
                  Icons.calendar_today,
                  Icons.flag,
                  Icons.image,
                  Icons.photo,
                  Icons.card_giftcard,
                  Icons.all_inbox,
                  Icons.layers,
                ];
                final labels = [
                  'Print on Paper',
                  'Sticker - Label',
                  'Kalender',
                  'MMT & Banner',
                  'Large Poster',
                  'Photography',
                  'Merchandise',
                  'Packaging',
                  'Offset Printing',
                ];
                return _buildCategoryItem(icons[index], labels[index]);
              },
            ),

            // Produk Unggulan
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PRODUK UNGGULAN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _showAddProductDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white, // Ubah teks menjadi putih
                    ),
                    child: Text('Tambah Produk'),
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 17 / 18,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, index) {
                final product = _products[index];
                return GestureDetector(
                  onLongPress: () => _showProductOptions(index),
                  child: _buildProductItem(
                    product['name'],
                    product['price'],
                    product['image'],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'History Order'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Status Order'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(128, 158, 158,
                158), // 128 adalah alpha, dan 158 adalah RGB dari Colors.grey

            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.red),
          SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(String name, String price, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(128, 158, 158,
                158), // 128 adalah alpha, dan 158 adalah RGB dari Colors.grey

            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
            child: kIsWeb
                ? Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                    height: 140,
                    width: double.infinity,
                  )
                : Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                    height: 140,
                    width: double.infinity,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                Text(
                  price,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddProductDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tambah Produk'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Produk'),
                onChanged: (value) => _name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Harga Produk'),
                onChanged: (value) => _price = value,
              ),
              SizedBox(height: 8),
              ElevatedButton.icon(
                icon: Icon(Icons.image),
                label: Text('Upload Gambar'),
                onPressed: _pickImage,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: _addProduct,
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate() && _image != null) {
      setState(() {
        _products.add({
          'name': _name,
          'price': _price,
          'image': _image!.path, // Gambar yang diunggah dari galeri
          'isAsset': false, // Menandakan gambar bukan dari assets
        });
      });
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Silakan pilih gambar terlebih dahulu.')),
      );
    }
  }

  void _deleteProduct(int index) {
    setState(() {
      // Hapus produk dari daftar berdasarkan index
      _products.removeAt(index);
    });

    // Tampilkan snackbar untuk memberikan feedback kepada pengguna
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Produk berhasil dihapus'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
