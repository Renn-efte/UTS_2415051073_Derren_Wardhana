# RecipeBox - UTS Pemrograman Mobile

Aplikasi manajemen resep masakan cerdas yang memungkinkan pengguna untuk mencari inspirasi resep dari seluruh dunia dan menyimpannya ke dalam koleksi pribadi (My Box) beserta catatan modifikasi dan rating.

## Identitas Mahasiswa
- **Nama:** Derren Wardhana
- **NIM:** 2415051073
- **Kelas:** PTI-5IKI

## Daftar Fitur
- 🔍 Pencarian daftar resep makanan dinamis dari seluruh dunia.
- 📖 Menampilkan detail resep lengkap beserta instruksi memasak dan gambar.
- 💾 Menyimpan resep ke koleksi pribadi (Create).
- 📂 Menampilkan daftar resep tersimpan lengkap dengan status dan catatan (Read).
- ✏️ Mengubah status masak, rating, dan catatan resep yang telah disimpan (Update).
- 🗑️ Menghapus resep dari koleksi pribadi dengan dialog konfirmasi (Delete).
- 🔄 Pull-to-refresh dan State Management Handling (Loading, Error, Empty State).
- 📱 Responsive Layout (GridView untuk layar lebar, ListView untuk layar sempit).

## Tech Stack
- **Framework:** Flutter
- **State Management:** Provider
- **REST API:** TheMealDB API (`search.php` & `lookup.php`)
- **Backend/Database:** Supabase (PostgreSQL)

## Struktur Arsitektur Aplikasi
Project ini menerapkan pemisahan logika dan antarmuka dengan arsitektur standar:
- `lib/models/`: Konversi data JSON/Database ke objek Dart.
- `lib/services/`: Mengelola komunikasi dengan REST API dan Supabase.
- `lib/repositories/`: Struktur perantara pengatur lalu lintas data.
- `lib/providers/`: State management (mengelola loading, data, dan error).
- `lib/screens/`: Tampilan utama aplikasi (UI).
- `lib/widgets/`: Komponen UI yang dapat digunakan kembali (Reusable Widgets).

## Cara Menjalankan Project
1. Clone repository ini.
2. Jalankan `flutter pub get` di terminal untuk menginstal *dependencies* (Provider, HTTP, Supabase_flutter).
3. Pastikan kunci *environment* Supabase telah diatur pada `main.dart` (jika menggunakan variabel statis).
4. Jalankan aplikasi menggunakan `flutter run`.