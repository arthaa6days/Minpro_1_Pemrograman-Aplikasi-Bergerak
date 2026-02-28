# Minpro_1_Pemrograman-Aplikasi-Bergerak

# 🎟️ Konser Island - Aplikasi Manajemen Tiket Konser

## Deskripsi Aplikasi

Konser Island adalah aplikasi mobile sederhana berbasis **Flutter** yang digunakan untuk mengelola data tiket konser. Aplikasi ini memungkinkan pengguna untuk menyimpan informasi tiket konser yang dimiliki seperti nama konser, nama artis, tanggal konser, venue, dan harga tiket.

Melalui aplikasi ini, pengguna dapat dengan mudah menambahkan tiket baru, melihat daftar tiket yang sudah disimpan, mengedit informasi tiket, serta menghapus tiket yang tidak diperlukan. Aplikasi ini dibuat untuk mempelajari dasar pengembangan aplikasi mobile menggunakan Flutter serta implementasi operasi **CRUD (Create, Read, Update, Delete)**.

---

## Fitur Aplikasi

### 1. Menampilkan Daftar Tiket

Halaman utama aplikasi menampilkan seluruh tiket konser yang telah ditambahkan oleh pengguna. Setiap tiket ditampilkan dalam bentuk kartu yang berisi informasi konser seperti nama konser, artis, tanggal, venue, dan harga tiket.

### 2. Menambahkan Tiket

Pengguna dapat menambahkan tiket konser baru melalui tombol **(+)** yang tersedia pada halaman utama. Setelah tombol ditekan, pengguna akan diarahkan ke halaman form untuk mengisi data tiket konser.

### 3. Mengedit Tiket

Setiap tiket yang telah ditambahkan dapat diedit dengan menekan ikon **edit**. Data tiket yang dipilih akan ditampilkan kembali di halaman form sehingga pengguna dapat memperbarui informasi tiket tersebut.

### 4. Menghapus Tiket

Pengguna dapat menghapus tiket konser dengan menekan ikon **delete** pada tiket yang diinginkan. Sebelum tiket dihapus, aplikasi akan menampilkan dialog konfirmasi untuk memastikan tindakan pengguna.

---

## Widget yang Digunakan

Beberapa widget utama yang digunakan dalam pembuatan aplikasi ini antara lain:

* **MaterialApp**
  Digunakan sebagai root widget untuk mengatur struktur dasar aplikasi Flutter berbasis Material Design.

* **Scaffold**
  Digunakan sebagai kerangka utama halaman yang berisi AppBar, body, dan FloatingActionButton.

* **AppBar**
  Menampilkan judul aplikasi pada bagian atas halaman.

* **ListView.builder**
  Digunakan untuk menampilkan daftar tiket konser secara dinamis.

* **Card**
  Digunakan untuk menampilkan setiap data tiket dalam bentuk kartu agar tampilan lebih rapi.

* **ListTile**
  Digunakan untuk menampilkan informasi tiket seperti nama konser, artis, tanggal, dan venue.

* **FloatingActionButton**
  Tombol untuk menambahkan tiket konser baru.

* **IconButton**
  Digunakan untuk tombol edit dan delete pada setiap tiket.

* **AlertDialog**
  Digunakan untuk menampilkan konfirmasi sebelum tiket dihapus.

* **TextFormField**
  Digunakan sebagai input form untuk mengisi data tiket seperti nama konser, artis, venue, tanggal, dan harga.

* **Navigator**
  Digunakan untuk berpindah halaman dari HomePage ke halaman form tiket dan kembali lagi setelah data disimpan.

* **TextEditingController**
  Digunakan untuk mengontrol dan mengambil nilai dari input form pada halaman penambahan tiket.
