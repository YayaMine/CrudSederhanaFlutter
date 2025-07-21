import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sertifikasi/helpers/database_helpers.dart';
import 'package:sertifikasi/models/item_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  final TextEditingController _itemQuantityController = TextEditingController();
  final TextEditingController _itemSellingPriceController =
      TextEditingController();
  final TextEditingController _tanggalMasukController =
      TextEditingController(); // Renamed
  final DatabaseHelper _dbHelper = DatabaseHelper();
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemPriceController.dispose();
    _itemQuantityController.dispose();
    _itemSellingPriceController.dispose();
    _tanggalMasukController.dispose(); // Updated dispose
    super.dispose();
  }

  Future<void> _loadItems() async {
    await _dbHelper.getItems();
    setState(() {});
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _showSnackBar('Tidak ada gambar yang dipilih.', Colors.orange);
      }
    });
  }

  Future<void> _addItem() async {
    final String itemName = _itemNameController.text.trim();
    final String itemPrice = _itemPriceController.text.trim();
    final String itemQuantityStr = _itemQuantityController.text.trim();
    final String itemSellingPrice = _itemSellingPriceController.text.trim();
    final String tanggalMasuk =
        _tanggalMasukController.text.trim(); // Get tanggalMasuk

    if (itemName.isEmpty ||
        itemPrice.isEmpty ||
        itemQuantityStr.isEmpty ||
        itemSellingPrice.isEmpty ||
        tanggalMasuk.isEmpty) {
      // Check if tanggalMasuk is empty
      _showSnackBar('Semua kolom harus diisi!', Colors.red);
      return;
    }

    final int? itemQuantity = int.tryParse(itemQuantityStr);
    if (itemQuantity == null || itemQuantity <= 0) {
      _showSnackBar('Jumlah barang harus angka positif!', Colors.red);
      return;
    }

    final newItem = Item(
      name: itemName,
      price: itemPrice,
      quantity: itemQuantity,
      sellingPrice: itemSellingPrice,
      imagePath: _image?.path,
      tanggalMasuk: tanggalMasuk, // Pass tanggalMasuk
    );

    try {
      int result = await _dbHelper.insertItem(newItem);
      if (result != -1) {
        _showSnackBar('Barang "$itemName" berhasil ditambahkan!', Colors.green);
        _itemNameController.clear();
        _itemPriceController.clear();
        _itemQuantityController.clear();
        _itemSellingPriceController.clear();
        _tanggalMasukController.clear(); // Clear tanggalMasuk controller
        setState(() {
          _image = null;
        });
        _loadItems();
      } else {
        _showSnackBar(
          'Gagal menambahkan barang. Silakan coba lagi.',
          Colors.red,
        );
      }
    } catch (e) {
      _showSnackBar(
        'Terjadi kesalahan saat menambahkan barang: $e',
        Colors.red,
      );
      print('Error adding item: $e');
    }
  }

  Future<void> _selectTanggalMasuk(BuildContext context) async {
    // Renamed
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('id', 'ID'),
    );
    if (picked != null) {
      setState(() {
        _tanggalMasukController.text = DateFormat(
          // Use _tanggalMasukController
          "d MMMM yyyy",
          "id_ID",
        ).format(picked);
      });
    }
  }

  Future<void> _deleteItem(int id) async {
    await _dbHelper.deleteItem(id);
    _showSnackBar('Barang berhasil dihapus!', Colors.blue);
    _loadItems();
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Builder(
          builder: (BuildContext context) {
            final Size screenSize = MediaQuery.of(context).size;
            final double screenWidth = screenSize.width;
            final double screenHeight = screenSize.height;
            final bool isTablet = screenWidth > 600;

            final double appBarTopPadding =
                screenHeight * (isTablet ? 0.03 : 0.02);
            final double welcomeTextSize =
                screenWidth * (isTablet ? 0.03 : 0.04);
            final double enjoyShoppingTextSize =
                screenWidth * (isTablet ? 0.04 : 0.05);

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Padding(
                padding: EdgeInsets.only(top: appBarTopPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Welcome Back',
                              style: GoogleFonts.roboto(
                                color: Colors.black.withOpacity(0.2),
                                fontSize: welcomeTextSize,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            SvgPicture.asset(
                              'assets/images/hand-shake-svgrepo-com (1).svg',
                              height: screenHeight * (isTablet ? 0.03 : 0.025),
                              width: screenWidth * (isTablet ? 0.04 : 0.05),
                            ),
                          ],
                        ),
                        Text(
                          'Enjoy guys',
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: enjoyShoppingTextSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 10.0,
              ),
              color: const Color(0xFF14A741),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Tambah Barang Baru',
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white),
                          image:
                              _image != null
                                  ? DecorationImage(
                                    image: FileImage(_image!),
                                    fit: BoxFit.cover,
                                  )
                                  : null,
                        ),
                        child:
                            _image == null
                                ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.image,
                                      size: 50,
                                      color: Colors.white70,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Ketuk untuk Tambah Gambar',
                                      style: GoogleFonts.roboto(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                )
                                : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _itemNameController,
                      style: GoogleFonts.roboto(color: Colors.white),
                      decoration: _buildInputDecoration(
                        'Nama Barang',
                        'Masukkan nama barang',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _itemPriceController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.roboto(color: Colors.white),
                      decoration: _buildInputDecoration(
                        'Harga Beli',
                        'Masukkan harga beli barang',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _itemQuantityController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.roboto(color: Colors.white),
                      decoration: _buildInputDecoration(
                        'Jumlah Barang',
                        'Masukkan jumlah barang',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _itemSellingPriceController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.roboto(color: Colors.white),
                      decoration: _buildInputDecoration(
                        'Harga Jual',
                        'Masukkan harga jual barang',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _tanggalMasukController,
                      readOnly: true,
                      style: GoogleFonts.roboto(color: Colors.white),
                      decoration: _buildInputDecoration(
                        'Tanggal Masuk',
                        'Pilih tanggal masuk barang',
                      ).copyWith(
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                          color: Colors.white70,
                        ),
                      ),
                      onTap: () => _selectTanggalMasuk(context),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: _addItem,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF14A741),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 50,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Tambah Barang',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.roboto(color: Colors.white70),
      hintText: hint,
      hintStyle: GoogleFonts.roboto(color: Colors.white70),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white),
      ),
    );
  }
}
