import 'package:flutter/material.dart';
import 'widgets/dcyn_hard_lock_screen.dart';

void main() {
  runApp(const DcynHardLockApp());
}

class DcynHardLockApp extends StatelessWidget {
  const DcynHardLockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DCYN Hard-Lock Policy',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
      home: const DcynHardLockScreen(),
    );
  }
}
