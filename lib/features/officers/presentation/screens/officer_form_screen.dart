import 'package:flutter/material.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/components/cyber_button.dart';
import '../../../../shared/components/cyber_text_input.dart';
import '../../../../shared/widgets/loading_overlay.dart';
import '../../../../shared/widgets/ncpd_app_bar.dart';
import '../../domain/models/officer.dart';
import '../../domain/services/officer_service.dart';

/// Used for both CREATE (officer == null) and EDIT (officer != null).
class OfficerFormScreen extends StatefulWidget {
  const OfficerFormScreen({super.key, this.officer});

  /// Null → create mode  |  Non-null → edit mode.
  final Officer? officer;

  @override
  State<OfficerFormScreen> createState() => _OfficerFormScreenState();
}

class _OfficerFormScreenState extends State<OfficerFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _badgeCtrl;
  late final TextEditingController _nameCtrl;
  late final TextEditingController _passwordCtrl;
  late final TextEditingController _confirmCtrl;

  OfficerRank   _rank    = OfficerRank.officer;
  OfficerStatus _status  = OfficerStatus.active;

  bool _obscurePass    = true;
  bool _obscureConfirm = true;
  bool _isLoading      = false;
  String? _errorMessage;

  bool get _isEditing => widget.officer != null;

  @override
  void initState() {
    super.initState();
    final o = widget.officer;
    _badgeCtrl    = TextEditingController(text: o?.badgeNumber ?? '');
    _nameCtrl     = TextEditingController(text: o?.name ?? '');
    _passwordCtrl = TextEditingController();
    _confirmCtrl  = TextEditingController();
    if (o != null) {
      _rank   = o.rank;
      _status = o.status;
    }
  }

  @override
  void dispose() {
    _badgeCtrl.dispose();
    _nameCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  // ── Submit ───────────────────────────────────────────────────────────────

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading    = true;
      _errorMessage = null;
    });

    try {
      final service = ServiceLocator.instance.officerService;

      if (_isEditing) {
        await service.updateOfficer(
          current:     widget.officer!,
          name:        _nameCtrl.text,
          rank:        _rank,
          status:      _status,
          newPassword: _passwordCtrl.text.isNotEmpty
              ? _passwordCtrl.text
              : null,
        );
      } else {
        await service.createOfficer(
          badgeNumber: _badgeCtrl.text,
          name:        _nameCtrl.text,
          rank:        _rank,
          password:    _passwordCtrl.text,
        );
      }

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? 'OFFICER RECORD UPDATED'
                : 'OFFICER ${_badgeCtrl.text.toUpperCase()} REGISTERED',
            style: const TextStyle(
              fontFamily: 'monospace',
              letterSpacing: 1.2,
              fontSize: 11,
            ),
          ),
          backgroundColor: AppColors.backgroundCard,
        ),
      );
    } on OfficerServiceException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _isLoading    = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Unexpected error. Try again.';
        _isLoading    = false;
      });
    }
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NcpdAppBar(
        title: _isEditing ? 'EDIT OFFICER' : 'REGISTER OFFICER',
        subtitle: _isEditing
            ? 'NCPD // UPDATE RECORD'
            : 'NCPD // NEW PERSONNEL',
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        message: _isEditing ? 'UPDATING RECORD...' : 'REGISTERING...',
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionLabel('IDENTIFICATION'),
                const SizedBox(height: 12),

                // Badge Number (read-only in edit mode)
                CyberTextInput(
                  label: 'BADGE NUMBER',
                  controller: _badgeCtrl,
                  hint: 'e.g. NCPD-006',
                  prefixIcon: Icons.badge_outlined,
                  textCapitalization: TextCapitalization.characters,
                  readOnly: _isEditing,
                  validator: (v) {
                    if (!_isEditing) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Badge number required';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                CyberTextInput(
                  label: 'FULL NAME',
                  controller: _nameCtrl,
                  prefixIcon: Icons.person_outline,
                  textCapitalization: TextCapitalization.words,
                  validator: (v) {
                    if (v == null || v.trim().length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // Rank dropdown
                CyberDropdown<OfficerRank>(
                  label: 'RANK',
                  value: _rank,
                  items: OfficerRank.values
                      .map(
                        (r) => DropdownMenuItem(
                          value: r,
                          child: Text(r.displayName),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _rank = v ?? _rank),
                  validator: (v) => v == null ? 'Rank required' : null,
                ),

                // Status dropdown (edit only)
                if (_isEditing) ...[
                  const SizedBox(height: 14),
                  CyberDropdown<OfficerStatus>(
                    label: 'STATUS',
                    value: _status,
                    items: OfficerStatus.values
                        .map(
                          (s) => DropdownMenuItem(
                            value: s,
                            child: Text(s.displayName),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _status = v ?? _status),
                  ),
                ],

                const SizedBox(height: 24),
                _sectionLabel(
                  _isEditing ? 'CHANGE PASSWORD (optional)' : 'ACCESS CREDENTIALS',
                ),
                const SizedBox(height: 12),

                CyberTextInput(
                  label: _isEditing ? 'NEW PASSWORD' : 'PASSWORD',
                  controller: _passwordCtrl,
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePass,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePass ? Icons.visibility_off : Icons.visibility,
                      size: 18,
                      color: AppColors.textMuted,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePass = !_obscurePass),
                  ),
                  validator: (v) {
                    if (!_isEditing && (v == null || v.isEmpty)) {
                      return 'Password required';
                    }
                    if ((v ?? '').isNotEmpty && v!.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                CyberTextInput(
                  label: 'CONFIRM PASSWORD',
                  controller: _confirmCtrl,
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscureConfirm,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                      size: 18,
                      color: AppColors.textMuted,
                    ),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  validator: (v) {
                    if (_passwordCtrl.text.isNotEmpty &&
                        v != _passwordCtrl.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                // Error banner
                if (_errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: AppColors.dangerGlow,
                      border: Border(
                        left: BorderSide(color: AppColors.danger, width: 3),
                      ),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: AppColors.danger,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 32),
                CyberButton(
                  label: _isEditing ? 'SAVE CHANGES' : 'REGISTER OFFICER',
                  onPressed: _isLoading ? null : _onSubmit,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
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
}
