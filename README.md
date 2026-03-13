
## PROJECT | APLIKASI MANAJEMEN TIKET KONSER | MINPRO 1 DAN 2
**Konser Island** adalah prototipe aplikasi mobile yang dibangun menggunakan Flutter, dirancang untuk manajemen siklus hidup tiket konser secara *end-to-end*. Aplikasi ini mengimplementasikan alur kerja **CRUD (Create, Read, Update, Delete)** lengkap yang terintegrasi dengan database relasional berbasis cloud.

Proyek ini mendemonstrasikan prinsip-prinsip *clean architecture*, desain UI yang responsif, dan integrasi backend yang aman menggunakan praktik Flutter modern.

---

## 🛠️ Teknologi & Integrasi

### 1. Backend: Infrastruktur Supabase
Aplikasi ini menggunakan **Supabase** sebagai *backend-as-a-service* (BaaS), memanfaatkan engine PostgreSQL untuk persistensi data.
*   **Pengambilan Data Real-time**: Diimplementasikan melalui client `supabase_flutter`.
*   **Keamanan**: Kredensial diabstraksikan ke dalam *environment variables* menggunakan `flutter_dotenv` untuk mencegah kebocoran data sensitif.
*   **Inisialisasi**:
    ```dart
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
    ```

### 2. Koneksi Database & Skema
Aplikasi berkomunikasi dengan tabel `konser`. Pemetaan data ditangani melalui model `Ticket` khusus dengan factory `fromJson` dan `toJson`.
*   **Pemetaan Input ke DB**: Input *front-end* dari `TextFormField` ditangkap melalui `TextEditingController` dan disanitasi sebelum dikirim ke Supabase:
    ```dart
    final ticketData = {
      'nama_konser': _nameController.text.trim(),
      'nama_artis': _artistController.text.trim(),
      'tanggal_konser': _dateController.text,
      'lokasi_venue': _venueController.text.trim(),
      'harga': _priceController.text.trim(),
    };
    ```

---

## 🚀 Fitur Utama

### 📊 Manajemen Data Dinamis
*   **Paginasi Teroptimasi**: Mengimplementasikan seleksi rentang di sisi server (`.range(from, to)`) untuk menangani dataset besar secara efisien.
*   **List/Grid Responsif**: Menggunakan `LayoutBuilder` untuk beralih antara `ListView` (mobile) dan `GridView` (tablet/desktop) berdasarkan batasan *viewport*.

### 📝 Penanganan Form Lanjutan
*   **Validasi**: Menggunakan `GlobalKey<FormState>` untuk validasi input yang sinkron.
*   **Orkestrasi Tanggal**: Integrasi `showDatePicker` untuk pemilihan tanggal standar ISO-8601.

---

## 🧩 Implementasi Widget Lanjutan
Selain komponen Material standar, proyek ini menggunakan beberapa widget khusus untuk memastikan UX yang berkualitas tinggi:

| Widget | Tujuan |
| :--- | :--- |
| **`LayoutBuilder`** | Adaptasi UI dinamis berdasarkan batasan *parent* (Desain Responsif). |
| **`SafeArea`** | Memastikan kompatibilitas UI di seluruh perangkat dengan *notch* atau indikator beranda. |
| **`CircularProgressIndicator`** | Umpan balik visual selama operasi Supabase yang bersifat asinkron. |
| **`InkWell`** | Menyediakan efek riak (*ripple*) Material dan deteksi gestur pada kartu kustom. |
| **`SnackBar`** | Umpan balik transien untuk keberhasilan/kegagalan CRUD (perilaku *floating*). |
| **`IntrinsicHeight`** | Sinkronisasi perataan *cross-axis* untuk tata letak kartu yang kompleks. |
| **`ConstrainedBox`** | Menetapkan lebar maksimum pada layar besar untuk menjaga keterbacaan. |
| **`SingleChildScrollView`** | Mencegah kesalahan *overflow* pada layar kecil dan saat interaksi keyboard. |

---

## ⚙️ Instalasi & Pengaturan

1. **Konfigurasi Lingkungan**:
   Buat file `.env` di direktori root:
   ```env
   SUPABASE_URL=project_url_anda
   SUPABASE_ANON_KEY=anon_key_anda
   ```

2. **Dependensi**:
   ```bash
   flutter pub get
   ```

3. **Skema Database**:
   Pastikan tabel `konser` di Supabase Anda memiliki kolom berikut:
   - `id` (int8, primary key)
   - `nama_konser` (text)
   - `nama_artis` (text)
   - `tanggal_konser` (text)
   - `lokasi_venue` (text)
   - `harga` (text)

---

## 👨‍💻 Catatan Pengembang
Proyek ini memprioritaskan **State Management** melalui `setState` untuk kesederhanaan pada iterasi ini, dengan pemisahan yang jelas antara komponen UI dan model data. Penanganan kesalahan (*error handling*) diimplementasikan di seluruh batas asinkron untuk memastikan stabilitas aplikasi.
