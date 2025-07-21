<!DOCTYPE html>
<html lang="id" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aplikasi Inventaris CRUD dengan Flutter & SQLite</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Chosen Palette: Cool Slate (Light slate background, dark slate text, indigo accents) -->
    <!-- Application Structure Plan: A single-page, vertically scrolling application with distinct thematic sections (Hero, Features, Screenshots, Tech Stack, Getting Started, Contribute). This structure is more engaging and scannable than a linear README. Key interactions include smooth scrolling navigation, a tabbed interface for setup instructions, and copy-to-clipboard buttons for code blocks to improve user experience. -->
    <!-- Visualization & Content Choices: Report Info: Project features -> Goal: Compare/Inform -> Presentation: Icon-based grid of cards -> Interaction: None -> Justification: More visually appealing and easier to digest than a bullet list. Report Info: Tech stack -> Goal: Inform -> Presentation: Styled badges in a grid -> Interaction: None -> Justification: Better visual grouping than a list. Report Info: Setup instructions -> Goal: Organize/Instruct -> Presentation: Tabbed interface with copyable code blocks -> Interaction: Tab switching, copy button -> Justification: Organizes complex steps, reduces cognitive load, and makes commands easy to use. -->
    <!-- CONFIRMATION: NO SVG graphics used. NO Mermaid JS used. -->
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        .code-block {
            position: relative;
        }
        .copy-button {
            position: absolute;
            top: 0.5rem;
            right: 0.5rem;
            background-color: #4f46e5;
            color: white;
            padding: 0.25rem 0.5rem;
            border-radius: 0.375rem;
            font-size: 0.75rem;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .copy-button:hover {
            background-color: #4338ca;
        }
        .tab-button.active {
            border-color: #4f46e5;
            color: #4f46e5;
            font-weight: 600;
        }
    </style>
</head>
<body class="bg-slate-50 text-slate-800">

    <!-- Header & Navigasi -->
    <header class="bg-white/80 backdrop-blur-lg sticky top-0 z-50 border-b border-slate-200">
        <nav class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-16">
                <div class="flex items-center">
                    <span class="text-xl font-bold text-indigo-600">📦 Inventaris App</span>
                </div>
                <div class="hidden md:flex items-center space-x-8">
                    <a href="#fitur" class="text-slate-600 hover:text-indigo-600 transition">Fitur</a>
                    <a href="#teknologi" class="text-slate-600 hover:text-indigo-600 transition">Teknologi</a>
                    <a href="#memulai" class="text-slate-600 hover:text-indigo-600 transition">Memulai</a>
                </div>
            </div>
        </nav>
    </header>

    <main class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-12 sm:py-16">

        <!-- Hero Section -->
        <section class="text-center mb-20">
            <h1 class="text-4xl sm:text-5xl md:text-6xl font-extrabold tracking-tight text-slate-900 mb-4">
                Simple Inventory CRUD App
            </h1>
            <p class="max-w-3xl mx-auto text-lg text-slate-600 mb-8">
                Aplikasi inventaris sederhana dibangun dengan Flutter dan SQLite. Kelola daftar barang Anda dengan mudah, termasuk tambah, lihat, edit, hapus, dan unggah gambar.
            </p>
            <div class="flex flex-col sm:flex-row justify-center items-center gap-4">
                <a href="#memulai" class="w-full sm:w-auto bg-indigo-600 text-white font-semibold py-3 px-8 rounded-lg shadow-md hover:bg-indigo-700 transition transform hover:scale-105">
                    Panduan Memulai
                </a>
                <a href="https://github.com/nama-pengguna-anda/nama-repo-anda" target="_blank" class="w-full sm:w-auto bg-slate-200 text-slate-700 font-semibold py-3 px-8 rounded-lg hover:bg-slate-300 transition">
                    Lihat di GitHub
                </a>
            </div>
        </section>

        <!-- Fitur Utama -->
        <section id="fitur" class="mb-20 scroll-mt-20">
            <div class="text-center mb-12">
                <h2 class="text-3xl font-bold tracking-tight text-slate-900">✨ Fitur Utama</h2>
                <p class="text-slate-600 mt-2">Semua yang Anda butuhkan untuk manajemen inventaris dasar.</p>
            </div>
            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                <div class="bg-white p-6 rounded-xl shadow-sm border border-slate-200">
                    <h3 class="text-lg font-semibold mb-2">Tambah Barang Baru</h3>
                    <p class="text-slate-600">Masukkan nama barang, harga, dan tambahkan gambar dari galeri atau kamera Anda.</p>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-sm border border-slate-200">
                    <h3 class="text-lg font-semibold mb-2">Lihat & Edit Barang</h3>
                    <p class="text-slate-600">Tampilkan semua item dalam daftar yang mudah diakses dan perbarui detailnya kapan saja.</p>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-sm border border-slate-200">
                    <h3 class="text-lg font-semibold mb-2">Hapus & Simpan Lokal</h3>
                    <p class="text-slate-600">Hapus item yang tidak lagi diperlukan. Semua data disimpan dengan aman di perangkat menggunakan SQLite.</p>
                </div>
            </div>
        </section>

        <!-- Tampilan Aplikasi -->
        <section id="tampilan" class="mb-20 text-center">
             <div class="text-center mb-12">
                <h2 class="text-3xl font-bold tracking-tight text-slate-900">📸 Tampilan Aplikasi</h2>
                <p class="text-slate-600 mt-2">Beginilah tampilan aplikasi Anda saat beraksi.</p>
            </div>
            <div class="bg-white p-4 rounded-xl shadow-lg border border-slate-200 inline-block">
                <img src="assets/images/register.jpg" onerror="this.onerror=null;this.src='https://placehold.co/800x600/e2e8f0/475569?text=Screenshot+Aplikasi';" alt="Tampilan Aplikasi" class="rounded-lg w-full max-w-2xl mx-auto">
            </div>
             <p class="text-xs text-slate-500 mt-2 italic">Catatan: Ganti placeholder di atas dengan screenshot nyata dari aplikasi Anda.</p>
        </section>

        <!-- Teknologi yang Digunakan -->
        <section id="teknologi" class="mb-20 scroll-mt-20">
            <div class="text-center mb-12">
                <h2 class="text-3xl font-bold tracking-tight text-slate-900">🛠️ Teknologi yang Digunakan</h2>
                <p class="text-slate-600 mt-2">Dibangun dengan teknologi modern dan andal.</p>
            </div>
            <div class="flex flex-wrap justify-center gap-3 text-sm">
                <span class="bg-indigo-100 text-indigo-800 font-medium py-1.5 px-3 rounded-full">Flutter</span>
                <span class="bg-indigo-100 text-indigo-800 font-medium py-1.5 px-3 rounded-full">Dart</span>
                <span class="bg-indigo-100 text-indigo-800 font-medium py-1.5 px-3 rounded-full">SQLite</span>
                <span class="bg-slate-200 text-slate-700 font-medium py-1.5 px-3 rounded-full">sqflite</span>
                <span class="bg-slate-200 text-slate-700 font-medium py-1.5 px-3 rounded-full">image_picker</span>
                <span class="bg-slate-200 text-slate-700 font-medium py-1.5 px-3 rounded-full">path_provider</span>
                <span class="bg-slate-200 text-slate-700 font-medium py-1.5 px-3 rounded-full">google_fonts</span>
                <span class="bg-slate-200 text-slate-700 font-medium py-1.5 px-3 rounded-full">shared_preferences</span>
                <span class="bg-slate-200 text-slate-700 font-medium py-1.5 px-3 rounded-full">local_auth</span>
                <span class="bg-slate-200 text-slate-700 font-medium py-1.5 px-3 rounded-full">path</span>
                <span class="bg-slate-200 text-slate-700 font-medium py-1.5 px-3 rounded-full">url_launcher</span>
                <span class="bg-slate-200 text-slate-700 font-medium py-1.5 px-3 rounded-full">flutter_svg</span>
                <span class="bg-slate-200 text-slate-700 font-medium py-1.5 px-3 rounded-full">flutter_localization</span>
            </div>
        </section>

        <!-- Memulai Proyek -->
        <section id="memulai" class="mb-20 scroll-mt-20">
            <div class="text-center mb-12">
                <h2 class="text-3xl font-bold tracking-tight text-slate-900">🚀 Memulai Proyek</h2>
                <p class="text-slate-600 mt-2">Ikuti langkah-langkah ini untuk menjalankan proyek di mesin lokal Anda.</p>
            </div>

            <div class="max-w-3xl mx-auto bg-white rounded-xl shadow-sm border border-slate-200 p-6">
                <!-- Tab Buttons -->
                <div class="border-b border-slate-200 mb-6">
                    <nav class="-mb-px flex space-x-6" aria-label="Tabs">
                        <button class="tab-button active" data-tab="prasyarat">Prasyarat</button>
                        <button class="tab-button" data-tab="instalasi">Instalasi</button>
                        <button class="tab-button" data-tab="jalankan">Jalankan</button>
                    </nav>
                </div>

                <!-- Tab Content -->
                <div id="tab-content">
                    <div id="prasyarat-content" class="tab-pane active">
                        <h3 class="font-semibold text-lg mb-4">Prasyarat Sistem</h3>
                        <p class="text-slate-600 mb-4">Pastikan Anda telah menginstal perangkat lunak berikut di sistem Anda:</p>
                        <ul class="list-disc list-inside space-y-2 text-slate-600">
                            <li><a href="https://docs.flutter.dev/get-started/install" target="_blank" class="text-indigo-600 hover:underline">Flutter SDK</a> (versi stabil terbaru direkomendasikan)</li>
                            <li><a href="https://dart.dev/get-started" target="_blank" class="text-indigo-600 hover:underline">Dart SDK</a> (biasanya sudah termasuk dengan Flutter)</li>
                        </ul>
                    </div>
                    <div id="instalasi-content" class="tab-pane hidden">
                        <h3 class="font-semibold text-lg mb-4">Langkah-langkah Instalasi</h3>
                        <div class="space-y-4">
                            <div>
                                <p class="font-medium">1. Clone repository ini:</p>
                                <div class="code-block mt-1">
                                    <pre class="bg-slate-800 text-white p-4 rounded-lg text-sm overflow-x-auto"><code id="code-clone">git clone https://github.com/nama-pengguna-anda/nama-repo-anda.git

cd nama-repo-anda</code></pre>
<button class="copy-button" onclick="copyCode('code-clone', this)">Salin</button>
</div>
</div>
<div>
<p class="font-medium">2. Dapatkan semua dependensi:</p>
<div class="code-block mt-1">
<pre class="bg-slate-800 text-white p-4 rounded-lg text-sm overflow-x-auto"><code id="code-pub-get">flutter pub get</code></pre>
<button class="copy-button" onclick="copyCode('code-pub-get', this)">Salin</button>
</div>
</div>
<div>
<p class="font-medium">3. (Opsional) Tambahkan dependensi jika belum ada:</p>
<div class="code-block mt-1">
<pre class="bg-slate-800 text-white p-4 rounded-lg text-sm overflow-x-auto"><code id="code-pub-add">flutter pub add google_fonts sqflite shared_preferences local_auth path url_launcher image_picker flutter_svg flutter_localization</code></pre>
<button class="copy-button" onclick="copyCode('code-pub-add', this)">Salin</button>
</div>
</div>
</div>
</div>
<div id="jalankan-content" class="tab-pane hidden">
<h3 class="font-semibold text-lg mb-4">Menjalankan Aplikasi</h3>
<p class="text-slate-600 mb-4">Gunakan perintah berikut untuk menjalankan aplikasi pada emulator atau perangkat fisik yang terhubung.</p>
<div class="code-block mt-1">
<pre class="bg-slate-800 text-white p-4 rounded-lg text-sm overflow-x-auto"><code id="code-run">flutter run</code></pre>
<button class="copy-button" onclick="copyCode('code-run', this)">Salin</button>
</div>
</div>
</div>
</div>
</section>

        <!-- Kontribusi & Lisensi -->
        <section class="text-center border-t border-slate-200 pt-12">
            <h2 class="text-2xl font-bold tracking-tight text-slate-900">🤝 Kontribusi & Lisensi</h2>
            <p class="max-w-2xl mx-auto text-slate-600 mt-2">
                Kontribusi disambut baik! Silakan Fork, buat branch, dan kirim Pull Request. Proyek ini dilisensikan di bawah Lisensi MIT.
            </p>
        </section>

    </main>

    <footer class="text-center py-8 text-sm text-slate-500">
        <p>&copy; 2024 Simple Inventory CRUD App. Dibangun dengan Flutter.</p>
    </footer>

    <script>
        // Tab switching logic
        const tabButtons = document.querySelectorAll('.tab-button');
        const tabPanes = document.querySelectorAll('.tab-pane');

        tabButtons.forEach(button => {
            button.addEventListener('click', () => {
                const tab = button.dataset.tab;

                tabButtons.forEach(btn => btn.classList.remove('active'));
                button.classList.add('active');

                tabPanes.forEach(pane => {
                    if (pane.id === `${tab}-content`) {
                        pane.classList.remove('hidden');
                        pane.classList.add('active');
                    } else {
                        pane.classList.add('hidden');
                        pane.classList.remove('active');
                    }
                });
            });
        });

        // Copy to clipboard logic
        function copyCode(elementId, button) {
            const codeEl = document.getElementById(elementId);
            const text = codeEl.innerText;

            // Create a temporary textarea element to copy the text
            const textarea = document.createElement('textarea');
            textarea.value = text;
            document.body.appendChild(textarea);
            textarea.select();
            try {
                document.execCommand('copy');
                button.innerText = 'Tersalin!';
                setTimeout(() => {
                    button.innerText = 'Salin';
                }, 2000);
            } catch (err) {
                console.error('Gagal menyalin teks: ', err);
                button.innerText = 'Gagal';
                 setTimeout(() => {
                    button.innerText = 'Salin';
                }, 2000);
            }
            document.body.removeChild(textarea);
        }
    </script>

</body>
</html>
