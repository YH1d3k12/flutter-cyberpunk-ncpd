import 'package:flutter/material.dart';
import 'login_button.dart';
import '../../../../shared/cyber_text_input.dart';
import '../../../../core/services/validator_login_username.dart';
import '../../../../core/services/validator_login_password.dart';

class LoginForm extends StatelessWidget {
  final bool isLoading;
  final GlobalKey<FormState> formKey;
  final Function(String?) onUserSaved;
  final Function(String?) onPassSaved;
  final VoidCallback onSubmit;

  const LoginForm({
    super.key,
    required this.isLoading,
    required this.formKey,
    required this.onUserSaved,
    required this.onPassSaved,
    required this.onSubmit,
  }); 

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CyberTextInput(
            label: "Username",
            icon: Icons.person,
            onSaved: onUserSaved,
            validator: ValidatorLoginUsername.validate,
          ),
          const SizedBox(height: 20),
          CyberTextInput(
            label: "Password",
            icon: Icons.lock,
            obscureText: true,
            onSaved: onPassSaved,
            validator: ValidatorLoginPassword.validate,
          ),
          const SizedBox(height: 30),
          isLoading ?  CircularProgressIndicator() : LoginButton(onPressed: onSubmit),
        ],
      ),
    );
  }
}