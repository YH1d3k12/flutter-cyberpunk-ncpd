import 'package:flutter/material.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/services/session_manager.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_routes.dart';
import '../../../../shared/components/cyber_card.dart';
import '../../../../shared/widgets/ncpd_app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<int> _officerCountFuture;

  @override
  void initState() {
    super.initState();
    _officerCountFuture =
        ServiceLocator.instance.officerService.countOfficers();
  }

  Future<void> _logout() async {
    await ServiceLocator.instance.authRepository.logout();
    SessionManager.instance.clearSession();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final officer = SessionManager.instance.currentOfficer;

    return Scaffold(
      appBar: NcpdAppBar(
        title: 'NCPD COMMAND',
        subtitle: 'NIGHT CITY POLICE DEPARTMENT',
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Welcome ────────────────────────────────────────────────────
            if (officer != null) ...[
              Text(
                'WELCOME, OFFICER',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: AppColors.textMuted,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                officer.name.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  letterSpacing: 2,
                ),
              ),
              Text(
                '${officer.badgeNumber}  ·  ${officer.rank.displayName}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: AppColors.textSecondary,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                height: 1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, Colors.transparent],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // ── Stats row ──────────────────────────────────────────────────
            const Text(
              'SYSTEM STATUS',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: AppColors.primary,
                letterSpacing: 2,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FutureBuilder<int>(
                    future: _officerCountFuture,
                    builder: (ctx, snap) => _StatCard(
                      label: 'PERSONNEL',
                      value: snap.data?.toString() ?? '–',
                      icon: Icons.people_outline,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: _StatCard(
                    label: 'ACTIVE CASES',
                    value: '–',
                    icon: Icons.folder_open_outlined,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: _StatCard(
                    label: 'INCIDENTS',
                    value: '–',
                    icon: Icons.warning_amber_outlined,
                    color: AppColors.danger,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ── Module grid ────────────────────────────────────────────────
            const Text(
              'MODULES',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: AppColors.primary,
                letterSpacing: 2,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            _ModuleTile(
              icon: Icons.people,
              label: 'PERSONNEL DATABASE',
              subtitle: 'Manage NCPD officers',
              color: AppColors.primary,
              onTap: () => Navigator.pushNamed(context, AppRoutes.officers),
            ),
            const SizedBox(height: 8),
            _ModuleTile(
              icon: Icons.folder_outlined,
              label: 'CASES',
              subtitle: 'Coming soon',
              color: AppColors.accent,
              onTap: null,
            ),
            const SizedBox(height: 8),
            _ModuleTile(
              icon: Icons.person_search,
              label: 'WANTED',
              subtitle: 'Coming soon',
              color: AppColors.danger,
              onTap: null,
            ),
            const SizedBox(height: 8),
            _ModuleTile(
              icon: Icons.directions_car_outlined,
              label: 'VEHICLES',
              subtitle: 'Coming soon',
              color: AppColors.accent,
              onTap: null,
            ),

            const SizedBox(height: 32),
            Center(
              child: Text(
                'NCPD SYSTEM v1.0.0 · CLASSIFIED',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9,
                  color: AppColors.textMuted,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Sub-widgets ──────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 8,
              color: AppColors.textMuted,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return CyberCard(
      borderColor: enabled ? color : AppColors.border,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: enabled ? color : AppColors.textMuted,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: enabled ? AppColors.textPrimary : AppColors.textMuted,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: enabled ? color : AppColors.textMuted,
            size: 18,
          ),
        ],
      ),
    );
  }
}
