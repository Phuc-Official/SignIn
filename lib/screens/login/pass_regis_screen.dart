// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:todoapp/auth/firebase_ath_services.dart';
// import 'package:todoapp/screens/login/login.dart';
//
// class RegisterPasswordPage extends StatefulWidget {
//   final String email;
//
//   RegisterPasswordPage({required this.email});
//
//   @override
//   _RegisterPasswordPageState createState() => _RegisterPasswordPageState();
// }
//
// class _RegisterPasswordPageState extends State<RegisterPasswordPage> {
//   final FirebaseAuthServices _auth = FirebaseAuthServices();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//
//   void showAlertDialog(BuildContext context, String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _register() async {
//     String email = widget.email;
//     String password = _passwordController.text;
//     String confirmPassword = _confirmPasswordController.text;
//
//     // Kiểm tra xem mật khẩu và nhập lại mật khẩu có khớp không
//     if (password != confirmPassword) {
//       showAlertDialog(context, 'Registration Error',
//           'Password and Confirm Password do not match.');
//       return;
//     }
//
//     try {
//       User? user = await _auth.signUp(email, password);
//       if (user != null) {
//         print('User is successfully created');
//         _passwordController.clear();
//         _confirmPasswordController.clear();
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 const Login(), // Thay thế bằng trang bạn muốn chuyển đến
//           ),
//         );
//
//         // Show alert dialog to notify user
//
//         showAlertDialog(
//             context, '', 'Your account has been created successfully.');
//       } else {
//         // Nếu đăng ký không thành công, hiển thị thông báo lỗi
//         showAlertDialog(context, '',
//             'There was an error creating your account. Please try again.');
//       }
//     } catch (e) {
//       // Xử lý các lỗi khác có thể xảy ra trong quá trình đăng ký
//       showAlertDialog(context, '',
//           'This email has been registered. Please try again later.');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Register'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(
//                 labelText: 'Enter your password',
//                 labelStyle: TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.blue,
//                     width: 2.0,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.blue,
//                     width: 1.0,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _confirmPasswordController,
//               decoration: const InputDecoration(
//                 labelText: 'Confirm your password',
//                 labelStyle: TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.blue,
//                     width: 2.0,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.blue,
//                     width: 1.0,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             SizedBox(
//               height: 45, // Đặt chiều cao tối đa cho nút
//               child: ElevatedButton(
//                 onPressed: _register,
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.blue,
//                   textStyle: const TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   minimumSize: Size(double.infinity, 30),
//                 ),
//                 child: Text('Register'),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
