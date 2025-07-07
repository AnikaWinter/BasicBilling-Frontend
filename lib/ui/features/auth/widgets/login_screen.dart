import 'package:basic_billing_application/ui/features/auth/viewModels/auth_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _login() async {
    final viewModel = context.read<AuthViewModel>();
    final success = await viewModel.login(
      _userNameController.text,
      _passwordController.text,
    );

    if (success) {
      // Navigate to home screen
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AuthViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Billing'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.orange,
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            if (viewModel.errorMessage != null)
              Text(
                viewModel.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 5,
                  ),
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _userNameController,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.blueGrey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 3,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      cursorColor: Colors.indigo,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 5,
                  ),
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.blueGrey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 3,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      cursorColor: Colors.indigo,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                viewModel.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width / 4,
                          30,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      child: const Text('Login'),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
