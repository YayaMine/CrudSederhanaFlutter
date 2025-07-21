📦 Simple Inventory CRUD App with Flutter & SQLite
Selamat datang di proyek aplikasi inventaris sederhana yang dibangun dengan Flutter! Aplikasi ini memungkinkan Anda untuk mengelola daftar barang dengan kemampuan Create, Read, Update, dan Delete (CRUD), serta mendukung penambahan gambar untuk setiap item. Data disimpan secara lokal menggunakan SQLite.

✨ Fitur Utama
Tambah Barang Baru: Masukkan nama barang, harga, dan tambahkan gambar dari galeri atau kamera Anda.

Lihat Daftar Barang: Tampilkan semua item dalam daftar yang mudah diakses.

Edit Barang: Perbarui detail nama, harga, atau gambar untuk item yang sudah ada.

Hapus Barang: Hapus item yang tidak lagi diperlukan dari inventaris.

Penyimpanan Lokal: Semua data, termasuk gambar, disimpan dengan aman di perangkat menggunakan SQLite.

🛠️ Teknologi yang Digunakan
Flutter: Framework UI untuk membangun aplikasi mobile yang indah secara native.

Dart: Bahasa pemrograman yang digunakan oleh Flutter.

SQLite: Database relasional ringan untuk penyimpanan data lokal.

sqflite: Plugin Flutter untuk interaksi dengan SQLite.

image_picker: Plugin Flutter untuk memilih gambar dari galeri/kamera.

path_provider: Plugin Flutter untuk menemukan lokasi penyimpanan file.

google_fonts: Menggunakan font dari Google Fonts.

shared_preferences: Untuk menyimpan data preferensi sederhana.

local_auth: Untuk otentikasi biometrik (sidik jari/wajah).

path: Utilitas untuk manipulasi path.

url_launcher: Untuk meluncurkan URL di browser atau aplikasi lain.

flutter_svg: Untuk menampilkan gambar SVG.

flutter_localization: Untuk dukungan lokalisasi dan internasionalisasi.

📸 Tampilan Aplikasi (Screenshots)
(Mohon tambahkan screenshot aplikasi Anda di sini untuk memberikan gambaran visual kepada pengguna. Contoh: daftar barang, form tambah/edit barang.)

[asets/images/register.jpg]
[Tambahkan Screenshot 2 di sini]
[Tambahkan Screenshot 3 di sini]

🚀 Memulai Proyek
Ikuti langkah-langkah ini untuk menjalankan proyek ini di mesin lokal Anda.

Prasyarat
Pastikan Anda telah menginstal:

Flutter SDK

Dart SDK

Instalasi
Clone repository ini:

git clone https://github.com/nama-pengguna-anda/nama-repo-anda.git
cd nama-repo-anda

(Ganti https://github.com/nama-pengguna-anda/nama-repo-anda.git dengan URL repository Anda yang sebenarnya.)

Dapatkan dependensi Flutter:

flutter pub get

Tambahkan dependensi tambahan (jika belum ada di pubspec.yaml):

flutter pub add google_fonts sqflite shared_preferences local_auth path url_launcher image_picker flutter_svg flutter_localization

Jalankan aplikasi:

flutter run

Pilih perangkat (emulator atau perangkat fisik) untuk menjalankan aplikasi.

💡 Cara Menggunakan Aplikasi
Pada layar utama, Anda akan melihat daftar barang yang sudah ada (jika ada).

Untuk menambah barang baru, klik tombol + (biasanya di pojok kanan bawah). Isi detail barang dan pilih gambar.

Untuk mengedit barang, ketuk item di daftar. Ini akan membawa Anda ke layar detail/edit di mana Anda bisa mengubah informasi.

Untuk menghapus barang, di layar detail/edit, cari tombol hapus (biasanya ikon tempat sampah).

🛣️ Pengembangan di Masa Depan (Opsional)
Menambahkan fitur pencarian dan filter.

Implementasi validasi input yang lebih kompleks.

Sinkronisasi data ke cloud (misalnya Firebase Firestore).

Fitur kategori barang.

🤝 Kontribusi
Kontribusi disambut baik! Jika Anda memiliki ide atau perbaikan, silakan:

Fork repository ini.

Buat branch baru (git checkout -b feature/NamaFiturBaru).

Lakukan perubahan Anda.

Commit perubahan Anda (git commit -m 'feat: Menambahkan Nama Fitur').

Push ke branch Anda (git push origin feature/NamaFiturBaru).

Buat Pull Request.

📄 Lisensi
Proyek ini dilisensikan di bawah Lisensi MIT - lihat file LICENSE untuk detailnya.
