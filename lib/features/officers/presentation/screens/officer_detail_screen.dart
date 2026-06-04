import 'package:flutter/material.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/ncpd_app_bar.dart';
import '../../domain/models/officer.dart';
import 'officer_form_screen.dart';

class OfficerDetailScreen extends StatefulWidget {
  const OfficerDetailScreen({super.key, required this.officer});

  final Officer officer;

  @override
  State<OfficerDetailScreen> createState() => _OfficerDetailScreenState();
}

class _OfficerDetailScreenState extends State<OfficerDetailScreen> {
  late Officer _officer;

  @override
  void initState() {
    super.initState();
    _officer = widget.officer;
  }

  Future<void> _openEdit() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OfficerFormScreen(officer: _officer),
      ),
    );
    // Reload the officer from DB after editing
    final updated = await ServiceLocator.instance.officerService
        .getOfficerById(_officer.id);
    if (updated != null && mounted) {
      setState(() => _officer = updated);
    }
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => _ConfirmDeleteDialog(name: _officer.name),
    );
    if (confirmed != true || !mounted) return;

    await ServiceLocator.instance.officerService.deleteOfficer(_officer.id);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _officer.status.color;

    return Scaffold(
      appBar: NcpdAppBar(
        title: 'OFFICER FILE',
        subtitle: _officer.badgeNumber,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit Officer',
            onPressed: _openEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.danger),
            tooltip: 'Delete Officer',
            onPressed: _confirmDelete,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Profile card ───────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.backgroundCard,
                border: Border(
                  left: BorderSide(color: statusColor, width: 4),
                  top:    const BorderSide(color: AppColors.border),
                  right:  const BorderSide(color: AppColors.border),
                  bottom: const BorderSide(color: AppColors.border),
                ),
              ),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.12),
                      border: Border.all(
                        color: statusColor.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _officer.name[0].toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _officer.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _officer.badgeNumber,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                            color: AppColors.primary,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Status badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.12),
                      border: Border.all(color: statusColor.withOpacity(0.5)),
                    ),
                    child: Text(
                      _officer.status.displayName,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            _sectionLabel('SERVICE RECORD'),
            const SizedBox(height: 10),

            _infoRow('RANK',       _officer.rank.displayName),
            _divider(),
            _infoRow('STATUS',     _officer.status.displayName,
                valueColor: statusColor),
            _divider(),
            _infoRow('ENROLLED',
                _formatDate(_officer.createdAt)),
            if (_officer.updatedAt != null) ...[
              _divider(),
              _infoRow('LAST UPDATED',
                  _formatDate(_officer.updatedAt!)),
            ],
            _divider(),
            _infoRow('RECORD ID',  _officer.id,
                monospace: true, small: true),

            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: _openEdit,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_outlined, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'EDIT OFFICER RECORD',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      letterSpacing: 2,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) => Text(
        label,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 10,
          color: AppColors.primary,
          letterSpacing: 2,
          fontWeight: FontWeight.w700,
        ),
      );

  Widget _infoRow(
    String label,
    String value, {
    Color? valueColor,
    bool monospace = false,
    bool small = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: AppColors.textMuted,
                letterSpacing: 1.3,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontFamily: monospace ? 'monospace' : null,
                fontSize: small ? 11 : 13,
                color: valueColor ?? AppColors.textPrimary,
                letterSpacing: monospace ? 0.5 : 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(height: 1, thickness: 1);

  String _formatDate(DateTime dt) =>
      '${dt.year.toString().padLeft(4, '0')}-'
      '${dt.month.toString().padLeft(2, '0')}-'
      '${dt.day.toString().padLeft(2, '0')}  '
      '${dt.hour.toString().padLeft(2, '0')}:'
      '${dt.minute.toString().padLeft(2, '0')}';
}

class _ConfirmDeleteDialog extends StatelessWidget {
  const _ConfirmDeleteDialog({required this.name});
  final String name;

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
        'Permanently remove "$name" from the NCPD database?',
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
