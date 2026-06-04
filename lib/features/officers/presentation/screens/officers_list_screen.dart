import 'package:flutter/material.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/loading_overlay.dart';
import '../../../../shared/widgets/ncpd_app_bar.dart';
import '../../domain/models/officer.dart';
import '../widgets/officer_card.dart';
import 'officer_detail_screen.dart';
import 'officer_form_screen.dart';

class OfficersListScreen extends StatefulWidget {
  const OfficersListScreen({super.key});

  @override
  State<OfficersListScreen> createState() => _OfficersListScreenState();
}

class _OfficersListScreenState extends State<OfficersListScreen> {
  late Future<List<Officer>> _officersFuture;

  @override
  void initState() {
    super.initState();
    _loadOfficers();
  }

  void _loadOfficers() {
    _officersFuture =
        ServiceLocator.instance.officerService.getAllOfficers();
  }

  Future<void> _refresh() async {
    setState(() => _loadOfficers());
  }

  // ── Delete ──────────────────────────────────────────────────────────────

  Future<void> _confirmDelete(Officer officer) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => _DeleteDialog(officerName: officer.name),
    );
    if (confirmed != true || !mounted) return;

    try {
      await ServiceLocator.instance.officerService
          .deleteOfficer(officer.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'OFFICER ${officer.badgeNumber} REMOVED',
            style: const TextStyle(
              fontFamily: 'monospace',
              letterSpacing: 1.2,
              fontSize: 11,
            ),
          ),
          backgroundColor: AppColors.backgroundCard,
        ),
      );
      _refresh();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error removing officer'),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  // ── Navigation ──────────────────────────────────────────────────────────

  Future<void> _openDetail(Officer officer) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OfficerDetailScreen(officer: officer),
      ),
    );
    _refresh();
  }

  Future<void> _openCreate() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const OfficerFormScreen()),
    );
    _refresh();
  }

  // ── Build ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NcpdAppBar(
        title: 'PERSONNEL DATABASE',
        subtitle: 'NCPD // AUTHORIZED ACCESS',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreate,
        tooltip: 'Register Officer',
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Officer>>(
        future: _officersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingOverlay(
              isLoading: true,
              message: 'LOADING PERSONNEL...',
              child: SizedBox.expand(),
            );
          }

          if (snapshot.hasError) {
            return _ErrorView(error: snapshot.error.toString());
          }

          final officers = snapshot.data ?? [];

          if (officers.isEmpty) {
            return const _EmptyView();
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: _refresh,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _SummaryHeader(count: officers.length),
                ...officers.map(
                  (o) => OfficerCard(
                    officer: o,
                    onTap: () => _openDetail(o),
                    onDelete: () => _confirmDelete(o),
                  ),
                ),
                const SizedBox(height: 80), // FAB clearance
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── Sub-widgets ──────────────────────────────────────────────────────────────

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(
        '[ $count OFFICER${count != 1 ? "S" : ""} ON RECORD ]',
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 10,
          color: AppColors.textMuted,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people_outline, size: 56, color: AppColors.textMuted),
          SizedBox(height: 16),
          Text(
            'NO PERSONNEL ON RECORD',
            style: TextStyle(
              fontFamily: 'monospace',
              color: AppColors.textMuted,
              fontSize: 12,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          '[ SYSTEM ERROR ]\n$error',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'monospace',
            color: AppColors.danger,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _DeleteDialog extends StatelessWidget {
  const _DeleteDialog({required this.officerName});
  final String officerName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: AppColors.danger),
      ),
      title: const Text(
        'CONFIRM DELETION',
        style: TextStyle(
          fontFamily: 'monospace',
          color: AppColors.danger,
          fontSize: 13,
          letterSpacing: 2,
        ),
      ),
      content: Text(
        'Remove officer "$officerName" from the database?\nThis action cannot be undone.',
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.danger,
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: const Text(
            'DELETE',
            style: TextStyle(fontFamily: 'monospace', letterSpacing: 1.5),
          ),
        ),
      ],
    );
  }
}
