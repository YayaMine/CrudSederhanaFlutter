import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sertifikasi/helpers/database_helpers.dart';
import 'package:sertifikasi/models/item_model.dart';

class Listbarang extends StatefulWidget {
  const Listbarang({super.key});

  @override
  State<Listbarang> createState() => _ListbarangState();
}

class _ListbarangState extends State<Listbarang> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await _dbHelper.getItems();
    setState(() {
      _items = items;
    });
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

  void _showItemDetail(Item item) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            item.name,
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.imagePath != null &&
                    File(item.imagePath!).existsSync())
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      File(item.imagePath!),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      Icons.category,
                      size: 80,
                      color: Colors.grey[600],
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  'Harga Beli: Rp${item.price}',
                  style: GoogleFonts.roboto(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Jumlah: ${item.quantity}',
                  style: GoogleFonts.roboto(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Harga Jual: Rp${item.sellingPrice}',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tanggal Masuk: ${item.tanggalMasuk ?? 'Tidak ada'}',
                  style: GoogleFonts.roboto(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    _editItem(item);
                  },
                  child: Text(
                    'Edit',
                    style: GoogleFonts.roboto(color: Colors.orange),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    _deleteItem(item.id!);
                  },
                  child: Text(
                    'Hapus',
                    style: GoogleFonts.roboto(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    'Tutup',
                    style: GoogleFonts.roboto(
                      color: Theme.of(dialogContext).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _editItem(Item item) async {
    final TextEditingController editNameController = TextEditingController(
      text: item.name,
    );
    final TextEditingController editPriceController = TextEditingController(
      text: item.price,
    );
    final TextEditingController editQuantityController = TextEditingController(
      text: item.quantity.toString(),
    );
    final TextEditingController editSellingPriceController =
        TextEditingController(text: item.sellingPrice);
    final TextEditingController editTanggalMasukController =
        TextEditingController(text: item.tanggalMasuk);
    File? editedImage =
        item.imagePath != null && File(item.imagePath!).existsSync()
            ? File(item.imagePath!)
            : null;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                'Edit Barang',
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final picker = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                        );
                        if (picker != null) {
                          setDialogState(() {
                            editedImage = File(picker.path);
                          });
                        } else {
                          _showSnackBar(
                            'Tidak ada gambar yang dipilih.',
                            Colors.orange,
                          );
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                          image:
                              editedImage != null
                                  ? DecorationImage(
                                    image: FileImage(editedImage!),
                                    fit: BoxFit.cover,
                                  )
                                  : null,
                        ),
                        child:
                            editedImage == null
                                ? Icon(
                                  Icons.add_a_photo,
                                  color: Colors.grey[600],
                                )
                                : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: editNameController,
                      decoration: InputDecoration(
                        labelText: 'Nama Barang',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: editPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Harga Beli',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: editQuantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Jumlah Barang',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: editSellingPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Harga Jual',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: editTanggalMasukController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Tanggal Masuk',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate:
                              item.tanggalMasuk != null &&
                                      item.tanggalMasuk!.isNotEmpty
                                  ? DateFormat(
                                    "d MMMM yyyy",
                                    "id_ID",
                                  ).parse(item.tanggalMasuk!)
                                  : DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          locale: const Locale('id', 'ID'),
                        );
                        if (picked != null) {
                          setDialogState(() {
                            editTanggalMasukController.text = DateFormat(
                              "d MMMM yyyy",
                              "id_ID",
                            ).format(picked);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Batal',
                    style: GoogleFonts.roboto(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String newName = editNameController.text.trim();
                    final String newPrice = editPriceController.text.trim();
                    final String newQuantityStr =
                        editQuantityController.text.trim();
                    final String newSellingPrice =
                        editSellingPriceController.text.trim();
                    final String newTanggalMasuk =
                        editTanggalMasukController.text.trim();

                    if (newName.isEmpty ||
                        newPrice.isEmpty ||
                        newQuantityStr.isEmpty ||
                        newSellingPrice.isEmpty ||
                        newTanggalMasuk.isEmpty) {
                      _showSnackBar('Semua kolom harus diisi!', Colors.red);
                      return;
                    }

                    final int? newQuantity = int.tryParse(newQuantityStr);
                    if (newQuantity == null || newQuantity <= 0) {
                      _showSnackBar(
                        'Jumlah barang harus angka positif!',
                        Colors.red,
                      );
                      return;
                    }

                    final updatedItem = Item(
                      id: item.id,
                      name: newName,
                      price: newPrice,
                      quantity: newQuantity,
                      sellingPrice: newSellingPrice,
                      imagePath: editedImage?.path,
                      date: item.date,
                      tanggalMasuk: newTanggalMasuk,
                    );

                    await _dbHelper.updateItem(updatedItem);
                    _showSnackBar('Barang berhasil diperbarui!', Colors.green);
                    _loadItems();
                    Navigator.of(context).pop();
                  },
                  child: Text('Simpan', style: GoogleFonts.roboto()),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Barang',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF14A741),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Barang Tersedia',
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF14A741),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child:
                  _items.isEmpty
                      ? Center(
                        child: Text(
                          'Belum ada barang ditambahkan.',
                          style: GoogleFonts.roboto(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      )
                      : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                              childAspectRatio: 0.7,
                            ),
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          final item = _items[index];
                          return GestureDetector(
                            onTap: () => _showItemDetail(item),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                        color: Colors.grey[200],
                                      ),
                                      child:
                                          item.imagePath != null &&
                                                  File(
                                                    item.imagePath!,
                                                  ).existsSync()
                                              ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.file(
                                                  File(item.imagePath!),
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                              : Icon(
                                                Icons.category,
                                                size: 50,
                                                color: Colors.grey[600],
                                              ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      item.name,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Rp${item.sellingPrice}',
                                      style: GoogleFonts.roboto(
                                        color: Colors.green[700],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Stok: ${item.quantity}',
                                          style: GoogleFonts.roboto(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          item.tanggalMasuk ?? '',
                                          style: GoogleFonts.roboto(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
