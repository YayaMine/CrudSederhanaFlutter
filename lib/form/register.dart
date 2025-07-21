import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertifikasi/form/login.dart';
import 'package:sertifikasi/helpers/database_helpers.dart';
import 'package:sertifikasi/models/user_models.dart';

class Regitser extends StatefulWidget {
  const Regitser({super.key});

  @override
  State<Regitser> createState() => _RegitserState();
}

class _RegitserState extends State<Regitser> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    final String email = _emailController.text.trim();
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      _showSnackBar('Semua kolom harus diisi!', Colors.red);
      return;
    }

    final User newUser = User(
      email: email,
      username: username,
      password: password,
    );

    try {
      bool exists = await _dbHelper.userExists(email, username);
      if (exists) {
        _showSnackBar('Email atau Username sudah terdaftar!', Colors.orange);
      } else {
        int result = await _dbHelper.insertUser(newUser);
        if (result != -1) {
          _showRegistrationSuccessDialog();
        } else {
          _showSnackBar('Pendaftaran Gagal. Silakan coba lagi.', Colors.red);
        }
      }
    } catch (e) {
      _showSnackBar('Terjadi kesalahan: $e', Colors.red);
      print('Registration error: $e');
    }
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

  void _showRegistrationSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Registrasi Berhasil!',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF14A741),
            ),
          ),
          content: Text(
            'Akun Anda telah berhasil didaftarkan. Silakan login.',
            style: GoogleFonts.roboto(),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: GoogleFonts.roboto(
                  color: const Color(0xFF14A741),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            width: 350,
            height: 480,
            decoration: BoxDecoration(
              color: const Color(0xFF14A741),
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Registrasi',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: GoogleFonts.roboto(color: Colors.white70),
                      hintText: 'Masukkan email',
                      hintStyle: GoogleFonts.roboto(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameController,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: GoogleFonts.roboto(color: Colors.white70),
                      hintText: 'Masukkan Username',
                      hintStyle: GoogleFonts.roboto(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: GoogleFonts.roboto(color: Colors.white70),
                      hintText: 'Masukkan password',
                      hintStyle: GoogleFonts.roboto(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _registerUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF14A741),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 80,
                        ),
                      ),
                      child: Text(
                        'Daftar',
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
