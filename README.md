# Nutrious Mobile

## Nama Anggota Kelompok
1. Stelline Claudia - 2106700933
2. Dhafin Raditya Juliawan - 2106650304
3. Johannes Setiawan - 2106750345
4. Muhammad Faris Umar Rahman - 2106702402
5. Jaycent Gunawan Ongris - 2106750231
6. Annava Wisha Sikoko - 2106635493

## Tautan APK
TBA

## Deskripsi Aplikasi
Aplikasi yang akan kami buat adalah Nutrious Mobile. Nutrious Mobile merupakan aplikasi *mobile* yang diadaptasi dari aplikasi web yang telah kami buat
sebelumnya. Aplikasi ini kami buat untuk mendukung penyelesaian isu kesehatan global sebagaimana yang dibahas oleh pemimpin-pemimpin dunia pada Konferensi
G20. Spesifiknya, aplikasi ini berfokus pada permasalahan terkait bagaimana meningkatkan asupan gizi masyarakat untuk kualitas hidup yang lebih baik. Untuk
mengimplementasikan hal ini, kami membuat beberapa fitur pada aplikasi ini yang bermanfaat bagi pengguna aplikasi itu sendiri maupun masyarakat secara umum.
Fitur-fitur tersebut adalah *calorie tracker* untuk *tracking* kalori dari pengguna tiap harinya, *fundraising* untuk memberikan kesempatan kepada pengguna
melakukan donasi kepada orang-orang yang membutuhkan, *food-sharing* untuk memberikan informasi terkait lokasi pembagian makanan kepada masyarakat jika ada
pengguna yang ingin membagi makanan, *food recipe* untuk memberikan informasi terkait resep makanan sehat yang ditulis oleh pengguna, dan *blog* untuk
memberikan informasi atau artikel terkait kesehatan dan gizi yang ditulis oleh pengguna.

## Daftar Fitur yang Diimplementasikan dan Kontrak Kinerja
1. Fitur Utama (Jaycent Gunawan Ongris)<br>
Fitur ini terdiri dari halaman utama aplikasi, halaman *login*, halaman *dashboard* administrator, dan mengimplementasikan sistem autentikasi pada aplikasi.

2. Fundraising (Johannes Setiawan)<br>
Fitur ini terdiri dari halaman daftar donasi yang dibuka, formulir untuk membuka donasi baru, dan formulir untuk berdonasi.

3. Food-Sharing (Annava Wisha Sikoko)<br>
Fitur ini terdiri dari halaman daftar lokasi pembagian makanan yang ada, formulir untuk mendaftarkan lokasi pembagian makanan, serta fitur untuk menghapus dan mengedit lokasi pembagian makanan yang dibuat.

4. Calorie Tracker (Stelline Claudia)<br>
Fitur ini terdiri dari halaman daftar kalori yang dikonsumsi dan dibakar, formulir untuk menambahkan kalori yang dikonsumsi, formulir untuk menambah kalori yang dibakar, fitur untuk menghapus daftar kalori, dan fitur untuk mengedit daftar kalori.

5. Food Recipe (Muhammad Faris Umar Rahman)

6. Blog (Dhafin Raditya Juliawan)<br>
Fitur ini terdiri dari halaman utama *blog post*, formulir untuk menambahkan *post* baru, fitur untuk menampilkan *post* dengan tag yang diinginkan oleh *user* dan fitur *upvote-downvote* sebuah *post*.

## Peran atau Aktor Pengguna Aplikasi
Terdapat dua jenis pengguna pada aplikasi ini, yaitu admin dan pengguna biasa (*user*). Admin dapat melihat siapa saja user yang sudah terdaftar, donasi
yang dibuka oleh *user*, dan pesan yang dikirimkan oleh *user*. Sementara itu, *user* terdiri dari dua jenis, yaitu *user* yang sudah terverifikasi dan *user8 yang
belum terverifikasi. Semua *user* yang sudah *logged in* ke dalam aplikasi dapat melakukan donasi, membuat *log* terkait aktivitas yang berhubungan dengan
penambahan atau pembakaran kalori, membagikan resep makanan sehat, membuat *blog*, dan melakukan *upvote* atau *downvote* pada *blog*. Sementara itu, untuk alasan
keamanan, hanya *user* yang sudah terverifikasi saja yang dapat membuka penggalangan dana dan memberikan informasi terkait lokasi pembagian makanan.

## Alur Pengintegrasian dengan *Web Service* dari PTS
Alur pengintegrasian dengan *web service* yang telah dibuat sebelumnya adalah dengan melakukan HTTP GET untuk mengambil data dari *endpoint* JSON yang telah
dibuat pada PTS dan di-*deploy* ke Railway, lalu mengolah respons data tersebut untuk kemudian ditampilkan pada halaman fitur aplikasi yang terkait agar
pengguna bisa melihat data tersebut.