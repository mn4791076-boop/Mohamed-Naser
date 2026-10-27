import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Cyber System',
    home: RoleSelectionScreen(),
  ));
}

// 🔐 كود التفعيل التجاري الخاص بك (لا يمكن لأي صاحب سايبر فتحه إلا به)
const String masterActivationCode = "Mohamed 200901281371307";

// نموذج بيانات الجهاز
class DeviceModel {
  String name;
  String type; // "بلايستيشن" أو "بي سي"
  bool isAvailable;

  DeviceModel({required this.name, required this.type, this.isAvailable = true});
}

// نموذج حساب صاحب السايبر
class ShopAccount {
  String phone;
  String password;
  String shopName;
  String instapay;
  List<DeviceModel> devices;
  List<String> notifications;

  ShopAccount({
    required this.phone,
    required this.password,
    required this.shopName,
    required this.instapay,
    required this.devices,
    required this.notifications,
  });
}

class AppData {
  // المحلات المسجلة في النظام
  static List<ShopAccount> registeredShops = [
    ShopAccount(
      phone: "01000000000",
      password: "123",
      shopName: "سايبر الألعاب المركزي",
      instapay: "cyber.central@instapay",
      devices: [
        DeviceModel(name: "PlayStation 5 - 1", type: "بلايستيشن", isAvailable: true),
        DeviceModel(name: "PC Gaming 1", type: "بي سي", isAvailable: true),
      ],
      notifications: [],
    )
  ];

  static ShopAccount? currentOwnerShop;
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
                  "نظام إدارة محلات الألعاب مع حماية بكود التفعيل",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                
                // زر دخول / تسجيل صاحب السايبر
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    _showOwnerAuthModal(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.admin_panel_settings, color: Colors.white),
                      SizedBox(width: 10),
                      Text("دخول / تفعيل حساب صاحب السايبر", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // زر دخول الزبون للحجز
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    side: const BorderSide(color: Colors.purpleAccent, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    _showCustomerSelectShopDialog(context);
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

  // نافذة مصادقة وتفعيل صاحب السايبر
  void _showOwnerAuthModal(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController shopNameController = TextEditingController();
    final TextEditingController activationController = TextEditingController();
    bool isRegistering = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateModal) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E2F),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            isRegistering ? "🔑 تفعيل وإنشاء حساب جديد" : "🔐 تسجيل دخول صاحب السايبر",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isRegistering) ...[
                  TextField(
                    controller: shopNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "اسم السايبر الخاص بك",
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: activationController,
                    style: const TextStyle(color: Colors.greenAccent),
                    decoration: const InputDecoration(
                      labelText: "كود تفعيل البرنامج (المشترى منك)",
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "رقم التليفون الشخصي",
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "كلمة السر",
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    setStateModal(() {
                      isRegistering = !isRegistering;
                    });
                  },
                  child: Text(
                    isRegistering ? "لديك حساب بالفعل؟ سجل دخول" : "مشترٍ جديد؟ فعّل حسابك الآن",
                    style: const TextStyle(color: Colors.purpleAccent, fontSize: 13),
                  ),
                ),
              ],
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
                String phone = phoneController.text.trim();
                String pass = passwordController.text.trim();

                if (phone.isEmpty || pass.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("❌ برجاء إدخال رقم التليفون وكلمة السر")),
                  );
                  return;
                }

                if (isRegistering) {
                  String shopName = shopNameController.text.trim();
                  String actCode = activationController.text.trim();

                  if (shopName.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("❌ برجاء إدخال اسم السايبر")),
                    );
                    return;
                  }

                  // 🛑 الشرط الأمني: التحقق من كود التفعيل الخاص بك
                  if (actCode != masterActivationCode) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("❌ كود التفعيل غير صحيح! تواصل مع المطور لشراء الكود.")),
                    );
                    return;
                  }

                  bool exists = AppData.registeredShops.any((shop) => shop.phone == phone);
                  if (exists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("⚠️ هذا الرقم مسجل مسبقاً، قم بتسجيل الدخول")),
                    );
                    return;
                  }

                  ShopAccount newShop = ShopAccount(
                    phone: phone,
                    password: pass,
                    shopName: shopName,
                    instapay: "$phone@instapay",
                    devices: [
                      DeviceModel(name: "PlayStation - 1", type: "بلايستيشن", isAvailable: true),
                    ],
                    notifications: [],
                  );
                  AppData.registeredShops.add(newShop);
                  AppData.currentOwnerShop = newShop;
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OwnerDashboardScreen()),
                  );
                } else {
                  try {
                    ShopAccount foundShop = AppData.registeredShops.firstWhere(
                      (shop) => shop.phone == phone && shop.password == pass,
                    );
                    AppData.currentOwnerShop = foundShop;
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OwnerDashboardScreen()),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("❌ رقم التليفون أو كلمة السر غير صحيحة!")),
                    );
                  }
                }
              },
              child: Text(isRegistering ? "تفعيل وحفظ" : "دخول", style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // نافذة اختيار السايبر للزبون
  void _showCustomerSelectShopDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("🏪 اختر السايبر للحجز", style: TextStyle(color: Colors.white)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: AppData.registeredShops.length,
            itemBuilder: (context, index) {
              ShopAccount shop = AppData.registeredShops[index];
              return Card(
                color: const Color(0xFF2E2E42),
                child: ListTile(
                  title: Text(shop.shopName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text("الهاتف: ${shop.phone}", style: const TextStyle(color: Colors.grey)),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.purpleAccent, size: 16),
                  onTap: () {
                    AppData.currentOwnerShop = shop;
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CustomerBookingScreen()),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// 2. لوحة تحكم صاحب السايبر
class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  late ShopAccount owner = AppData.currentOwnerShop!;
  late TextEditingController shopNameController = TextEditingController(text: owner.shopName);
  late TextEditingController phoneController = TextEditingController(text: owner.phone);
  late TextEditingController instapayController = TextEditingController(text: owner.instapay);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("إدارة: ${owner.shopName}", style: const TextStyle(color: Colors.white, fontSize: 16)),
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
                  const Text("⚙️ إعدادات السايبر وحسابات التحصيل", style: TextStyle(color: Colors.purpleAccent, fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: shopNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "اسم السايبر", labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "رقم فودافون كاش", labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: instapayController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "حساب إنستا باي", labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, minimumSize: const Size(double.infinity, 42)),
                    onPressed: () {
                      setState(() {
                        owner.shopName = shopNameController.text;
                        owner.phone = phoneController.text;
                        owner.instapay = instapayController.text;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ تم الحفظ بنجاح")));
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
              child: owner.notifications.isEmpty
                  ? const Center(child: Text("لا توجد تنبيهات جديدة", style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      itemCount: owner.notifications.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.receipt_long, color: Colors.greenAccent),
                          title: Text(owner.notifications[index], style: const TextStyle(color: Colors.white, fontSize: 13)),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.between,
              children: [
                const Text("🎮 أجهزة السايبر:", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: () => _showAddDeviceDialog(),
                  icon: const Icon(Icons.add, color: Colors.white, size: 18),
                  label: const Text("إضافة جهاز", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: owner.devices.length,
              itemBuilder: (context, index) {
                final device = owner.devices[index];
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
                              owner.devices.removeAt(index);
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
        title: const Text("إضافة جهاز جديد", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "اسم الجهاز (مثل: PS 4)",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: type,
              dropdownColor: const Color(0xFF1E1E2F),
              style: const TextStyle(color: Colors.white),
              items: ["بلايستيشن", "بي سي"].map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
              onChanged: (val) => type = val!,
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
                  owner.devices.add(DeviceModel(name: nameController.text, type: type, isAvailable: true));
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
  late ShopAccount shop = AppData.currentOwnerShop!;
  DeviceModel? selectedDevice;
  double selectedHours = 1;
  String selectedPayment = "نقدي (كاش)";
  bool hasAttachedReceipt = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(shop.shopName, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🎮 الحجز في: ${shop.shopName}", style: const TextStyle(color: Colors.purpleAccent, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            const Text("اختر جهازاً للحجز:", style: TextStyle(color: Colors.white, fontSize: 15)),
            const SizedBox(height: 10),
            SizedBox(
              height: 170,
              child: ListView.builder(
                itemCount: shop.devices.length,
                itemBuilder: (context, index) {
                  final device = shop.devices[index];
                  bool isSelected = selectedDevice == device;
                  return Card(
                    color: isSelected ? Colors.purple.withOpacity(0.4) : const Color(0xFF1E1E2F),
                    child: ListTile(
                      leading: Icon(
                        device.type == "بلايستيشن" ? Icons.sports_esports : Icons.computer,
                        color: device.isAvailable ? Colors.greenAccent : Colors.redAccent,
                      ),
                      title: Text(device.name, style: const TextStyle(color: Colors.white)),
                      subtitle: Text("النوع: ${device.type}", style: const TextStyle(color: Colors.grey)),
                      trailing: Text(
                        device.isAvailable ? "متاح 🟢" : "مشغول 🔴",
                        style: TextStyle(color: device.isAvailable ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold),
                      ),
                      onTap: device.isAvailable
                          ? () => setState(() => selectedDevice = device)
                          : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            Text("⏳ عدد الساعات: ${selectedHours.toInt()}", style: const TextStyle(color: Colors.white)),
            Slider(
              value: selectedHours,
              min: 1,
              max: 10,
              divisions: 9,
              activeColor: Colors.purple,
              onChanged: (val) => setState(() => selectedHours = val),
            ),
            const SizedBox(height: 10),
            const Text("💳 طريقة الدفع:", style: TextStyle(color: Colors.white, fontSize: 15)),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: selectedPayment,
              dropdownColor: const Color(0xFF1E1E2F),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E1E2F),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              items: [
                "نقدي (كاش في المحل)",
                "فودافون كاش (${shop.phone})",
                "إنستا باي (${shop.instapay})"
              ].map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
              onChanged: (val) => setState(() => selectedPayment = val!),
            ),
            if (!selectedPayment.contains("نقدي")) ...[
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: hasAttachedReceipt ? Colors.green : Colors.deepPurple,
                  minimumSize: const Size(double.infinity, 45),
                ),
                onPressed: () {
                  setState(() => hasAttachedReceipt = true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("📸 تم التقاط وإرفاق إيصال التحويل بنجاح!")),
                  );
                },
                icon: Icon(hasAttachedReceipt ? Icons.check_circle : Icons.camera_alt),
                label: Text(hasAttachedReceipt ? "تم إرفاق إيصال التحويل 📷" : "تصوير / رفع إيصال التحويل 📸"),
              ),
            ],
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: selectedDevice == null
                  ? null
                  : () {
                      if (!selectedPayment.contains("نقدي") && !hasAttachedReceipt) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("⚠️ برجاء إرفاق الإيصال أولاً")),
                        );
                        return;
                      }

                      setState(() {
                        selectedDevice!.isAvailable = false;
                      });

                      shop.notifications.insert(
                        0,
                        "حجز جديد: (${selectedDevice!.name}) لمدة ${selectedHours.toInt()} ساعات | الدفع: $selectedPayment",
                      );

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: const Color(0xFF1E1E2F),
                          title: const Text("🎉 تم الحجز بنجاح!", style: TextStyle(color: Colors.white)),
                          content: Text(
                            "تم حجز الجهاز بنجاح في ${shop.shopName}",
                            style: const TextStyle(color: Colors.grey),
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
              child: const Text("تأكيد الحجز الآن", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
