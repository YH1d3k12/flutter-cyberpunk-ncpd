import 'package:flutter/material.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/services/session_manager.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/auth/domain/repositories/auth_repository.dart';
import '../../../../routes/app_routes.dart';
import '../../../../shared/components/cyber_button.dart';
import '../../../../shared/components/cyber_text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey       = GlobalKey<FormState>();
  final _badgeCtrl     = TextEditingController();
  final _passwordCtrl  = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading       = false;
  String? _errorMessage;

  late final AnimationController _glitchController;
  late final Animation<double>    _glitchAnim;

  @override
  void initState() {
    super.initState();
    _glitchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _glitchAnim = Tween(begin: 0.0, end: 1.0).animate(_glitchController);
  }

  @override
  void dispose() {
    _badgeCtrl.dispose();
    _passwordCtrl.dispose();
    _glitchController.dispose();
    super.dispose();
  }

  // ── Auth logic ──────────────────────────────────────────────────────────

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading     = true;
      _errorMessage  = null;
    });

    try {
      final officer = await ServiceLocator.instance.authRepository.login(
        _badgeCtrl.text,
        _passwordCtrl.text,
      );

      if (!mounted) return;

      if (officer == null) {
        _glitchController.forward().then((_) => _glitchController.reverse());
        setState(() {
          _errorMessage = '[ ACCESS DENIED ]  Invalid credentials.';
          _isLoading    = false;
        });
        return;
      }

      SessionManager.instance.setCurrentOfficer(officer);
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = '[ SYSTEM ERROR ]  ${e.message}';
        _isLoading    = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage = '[ SYSTEM ERROR ]  Contact Night City IT support.';
        _isLoading    = false;
      });
    }
  }

  // ── UI ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _CyberBackground(),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: AnimatedBuilder(
                  animation: _glitchAnim,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_glitchAnim.value * 4, 0),
                      child: child,
                    );
                  },
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 40),
                        _buildForm(),
                        const SizedBox(height: 8),
                        if (_errorMessage != null) _buildError(),
                        const SizedBox(height: 24),
                        CyberButton(
                          label: _isLoading
                              ? 'AUTHENTICATING...'
                              : 'AUTHORIZE ACCESS',
                          onPressed: _isLoading ? null : _onLogin,
                          isLoading: _isLoading,
                        ),
                        const SizedBox(height: 24),
                        _buildFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 40,
              color: AppColors.primary,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'NCPD SYSTEM',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    letterSpacing: 4,
                  ),
                ),
                Text(
                  'NIGHT CITY POLICE DEPARTMENT',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9,
                    color: AppColors.textMuted,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 1,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, Colors.transparent],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'AUTHORIZED PERSONNEL ONLY',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            color: AppColors.accent,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        CyberTextInput(
          label: 'BADGE NUMBER',
          controller: _badgeCtrl,
          hint: 'e.g. NCPD-001',
          prefixIcon: Icons.badge_outlined,
          textCapitalization: TextCapitalization.characters,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Badge number required';
            return null;
          },
        ),
        const SizedBox(height: 16),
        CyberTextInput(
          label: 'PASSWORD',
          controller: _passwordCtrl,
          prefixIcon: Icons.lock_outline,
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              size: 18,
              color: AppColors.textMuted,
            ),
            onPressed: () =>
                setState(() => _obscurePassword = !_obscurePassword),
          ),
          validator: (v) {
            if (v == null || v.isEmpty) return 'Password required';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildError() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: AppColors.dangerGlow,
        border: const Border(
          left: BorderSide(color: AppColors.danger, width: 3),
        ),
      ),
      child: Text(
        _errorMessage!,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: AppColors.danger,
          fontSize: 11,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Text(
        'v1.0.0 · CLASSIFIED · ${DateTime.now().year} NCPD',
        style: const TextStyle(
          fontFamily: 'monospace',
          color: AppColors.textMuted,
          fontSize: 9,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

// ── Cyberpunk grid background ────────────────────────────────────────────────

class _CyberBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: _GridPainter(),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border.withOpacity(0.4)
      ..strokeWidth = 0.5;

    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
