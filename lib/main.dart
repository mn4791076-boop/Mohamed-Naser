import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Cyber System',
    home: RoleSelectionScreen(),
  ));
}

// ==========================================
// 🔑 الكود السري الخاص بك لتشغيل لوحة التحكم
// ==========================================
const String ownerSecretKey = "mohamed202601281371307"; 

// 1. شاشة البداية: اختيار (صاحب سيبر) أو (زبون)
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("🎮 Cyber System 🎮", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("اختر طريقة الدخول لتشغيل النظام", style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 40),
              
              // زر دخول صاحب السيبر (محمي بكود)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const OwnerCheckScreen()));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.admin_panel_settings, color: Colors.white),
                    SizedBox(width: 10),
                    Text("دخول
