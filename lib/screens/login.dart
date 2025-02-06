import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/auth/firebase_ath_services.dart';
import 'package:todoapp/screens/forgot_pw.dart';
import 'package:todoapp/screens/home.dart';
import 'package:todoapp/screens/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late SharedPreferences _sharedPreferences;
  bool _obscurePassword = true;
  List<Map<String, String>> _accounts = [];

  @override
  void initState() {
    super.initState();
    //_initSharedPreferences();
    //_loadAccounts();
  }
/*
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
    try {
      final accountsJson = _sharedPreferences.getString('accounts');
      if (accountsJson != null) {
        _accounts = List<Map<String, String>>.from(
          jsonDecode(accountsJson) as List<dynamic>,
        );
      }
    } catch (e) {
      print('Lỗi khi tải tài khoản: $e');
      // Xử lý lỗi, ví dụ: hiển thị một thông báo cho người dùng
    }
  }
  */

  /*Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Kiểm tra xem tài khoản có tồn tại trong danh sách không
    final account = _accounts.firstWhere(
          (account) => account['email'] == email && account['password'] == password,
      orElse: () => {'email': '', 'password': ''},
    );

    if (account['email'] != '' && account['password'] != '') {
      // Hiển thị thông báo đăng nhập thành công
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
        ),
      );

      // Đặt lại các trường nhập liệu
      _emailController.clear();
      _passwordController.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(), // Thay thế bằng trang bạn muốn chuyển đến
        ),
      );
    } else {
      // Hiển thị thông báo lỗi đăng nhập
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
        ),
      );
    }
  }*/

/*
  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

// Lấy thông tin người dùng từ Shared Preferences
    final storedEmail = _sharedPreferences.getString('email');
    final storedPassword = _sharedPreferences.getString('password');

    if (email == storedEmail && password == storedPassword) {
      // Hiển thị thông báo đăng nhập thành công
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
        ),
      );

      // Đặt lại các trường nhập liệu
      _emailController.clear();
      _passwordController.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Home(), // Thay thế bằng trang bạn muốn chuyển đến
        ),
      );
    } else {
      // Hiển thị thông báo lỗi đăng nhập
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
        ),
      );
    }
  }
*/

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signIn(email, password);

    if (user != null) {
      print('User is successfully Signin');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Home(), // Thay thế bằng trang bạn muốn chuyển đến
        ),
      );
    } else {
      print('Error when Login');
    }
  }

  void _register(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationPage(),
      ),
    );
  }

  void _forgot(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('Login Page', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 35.0, right: 35),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(height: 60),
            Container(
              height: 200,
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/1.jpg'),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              style: TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                labelText: 'EMAIL ADDRESS',
                labelStyle: TextStyle(
                  color: Colors.black26,
                  fontSize: 16,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                TextField(
                  style: TextStyle(fontSize: 18),
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: const TextStyle(
                      color: Colors.black26,
                      fontSize: 16,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),

                // TextButton(
                //     onPressed: () {},
                //     child: const Text(
                //       'SHOW',
                //       style: TextStyle(
                //           color: Colors.blue,
                //           fontSize: 15,
                //           fontWeight: FontWeight.bold),
                //     ))
              ],
            ),
            SizedBox(height: 25.0),
            Container(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                  onPressed: _login,
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 37,
              width: double.maxFinite,
              alignment: Alignment.center,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'NEVER USE?',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    TextButton(
                      onPressed: () => _register(context),
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(color: Colors.blue, fontSize: 11),
                      ),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    TextButton(
                      onPressed: () => _forgot(context),
                      child: const Text(
                        'FORGOT PASSWORD',
                        style: TextStyle(color: Colors.blue, fontSize: 11),
                      ),
                    )
                  ]),
            )
          ]),
        ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
