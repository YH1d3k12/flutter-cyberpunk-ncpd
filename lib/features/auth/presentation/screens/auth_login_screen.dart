import 'package:flutter/material.dart';
import '../../../../shared/widgets/footer.dart';
import '../../../../routes/app_routes.dart';
import '../../../../core/models/user.dart';
import '../widgets/login_title.dart';
import '../widgets/login_form.dart';
import '../widgets/login_subtitle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _isLoading = false;
  
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _isLoading = true);
    final success = await MockUsers.login(_username, _password);

    if (!mounted) return;
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário ou senha inválidos'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => _isLoading = false);
      
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      "/boot",
      arguments: AppRoutes.home,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff0d0d0f),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              children: [
                LoginTitle(screenWidth: screenWidth),
                const SizedBox(height: 40),
                LoginForm(
                  isLoading: _isLoading,
                  formKey: _formKey,
                  onUserSaved: (v) => _username = v ?? '',
                  onPassSaved: (v) => _password = v ?? '',
                  onSubmit: _handleLogin,
                ),
                const SizedBox(height: 20),
                LoginSubtitle(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}