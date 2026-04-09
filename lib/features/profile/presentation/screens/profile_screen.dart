import 'package:flutter/material.dart';

import '../../../../app/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Sophia Patel');
  final TextEditingController _emailController =
      TextEditingController(text: 'sophiapatel@gmail.com');
  final TextEditingController _addressController =
      TextEditingController(text: '123 Main St Apartment 4A,New York, NY');
  final TextEditingController _passwordController =
      TextEditingController(text: '1234567890');

  bool _isEditing = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            _isEditing ? 'Modo edicion activado' : 'Cambios listos',
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 170,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFF3757), Color(0xFFFF2347)],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Positioned(
                    left: -36,
                    top: 22,
                    child: Opacity(
                      opacity: 0.28,
                      child: Image.asset(
                        'assets/images/veggie_burger.png',
                        width: 120,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -28,
                    top: 20,
                    child: Opacity(
                      opacity: 0.28,
                      child: Image.asset(
                        'assets/images/fried_chicken_burger.png',
                        width: 140,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 10,
                    child: _HeaderIcon(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 10,
                    child: _HeaderIcon(
                      icon: Icons.settings,
                      onTap: () => Navigator.pushNamed(context, AppRouter.chat),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: _AvatarFrame(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -18),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(14, 54, 14, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    _EditableField(
                      label: 'Name',
                      controller: _nameController,
                      enabled: _isEditing,
                    ),
                    const SizedBox(height: 14),
                    _EditableField(
                      label: 'Email',
                      controller: _emailController,
                      enabled: _isEditing,
                    ),
                    const SizedBox(height: 14),
                    _EditableField(
                      label: 'Delivery address',
                      controller: _addressController,
                      enabled: _isEditing,
                    ),
                    const SizedBox(height: 14),
                    _EditableField(
                      label: 'Password',
                      controller: _passwordController,
                      enabled: _isEditing,
                      showLock: true,
                      obscureText: _obscurePassword,
                      trailing: InkWell(
                        onTap: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        child: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 18,
                          color: const Color(0xFF9A8F8B),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Divider(color: Color(0xFFF0E8E6)),
                    _MenuRow(
                      title: 'Payment Details',
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRouter.payment,
                        arguments: AppRouter.sampleOrderSummary,
                      ),
                    ),
                    _MenuRow(
                      title: 'Order history',
                      onTap: () => Navigator.pushNamed(context, AppRouter.chat),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FilledButton(
                              onPressed: _toggleEdit,
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF453533),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_isEditing ? 'Save Profile' : 'Edit Profile'),
                                  const SizedBox(width: 8),
                                  Icon(
                                    _isEditing
                                        ? Icons.check_circle_outline
                                        : Icons.edit_outlined,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRouter.splash,
                                (route) => false,
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Log out'),
                                  SizedBox(width: 8),
                                  Icon(Icons.logout, size: 18),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}

class _AvatarFrame extends StatelessWidget {
  const _AvatarFrame();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 34),
      child: Container(
        width: 102,
        height: 102,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: Color(0x29000000),
              blurRadius: 18,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/images/profile_avatar.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _EditableField extends StatelessWidget {
  const _EditableField({
    required this.label,
    required this.controller,
    required this.enabled,
    this.showLock = false,
    this.obscureText = false,
    this.trailing,
  });

  final String label;
  final TextEditingController controller;
  final bool enabled;
  final bool showLock;
  final bool obscureText;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD9D2CF)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 14,
            top: -10,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF9A8F8B),
                      fontSize: 14,
                    ),
                  ),
                  if (showLock) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.lock, size: 12, color: Color(0xFF9A8F8B)),
                  ],
                ],
              ),
            ),
          ),
          TextField(
            controller: controller,
            enabled: enabled,
            obscureText: obscureText,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3F302D),
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
              suffixIcon: trailing == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: trailing,
                    ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6D625E),
              ),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Color(0xFF6D625E)),
          ],
        ),
      ),
    );
  }
}
