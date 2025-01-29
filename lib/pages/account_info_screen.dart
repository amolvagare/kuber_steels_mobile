import 'package:flutter/material.dart';
import 'package:kuber_steels/pages/dialog_utils.dart';
import 'package:kuber_steels/services/authentication.dart';
import '../theme/app_theme.dart';
import 'package:kuber_steels/models/user.dart';
import 'package:kuber_steels/services/api_service.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = ApiService().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: FutureBuilder<User>(
            future: _userFuture,
            builder: (context, snapshot) {
              String username = 'No data';
              String email = 'No data';
              String mobile = 'No data';

              if (snapshot.hasData) {
                username = snapshot.data!.username;
                email = snapshot.data!.email;
                mobile = snapshot.data!.mobileNo;
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close Icon aligned to the right
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.secondaryColor,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  if (snapshot.connectionState == ConnectionState.waiting)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  _buildInfoField(Icons.person, username, context),
                  const SizedBox(height: 12),
                  _buildInfoField(Icons.email, email, context),
                  const SizedBox(height: 12),
                  _buildInfoField(Icons.phone, mobile, context),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      AuthenticationService().logOut();
                      Navigator.pushReplacementNamed(context, '/login');
                      DialogUtils.showErrorDialog("User logged off successfully");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Log out', 
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Action for privacy policy
                    },
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField(IconData icon, String label, BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
