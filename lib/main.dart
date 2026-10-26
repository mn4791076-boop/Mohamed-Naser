import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Cyber System',
    home: RoleSelectionScreen(),
  ));
}

// 🔐 كود التفعيل السري لتطبيقك
const String masterActivationCode = "CYBER2026VIP"; 

class DeviceModel {
  String name;
  String type;
  bool isAvailable;

  DeviceModel({required this.name, required this.type, this.isAvailable = true});
}

class AppData {
  static String shopName = "سايبر الألعاب";
  static String ownerPhone = "01000000000";
  static String ownerInstapay = "cyber.owner@instapay";
  static String ownerLoggedInPhone = ""; 
  
  static List<DeviceModel> devices = [
    DeviceModel(name: "PlayStation 1", type: "بلايستيشن", isAvailable: true),
    DeviceModel(name: "PC 1", type: "بي سي", isAvailable: true),
  ];

  static List<String> adminNotifications = [];
}

// 1. شاشة البداية الرئيسية
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
              const Icon(Icons.sports_esports, size: 60, color: Colors.purpleAccent),
              const SizedBox(height: 20),
              const Text(
                "Cyber System التجاري",
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "نظام إدارة السايبر المتقدم",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 40),
              
              // زر دخول صاحب السيرفر
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  _showOwnerAuthDialog(context);
                },
                child: const Text("دخول صاحب السيرفر (إدارة)", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              const SizedBox(height: 20),

              // زر دخول الزبون
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  side: const BorderSide(color: Colors.purpleAccent, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CustomerBookingScreen()),
                  );
                },
                child: const Text("دخول الزبون (حجز الأجهزة)", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOwnerAuthDialog(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2F),
        title: const Text("🔐 تحقق مالك السايبر", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "رقم تليفونك الشخصي", labelStyle: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: codeController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "كود التفعيل السري", labelStyle: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            onPressed: () {
              if (codeController.text == masterActivationCode) {
                AppData.ownerLoggedInPhone = phoneController.text;
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OwnerDashboardScreen()),
                );
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("❌ كود التفعيل غير صحيح!")),
                );
              }
            },
            child: const Text("دخول", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// 2. لوحة التحكم
class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  final TextEditingController shopNameCtrl = TextEditingController(text: AppData.shopName);
  final TextEditingController phoneCtrl = TextEditingController(text: AppData.ownerPhone);
  final TextEditingController instapayCtrl = TextEditingController(text: AppData.ownerInstapay);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("إدارة: ${AppData.shopName}", style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: shopNameCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "اسم السايبر", labelStyle: TextStyle(color: Colors.grey)),
            ),
            TextField(
              controller: phoneCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "رقم فودافون كاش", labelStyle: TextStyle(color: Colors.grey)),
            ),
            TextField(
              controller: instapayCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "حساب إنستا باي", labelStyle: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: () {
                setState(() {
                  AppData.shopName = shopNameCtrl.text;
                  AppData.ownerPhone = phoneCtrl.text;
                  AppData.ownerInstapay = instapayCtrl.text;
                });
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ تم الحفظ")));
              },
              child: const Text("حفظ الإعدادات", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            const Text("🔔 التنبيهات وإيصالات الحجز:", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              height: 100,
              decoration: BoxDecoration(color: const Color(0xFF1E1E2F), borderRadius: BorderRadius.circular(12)),
              child: AppData.adminNotifications.isEmpty
                  ? const Center(child: Text("لا توجد تنبيهات جديدة", style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      itemCount: AppData.adminNotifications.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(AppData.adminNotifications[index], style: const TextStyle(color: Colors.white, fontSize: 13)),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.between,
              children: [
                const Text("🎮 الأجهزة:", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: () => _addDeviceDialog(),
                  child: const Text("إضافة جهاز", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: AppData.devices.length,
              itemBuilder: (context, index) {
                final dev = AppData.devices[index];
                return Card(
                  color: const Color(0xFF1E1E2F),
                  child: ListTile(
                    title: Text(dev.name, style: const TextStyle(color: Colors.white)),
                    subtitle: Text(dev.type, style: const TextStyle(color: Colors.grey)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => setState(() => AppData.devices.removeAt(index)),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addDeviceDialog() {
    final TextEditingController nameCtrl = TextEditingController();
    String type = "بلايستيشن";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2F),
        title: const Text("إضافة جهاز", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(hintText: "اسم الجهاز", hintStyle: TextStyle(color: Colors.grey)),
            ),
            DropdownButton<String>(
              value: type,
              dropdownColor: const Color(0xFF1E1E2F),
              style: const TextStyle(color: Colors.white),
              items: ["بلايستيشن", "بي سي"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => type = val!,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                setState(() => AppData.devices.add(DeviceModel(name: nameCtrl.text, type: type)));
                Navigator.pop(context);
              }
            },
            child: const Text("إضافة", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// 3. حجز الزبون
class CustomerBookingScreen extends StatefulWidget {
  const CustomerBookingScreen({super.key});

  @override
  State<CustomerBookingScreen> createState() => _CustomerBookingScreenState();
}

class _CustomerBookingScreenState extends State<CustomerBookingScreen> {
  DeviceModel? selectedDevice;
  double hours = 1;
  String payment = "نقدي (كاش)";
  bool receiptAttached = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(AppData.shopName, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("اختر الجهاز:", style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: AppData.devices.length,
                itemBuilder: (context, index) {
                  final dev = AppData.devices[index];
                  return Card(
                    color: selectedDevice == dev ? Colors.purple.withOpacity(0.5) : const Color(0xFF1E1E2F),
                    child: ListTile(
                      title: Text(dev.name, style: const TextStyle(color: Colors.white)),
                      subtitle: Text(dev.isAvailable ? "متاح 🟢" : "مشغول 🔴", style: TextStyle(color: dev.isAvailable ? Colors.green : Colors.red)),
                      onTap: dev.isAvailable ? () => setState(() => selectedDevice = dev) : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text("الساعات: ${hours.toInt()}", style: const TextStyle(color: Colors.white)),
            Slider(
              value: hours,
              min: 1,
              max: 10,
              divisions: 9,
              activeColor: Colors.purple,
              onChanged: (val) => setState(() => hours = val),
            ),
            DropdownButtonFormField<String>(
              value: payment,
              dropdownColor: const Color(0xFF1E1E2F),
              style: const TextStyle(color: Colors.white),
              items: [
                "نقدي (كاش)",
                "فودافون كاش (${AppData.ownerPhone})",
                "إنستا باي (${AppData.ownerInstapay})"
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => payment = val!),
            ),
            if (!payment.contains("نقدي")) ...[
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: receiptAttached ? Colors.green : Colors.deepPurple),
                onPressed: () {
                  setState(() => receiptAttached = true);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("📸 تم إرفاق الإيصال بنجاح!")));
                },
                icon: Icon(receiptAttached ? Icons.check : Icons.camera_alt),
                label: Text(receiptAttached ? "تم إرفاق الإيصال" : "تصوير / رفع إيصال التحويل"),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: selectedDevice == null ? null : () {
                if (!payment.contains("نقدي") && !receiptAttached) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("⚠️ برجاء إرفاق الإيصال أولاً")));
                  return;
                }
                setState(() => selectedDevice!.isAvailable = false);
                AppData.adminNotifications.insert(0, "حجز: ${selectedDevice!.name} لمدة ${hours.toInt()} ساعات ($payment)");
                Navigator.pop(context);
              },
              child: const Text("تأكيد الحجز", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
