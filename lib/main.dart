import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Cyber System',
    home: RoleSelectionScreen(),
  ));
}

const String ownerSecretKey = "mohamed202601281371307";

// نموذج بيانات الجهاز
class DeviceModel {
  String name;
  String type; // "بلايستيشن" أو "بي سي"
  bool isAvailable;

  DeviceModel({required this.name, required this.type, this.isAvailable = true});
}

// تخزين مؤقت للبيانات والتنبيهات
class AppData {
  static String shopName = "Cyber System 🎮";
  static String ownerPhone = "01000000000"; // رقم كاش افتتتاحي قابلة للتغيير
  
  static List<DeviceModel> devices = [
    DeviceModel(name: "PlayStation 1", type: "بلايستيشن", isAvailable: true),
    DeviceModel(name: "PlayStation 2", type: "بلايستيشن", isAvailable: false),
    DeviceModel(name: "PC 1", type: "بي سي", isAvailable: true),
    DeviceModel(name: "PC 2", type: "بي سي", isAvailable: true),
  ];

  static List<String> adminNotifications = [];
}

// 1. شاشة اختيار البداية بتصميم فخم
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E1E2F), Color(0xFF0F0F1E)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.sports_esports, size: 60, color: Colors.purpleAccent),
                ),
                const SizedBox(height: 20),
                Text(
                  AppData.shopName,
                  style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
                const SizedBox(height: 10),
                const Text(
                  "النظام الأذكى لإدارة ألعاب البلايستيشن والـ PC",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                
                // زر دخول صاحب السيرفر
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 5,
                  ),
                  onPressed: () {
                    _showOwnerLoginDialog(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.admin_panel_settings, color: Colors.white),
                      SizedBox(width: 10),
                      Text("دخول صاحب السيرفر (إدارة)", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // زر دخول الزبون
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    side: const BorderSide(color: Colors.purpleAccent, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CustomerBookingScreen()),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outline, color: Colors.purpleAccent),
                      SizedBox(width: 10),
                      Text("دخول الزبون (حجز الأجهزة)", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOwnerLoginDialog(BuildContext context) {
    final TextEditingController codeController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("🔐 كود صاحب السيرفر", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: codeController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "أدخل الكود السري",
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            onPressed: () {
              if (codeController.text == ownerSecretKey) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OwnerDashboardScreen()),
                );
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("❌ الكود السري غير صحيح!")),
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

// 2. لوحة تحكم صاحب السيرفر (إعدادات السايبر، كاش، إضافة أجهزة، وتنبيهات)
class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  final TextEditingController shopNameController = TextEditingController(text: AppData.shopName);
  final TextEditingController phoneController = TextEditingController(text: AppData.ownerPhone);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("لوحة تحكم صاحب السيرفر", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة تخصيص السايبر (اسم المحل ورقم الكاش)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2F),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.purple.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("⚙️ إعدادات السايبر والتحصيل", style: TextStyle(color: Colors.purpleAccent, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: shopNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "اسم السايبر", labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "رقم تليفون فودافون كاش الخاص بك", labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, minimumSize: const Size(double.infinity, 45)),
                    onPressed: () {
                      setState(() {
                        AppData.shopName = shopNameController.text;
                        AppData.ownerPhone = phoneController.text;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ تم حفظ الإعدادات بنجاح")));
                    },
                    child: const Text("حفظ الإعدادات والتحديث", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // التنبيهات
            const Text("🔔 تنبيهات الحجوزات الفورية", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              height: 110,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2F),
                borderRadius: BorderRadius.circular(16),
              ),
              child: AppData.adminNotifications.isEmpty
                  ? const Center(child: Text("لا توجد تنبيهات حجز جديدة حتى الآن", style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      itemCount: AppData.adminNotifications.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.notifications_active, color: Colors.orangeAccent),
                          title: Text(AppData.adminNotifications[index], style: const TextStyle(color: Colors.white, fontSize: 13)),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),

            // إدارة الأجهزة
            Row(
              mainAxisAlignment: MainAxisAlignment.between,
              children: [
                const Text("🎮 الأجهزة المتاحة والمشغولة:", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: () {
                    _showAddDeviceDialog();
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text("إضافة جهاز", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: AppData.devices.length,
              itemBuilder: (context, index) {
                final device = AppData.devices[index];
                return Card(
                  color: const Color(0xFF1E1E2F),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(
                      device.type == "بلايستيشن" ? Icons.sports_esports : Icons.computer,
                      color: device.isAvailable ? Colors.greenAccent : Colors.redAccent,
                    ),
                    title: Text(device.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text("النوع: ${device.type}", style: const TextStyle(color: Colors.grey)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          device.isAvailable ? "متاح 🟢" : "مشغول 🔴",
                          style: TextStyle(color: device.isAvailable ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              AppData.devices.removeAt(index);
                            });
                          },
                        ),
                      ],
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

  void _showAddDeviceDialog() {
    final TextEditingController nameController = TextEditingController();
    String type = "بلايستيشن";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("إضافة جهاز جديد للسايبر", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "اسم الجهاز (مثلا: PS 3 أو PC 5)",
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: type,
              dropdownColor: const Color(0xFF1E1E2F),
              style: const TextStyle(color: Colors.white),
              items: ["بلايستيشن", "بي سي"].map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (val) {
                type = val!;
              },
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
              if (nameController.text.isNotEmpty) {
                setState(() {
                  AppData.devices.add(DeviceModel(name: nameController.text, type: type, isAvailable: true));
                });
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

// 3. شاشة حجز الزبون (عرض الأجهزة الفاضية والمشغولة + رقم كاش صاحب السايبر + الساعات والدفع)
class CustomerBookingScreen extends StatefulWidget {
  const CustomerBookingScreen({super.key});

  @override
  State<CustomerBookingScreen> createState() => _CustomerBookingScreenState();
}

class _CustomerBookingScreenState extends State<CustomerBookingScreen> {
  DeviceModel? selectedDevice;
  double selectedHours = 1;
  String selectedPayment = "نقدي (كاش في المحل)";

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
            const Text("🎮 اختر جهازاً للحجز (الفاضي والمشغول):", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: AppData.devices.length,
                itemBuilder: (context, index) {
                  final device = AppData.devices[index];
                  bool isSelected = selectedDevice == device;
                  return Card(
                    color: isSelected ? Colors.purple.withOpacity(0.4) : const Color(0xFF1E1E2F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Icon(
                        device.type == "بلايستيشن" ? Icons.sports_esports : Icons.computer,
                        color: device.isAvailable ? Colors.greenAccent : Colors.redAccent,
                      ),
                      title: Text(device.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: Text("النوع: ${device.type}", style: const TextStyle(color: Colors.grey)),
                      trailing: Text(
                        device.isAvailable ? "متاح 🟢" : "مشغول 🔴",
                        style: TextStyle(color: device.isAvailable ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold),
                      ),
                      onTap: device.isAvailable
                          ? () {
                              setState(() {
                                selectedDevice = device;
                              });
                            }
                          : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            
            const Text("⏳ حدد عدد الساعات المطلوبة:", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            Slider(
              value: selectedHours,
              min: 1,
              max: 10,
              divisions: 9,
              activeColor: Colors.purple,
              inactiveColor: Colors.grey,
              label: "${selectedHours.toInt()} ساعات",
              onChanged: (double value) {
                setState(() {
                  selectedHours = value;
                });
              },
            ),
            Center(
              child: Text(
                "عدد الساعات: ${selectedHours.toInt()} ساعات",
                style: const TextStyle(color: Colors.purpleAccent, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            const Text("💳 طريقة الدفع:", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedPayment,
              dropdownColor: const Color(0xFF1E1E2F),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E1E2F),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: [
                "نقدي (كاش في المحل)", 
                "فودافون كاش (${AppData.ownerPhone})"
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPayment = newValue!;
                });
              },
            ),
            if (selectedPayment.contains("فودافون كاش"))
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "برجاء التحويل على الرقم: ${AppData.ownerPhone} وإظهار الإيصال للكاشير.",
                  style: const TextStyle(color: Colors.orangeAccent, fontSize: 13),
                ),
              ),
            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: selectedDevice == null
                  ? null
                  : () {
                      setState(() {
                        selectedDevice!.isAvailable = false; // جعل الجهاز مشغولاً
                      });

                      // إرسال تنبيه لصاحب السيرفر
                      AppData.adminNotifications.insert(
                        0,
                        "حجز جديد: (${selectedDevice!.name}) لمدة ${selectedHours.toInt()} ساعات عبر ($selectedPayment)",
                      );

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: const Color(0xFF1E1E2F),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          title: const Text("🎉 تم الحجز بنجاح!", style: TextStyle(color: Colors.white)),
                          content: Text(
                            "تم حجز ${selectedDevice!.name}\nالمده: ${selectedHours.toInt()} ساعات\nطريقة الدفع: $selectedPayment",
                            style: const TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text("حسناً", style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      );
                    },
              child: const Text("تأكيد وحجز الجهاز الآن", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
