import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Cyber System',
    home: RoleSelectionScreen(),
  ));
}

// 🔐 كود التفعيل السري الذي تبيعه لأصحاب السايبر
const String masterActivationCode = "CYBER2026VIP"; 

class DeviceModel {
  String name;
  String type; // "بلايستيشن" أو "بي سي"
  bool isAvailable;

  DeviceModel({required this.name, required this.type, this.isAvailable = true});
}

class AppData {
  static String shopName = "سايبر الألعاب";
  static String ownerPhone = "01000000000"; // رقم فودافون كاش
  static String ownerInstapay = "cyber.owner@instapay"; // حساب إنستا باي
  static String ownerLoggedInPhone = ""; 
  
  static List<DeviceModel> devices = [
    DeviceModel(name: "PlayStation 1", type: "بلايستيشن", isAvailable: true),
    DeviceModel(name: "PC 1", type: "بي سي", isAvailable: true),
  ];

  static List<String> adminNotifications = [];
}

// 1. شاشة اختيار البداية
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
                const Text(
                  "Cyber System التجاري",
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "إدارة ألعاب البلايستيشن والـ PC مع طرق دفع متعددة",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                
                // زر دخول صاحب السيرفر
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    _showOwnerAuthDialog(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.admin_panel_settings, color: Colors.white),
                      SizedBox(width: 10),
                      Text("دخول صاحب السيرفر (إدارة)", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
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

  void _showOwnerAuthDialog(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController activationCodeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("🔐 تحقق مالك السايبر", style: TextStyle(color: Colors.white, fontSize: 18)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "رقم تليفونك الشخصي",
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: activationCodeController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "كود التفعيل الخاص بالبرنامج",
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
              ),
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
              if (phoneController.text.length < 10) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("❌ برجاء إدخال رقم تليفون صحيح")),
                );
                return;
              }
              if (activationCodeController.text == masterActivationCode) {
                AppData.ownerLoggedInPhone = phoneController.text;
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OwnerDashboardScreen()),
                );
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("❌ كود التفعيل غير صحيح! تواصل مع المطور.")),
                );
              }
            },
            child: const Text("تحقق ودخول", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// 2. لوحة تحكم صاحب السيرفر
class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  final TextEditingController shopNameController = TextEditingController(text: AppData.shopName);
  final TextEditingController phoneController = TextEditingController(text: AppData.ownerPhone);
  final TextEditingController instapayController = TextEditingController(text: AppData.ownerInstapay);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("إدارة: ${AppData.shopName}", style: const TextStyle(color: Colors.white, fontSize: 16)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  const Text("⚙️ إعدادات السايبر وحسابات التحصيل", style: TextStyle(color: Colors.purpleAccent, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: shopNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "اسم السايبر الخاص بك", labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "رقم فودافون كاش لاستلام الأرباح", labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: instapayController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "حساب إنستا باي (Instapay ID)", labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, minimumSize: const Size(double.infinity, 45)),
                    onPressed: () {
                      setState(() {
                        AppData.shopName = shopNameController.text;
                        AppData.ownerPhone = phoneController.text;
                        AppData.ownerInstapay = instapayController.text;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ تم حفظ إعدادات السايبر بنجاح")));
                    },
                    child: const Text("حفظ الإعدادات", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("🔔 تنبيهات الحجوزات وإيصالات الدفع", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              height: 120,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFF1E1E2F), borderRadius: BorderRadius.circular(16)),
              child: AppData.adminNotifications.isEmpty
                  ? const Center(child: Text("لا توجد تنبيهات أو إيصالات جديدة", style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      itemCount: AppData.adminNotifications.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.receipt_long, color: Colors.greenAccent),
                          title: Text(AppData.adminNotifications[index], style: const TextStyle(color: Colors.white, fontSize: 13)),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.between,
              children: [
                const Text("🎮 أجهزتك (بلايستيشن / بي سي):", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: () => _showAddDeviceDialog(),
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
        title: const Text("إضافة جهاز جديد", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "اسم الجهاز (مثل: PS 3 أو PC 2)",
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

// 3. شاشة حجز الزبون
class CustomerBookingScreen extends StatefulWidget {
  const CustomerBookingScreen({super.key});

  @override
  State<CustomerBookingScreen> createState() => _CustomerBookingScreenState();
}

class _CustomerBookingScreenState extends State<CustomerBookingScreen> {
  DeviceModel? selectedDevice;
  double selectedHours = 1;
  String selectedPayment = "نقدي (كاش في المحل)";
  bool hasAttachedReceipt = false;

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
            const Text("🎮 اختر جهازاً للحجز:", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
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
            const Text("💳 اختر طريقة الدفع:", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
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
                "فودافون كاش (${AppData.ownerPhone})",
                "إنستا باي Instapay (${AppData.ownerInstapay})"
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
            
            if (!selectedPayment.contains("نقدي")) ...[
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purpleAccent),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedPayment.contains("فودافون")
                          ? "قم بالتحويل على رقم: ${AppData.ownerPhone}"
                          : "قم بالتحويل على حساب إنستا باي: ${AppData.ownerInstapay}",
                      style: const TextStyle(color: Colors.orangeAccent, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hasAttachedReceipt ? Colors.green : Colors.deepPurple,
                        minimumSize: const Size(double.infinity, 45),
                      ),
                      onPressed: () {
                        setState(() {
                          hasAttachedReceipt = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("📸 تم التقاط وإرفاق إيصال التحويل بنجاح!")),
                        );
                      },
                      icon: Icon(hasAttachedReceipt ? Icons.check_circle : Icons.camera_alt),
                      label: Text(
                        hasAttachedReceipt ? "تم إرفاق إيصال التحويل (معتمد 📷)" : "تصوير / رفع إيصال التحويل 📸",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],

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
                      if (!selectedPayment.contains("نقدي") && !hasAttachedReceipt) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("⚠️ برجاء تصوير أو إرفاق إيصال التحويل أولاً ليتمكن صاحب السايبر من مراجعته!")),
                        );
                        return;
                      }

                      setState(() {
                        selectedDevice!.isAvailable = false;
                      });

                      String receiptStatus = hasAttachedReceipt ? "مع إيصال مرفق 📸" : "بدون إيصال (كاش)";
                      AppData.adminNotifications.insert(
                        0,
                        "حجز جديد: (${selectedDevice!.name}) لمدة ${selectedHours.toInt()} ساعات | الدفع: $selectedPayment ($receiptStatus)",
                      );

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: const Color(0xFF1E1E2F),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          title: const Text("🎉 تم الحجز بنجاح!", style: TextStyle(color: Colors.white)),
                          content: Text(
                            "تم حجز ${selectedDevice!.name}\nالمدة: ${selectedHours.toInt()} ساعات\nطريقة الدفع: $selectedPayment\nالحالة: ${hasAttachedReceipt ? 'تم إرسال إيصال التحويل لصاحب السايبر 📸' : 'الدفع كاش في المحل'}",
                            style: const TextStyle(color: Colors.grey, fontSize: 14),
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
