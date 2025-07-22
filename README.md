# 📱 Aplikasi CRUD Barang — Flutter + SQLite

Aplikasi Flutter sederhana untuk mencatat data barang secara **offline**. Mendukung tambah, edit, hapus, dan lihat data barang lengkap dengan gambar, nama, harga, serta waktu input menggunakan database lokal **SQLite**.

---

## ✨ Fitur

- ➕ Tambah barang baru + upload gambar dari galeri
- 📝 Edit dan hapus data barang
- 📃 Tampilkan daftar barang
- 🧠 Validasi input (misalnya: password minimal 6 karakter)
- 💾 Simpan data secara offline dengan SQLite

---

## 🛠️ Teknologi

| Teknologi     | Deskripsi                                  |
| ------------- | ------------------------------------------ |
| Flutter       | Framework utama untuk aplikasi mobile      |
| Dart          | Bahasa pemrograman untuk Flutter           |
| SQLite        | Database lokal untuk menyimpan data barang |
| Image Picker  | Ambil gambar dari galeri perangkat         |
| Path Provider | Akses path penyimpanan file lokal          |

---

## 🔐 Validasi Form

Aplikasi menggunakan validasi sederhana untuk memastikan input tidak kosong dan password minimal 6 karakter. Contoh:

```dart
if (password.length < 6) {
  _showSnackBar('Password minimal 6 karakter', Colors.red);
  return;
}
```

```bash
    flutter run

    git clone https://github.com/YayaMine/CrudSederhanaFlutter.git
```
