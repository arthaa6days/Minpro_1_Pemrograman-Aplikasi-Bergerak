
## PROJECT | APLIKASI MANAJEMEN TIKET KONSER | MINPRO 1 DAN 2
**Konser Island** adalah prototipe aplikasi mobile yang dibangun menggunakan Flutter, dirancang untuk manajemen siklus hidup tiket konser secara *end-to-end*. Aplikasi ini mengimplementasikan alur kerja **CRUD (Create, Read, Update, Delete)** lengkap yang terintegrasi dengan database relasional berbasis cloud dan sistem autentikasi yang aman menggunakan Supabase.

---

## 🛠️ Teknologi & Integrasi

### 1. Backend: Infrastruktur Supabase
Aplikasi ini menggunakan **Supabase** sebagai *backend-as-a-service* (BaaS).
*   **Autentikasi**: Menggunakan Supabase Auth (Email Provider).
*   **Database**: PostgreSQL untuk penyimpanan data tiket konser.
*   **Keamanan**: Integrasi `flutter_dotenv` untuk melindungi API Key dan URL Supabase.

### 2. State Management & Arsitektur
*   **Provider**: Mengelola status tema (Dark/Light Mode) secara global.
*   **Reactive Auth (AuthGate)**: Menggunakan `StreamBuilder` dan `onAuthStateChange` dari Supabase untuk menangani navigasi secara otomatis tanpa perlu manajemen rute manual yang kompleks.

---

## 🚀 Fitur Unggulan

### 🔐 Autentikasi Lanjutan
*   **Reactive Navigation**: Halaman berpindah otomatis antara `LoginPage` dan `HomePage` berdasarkan status sesi pengguna.
*   **Show/Hide Password**: Fitur *toggle* visibilitas password pada halaman Login dan Register untuk meningkatkan UX.
*   **Registrasi dengan Verifikasi**: Notifikasi otomatis setelah registrasi yang menginstruksikan pengguna untuk melakukan konfirmasi email.

### 🌓 UI/UX Modern
*   **Mode Gelap (Dark Mode)**: Dukungan tema gelap yang dapat diganti secara instan.
*   **Layout Responsif**: Berpindah antara tampilan List dan Grid berdasarkan ukuran layar.
*   **Paginasi Server-Side**: Pengambilan data yang efisien untuk performa aplikasi yang optimal.

---

## 🔄 Alur Penggunaan Aplikasi (User Flow)

1.  **Login/Register**: Pengguna baru melakukan registrasi dengan email dan password.
2.  **Konfirmasi Email**: Pengguna wajib mengonfirmasi akun melalui link yang dikirimkan Supabase ke inbox email.
3.  **Masuk Otomatis**: Setelah login berhasil, `AuthGate` akan mendeteksi sesi dan langsung menampilkan `HomePage`.
4.  **Manajemen Tiket**: Pengguna dapat menambah, melihat, mengedit, dan menghapus tiket konser.
5.  **Logout**: Saat tombol logout ditekan, sesi dihentikan secara lokal dan `AuthGate` akan secara otomatis mengarahkan pengguna kembali ke halaman Login (Sesi dibersihkan sepenuhnya).

---

## ⚙️ Instalasi & Pengaturan

1. **File .env**:
   Pastikan file `.env` tersedia di root project:
   ```env
   SUPABASE_URL=project_url_anda
   SUPABASE_ANON_KEY=anon_key_anda
   ```

2. **Dashboard Supabase**:
   - Aktifkan **Email Provider** di menu Authentication.
   - Pastikan tabel `konser` sudah dikonfigurasi dengan kolom: `id`, `nama_konser`, `nama_artis`, `tanggal_konser`, `lokasi_venue`, dan `harga`.

---

## 👨‍💻 Catatan Revisi Terbaru
*   **Logout Fix**: Perbaikan navigasi di mana `AuthGate` sekarang menjadi satu-satunya sumber kebenaran untuk status halaman, mencegah *stale screens* setelah logout.
*   **UI Updates**: Penambahan tombol visibilitas pada input password di seluruh aplikasi.
*   **UX Improvements**: Pesan notifikasi registrasi yang lebih deskriptif mengenai langkah konfirmasi email.
