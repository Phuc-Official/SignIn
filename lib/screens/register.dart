import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/auth/firebase_ath_services.dart';

import 'package:todoapp/screens/home.dart';
import 'package:todoapp/screens/pass_regis_screen.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}
class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final _emailController = TextEditingController();

  bool _isEmailAvailable = false;
  String _errorMessage = '';

  bool isEmailValid(String email) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

// Hàm kiểm tra email không bị trùng lặp (gọi API đến server)
  Future<bool> isEmailAvailable(String email) async {
    try {
      final signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return signInMethods.isEmpty;
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'user-not-found') {
        return true;
      } else {
        rethrow;
      }
    }
  }
  Future<void> _checkEmailAvailability() async {
    try {
      final email = _emailController.text.trim();
      _isEmailAvailable = await isEmailAvailable(email);
      setState(() {
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error checking email availability: $e';
      });
    }
  }

  Future<void> _navigateToRegisterPasswordPage() async {
    // Lưu email vào biến toàn cục hoặc state để sử dụng ở trang tiếp theo
    String email = _emailController.text;

    if (!isEmailValid(email)) {
      // Email không hợp lệ, hiển thị thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid email.'),
        ),
      );
      return;
    }
    _checkEmailAvailability();

    // Chuyển sang trang đăng ký mật khẩu, truyền email vào
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPasswordPage(email: email),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Enter your email address',
                labelStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: 45, // Đặt chiều cao tối đa cho nút
              child: ElevatedButton(
                onPressed: _navigateToRegisterPasswordPage,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  minimumSize: Size(double.infinity, 30),
                ),
                child: Text('Next'),
              ),
            )
          ],
        ),
      )
    );
  }


/*
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  //late SharedPreferences _sharedPreferences;

  @override
  void initState() {
    super.initState();
    //_initSharedPreferences();
    //_loadAccounts();
  }

/*
  Future<void> viewSharedPreferences() async {
    final _sharedPreferences = await SharedPreferences.getInstance();

    // Lấy tất cả các key đã lưu
    final keys = _sharedPreferences.getKeys();
    print('Keys in SharedPreferences:');
    keys.forEach((key) {
      print('- $key');
    });

    // Hiển thị giá trị của từng key
    for (final key in keys) {
      final value = _sharedPreferences.get(key);
      print('$key: $value');
    }
  }
  Future<void> _printAccounts() async {
    if (_accounts.isNotEmpty) {
      print('Danh sách tài khoản:');
      for (final account in _accounts) {
        print('Email: ${account['email']}');
        print('Mật khẩu: ${account['password']}');
        print('---');
      }
    } else {
      print('Chưa có tài khoản nào được lưu.');
    }
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> _loadAccounts() async {
    final accountsJson = _sharedPreferences.getString('accounts');
    if (accountsJson != null) {
      _accounts = List<Map<String, String>>.from(
        jsonDecode(accountsJson) as List<dynamic>,
      );
    }
  }


  Future<void> _saveAccounts() async {
    final accountsJson = jsonEncode(_accounts);
    await _sharedPreferences.setString('accounts', accountsJson);
  }
*/
  /*Future<void> _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      // Hiển thị thông báo lỗi nếu mật khẩu không khớp
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }

    // Kiểm tra xem tài khoản đã tồn tại chưa
    if (_accounts.any((account) => account['email'] == email)) {
      // Hiển thị thông báo lỗi nếu tài khoản đã tồn tại
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('email already exists'),
        ),
      );
      return;
    }

    // Thêm tài khoản mới vào danh sách
    _accounts.add({'email': email, 'password': password});
    await _saveAccounts();

    // Hiển thị thông báo đăng ký thành công
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registration successful!'),
      ),
    );

    // Đặt lại các trường nhập liệu
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();

    // Chuyển hướng về trang đăng nhập
    // Navigator.pop(context);
  }*/

  /*Future<void> _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      // Hiển thị thông báo lỗi nếu mật khẩu không khớp
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }

    // Lưu thông tin người dùng vào Shared Preferences
    await _sharedPreferences.setString('email', email);
    await _sharedPreferences.setString('password', password);

    // Hiển thị thông báo đăng ký thành công
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registration successful!'),
      ),
    );

    // Đặt lại các trường nhập liệu
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();

    // Chuyển hướng về trang đăng nhập
    // Navigator.pop(context);
  }*/

 /* Future<void> _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      // Hiển thị thông báo lỗi nếu mật khẩu không khớp
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }

    // Kiểm tra xem email đã tồn tại trong cơ sở dữ liệu chưa
    if (await _isEmailRegistered(email)) {
      // Hiển thị thông báo lỗi nếu email đã tồn tại
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email already exists'),
        ),
      );
      return;
    }

    // Thêm tài khoản mới vào cơ sở dữ liệu
    await _saveUserToDatabase(email, password);

    // Hiển thị thông báo đăng ký thành công
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registration successful!'),
      ),
    );

    // Đặt lại các trường nhập liệu
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();

    // Chuyển hướng về trang đăng nhập
    // Navigator.pop(context);
  }

  Future<bool> _isEmailRegistered(String email) async {
    // Kiểm tra xem email đã tồn tại trong cơ sở dữ liệu hay chưa
    // Ví dụ:
    final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    return userSnapshot.docs.isNotEmpty;
  }

  Future<void> _saveUserToDatabase(String email, String password) async {
    // Lưu thông tin người dùng vào cơ sở dữ liệu
    // Ví dụ:
    await FirebaseFirestore.instance.collection('users').add({
      'email': email,
      'password': password,
    });
  }*/

  void _register() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUp(email, password);

    if (user != null) {
      print('User is successfully created');
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();

      // Show alert dialog to notify user
      showAlertDialog(context, 'Registration Successful', 'Your account has been created successfully.');
    } else {
      print('Error when Create Account');

      // Show alert dialog to notify user of error
      showAlertDialog(context, 'Registration Error', 'There was an error creating your account. Please try again.');
    }
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
*/
}
