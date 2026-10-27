import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Cyber System',
    home: RoleSelectionScreen(),
  ));
}

// 🔐 كود التفعيل التجاري الخاص بك
const String masterActivationCode = "Mohamed 200901281371307";

// نموذج بيانات الجهاز
class DeviceModel {
  String name;
  String type; // "بلايستيشن" أو "بي سي"
  bool isAvailable;
  String? currentCustomer;

  DeviceModel({
    required this.name,
    required this.type,
    this.isAvailable = true,
    this.currentCustomer,
  });
}

// نموذج حساب صاحب السايبر
class ShopAccount {
  String phone;
  String password;
  String shopName;
  String instapay;
  String vodafoneCash;
  List<DeviceModel> devices;
  List<BookingNotification> notifications;

  ShopAccount({
    required this.phone,
    required this.password,
    required this.shopName,
    required this.instapay,
    required this.vodafoneCash,
    required this.devices,
    required this.notifications,
  });
}

// نموذج الإشعارات والحجوزات
class BookingNotification {
  String id;
  String customerName;
  String customerSenderInfo; // رقم التليفون أو حساب إنستا باي للزبون
  String deviceName;
  String paymentMethod; // "نقدي (كاش)", "فودافون كاش", "إنستا باي"
  double amount;
  bool isPaid;

  BookingNotification({
    required this.id,
    required this.customerName,
    required this.customerSenderInfo,
    required this.deviceName,
    required this.paymentMethod,
    required this.amount,
    this.isPaid = false,
  });
}

class AppData {
  static List<ShopAccount> registeredShops = [
    ShopAccount(
      phone: "01000000000",
      password: "123",
      shopName: "سايبر الألعاب المركزي",
      instapay: "cyber.central@instapay",
      vodafoneCash: "01000000000",
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
                  "Cyber System الاحترافي",
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "إدارة شاملة لمحلات الألعاب والبلايستيشن والـ PC",
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
                  onPressed: () => _showOwnerAuthModal(context),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.admin_panel_settings, color: Colors.white),
                      SizedBox(width: 10),
                      Text("دخول / تسجيل صاحب السايبر", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
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
                  onPressed: () => _showCustomerSelectShopDialog(context),
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
            isRegistering ? "🔑 تفعيل وإنشاء حساب سايبر جديد" : "🔐 تسجيل دخول صاحب السايبر",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isRegistering) ...[
                  TextField(
                    controller: shopNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: "اسم السايبر", labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: activationController,
                    style: const TextStyle(color: Colors.greenAccent),
                    decoration: const InputDecoration(labelText: "كود التفعيل التجاري", labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(height: 10),
                ],
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: "رقم التليفون", labelStyle: TextStyle(color: Colors.grey)),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: "كلمة السر", labelStyle: TextStyle(color: Colors.grey)),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () => setStateModal(() => isRegistering = !isRegistering),
                  child: Text(
                    isRegistering ? "لديك حساب؟ سجل دخول" : "مشترٍ جديد؟ فعّل حسابك الآن",
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
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("❌ برجاء إدخال البيانات كاملة")));
                  return;
                }

                if (isRegistering) {
                  String shopName = shopNameController.text.trim();
                  String actCode = activationController.text.trim();

                  if (shopName.isEmpty || actCode.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("❌ برجاء إدخال اسم السايبر وكود التفعيل")));
                    return;
                  }

                  if (actCode != masterActivationCode) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("❌ كود التفعيل غير صحيح!")));
                    return;
                  }

                  if (AppData.registeredShops.any((s) => s.phone == phone)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("⚠️ هذا الرقم مسجل مسبقاً")));
                    return;
                  }

                  ShopAccount newShop = ShopAccount(
                    phone: phone,
                    password: pass,
                    shopName: shopName,
                    instapay: "$phone@instapay",
                    vodafoneCash: phone,
                    devices: [
                      DeviceModel(name: "PlayStation - 1", type: "بلايستيشن", isAvailable: true),
                    ],
                    notifications: [],
                  );
                  AppData.registeredShops.add(newShop);
                  AppData.currentOwnerShop = newShop;
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const OwnerDashboardScreen()));
                } else {
                  try {
                    ShopAccount found = AppData.registeredShops.firstWhere((s) => s.phone == phone && s.password == pass);
                    AppData.currentOwnerShop = found;
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OwnerDashboardScreen()));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("❌ بيانات الدخول غير صحيحة")));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerBookingScreen()));
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
  late TextEditingController phoneController = TextEditingController(text: owner.vodafoneCash);
  late TextEditingController instapayController = TextEditingController(text: owner.instapay);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("لوحة تحكم: ${owner.shopName}", style: const TextStyle(color: Colors.white, fontSize: 16)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // إعدادات السايبر
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
                  const Text("⚙️ إعدادات السايبر وطرق التحصيل", style: TextStyle(color: Colors.purpleAccent, fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextField(controller: shopNameController, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "اسم السايبر")),
                  TextField(controller: phoneController, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "فودافون كاش")),
                  TextField(controller: instapayController, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "إنستا باي")),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, minimumSize: const Size(double.infinity, 42)),
                    onPressed: () {
                      setState(() {
                        owner.shopName = shopNameController.text;
                        owner.vodafoneCash = phoneController.text;
                        owner.instapay = instapayController.text;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ تم حفظ الإعدادات بنجاح")));
                    },
                    child: const Text("حفظ الإعدادات", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // إشعارات الحجوزات وتأكيد الدفع
            const Text("🔔 الحجوزات والمدفوعات الواردة", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              height: 180,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFF1E1E2F), borderRadius: BorderRadius.circular(16)),
              child: owner.notifications.isEmpty
                  ? const Center(child: Text("لا توجد حجوزات جديدة", style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      itemCount: owner.notifications.length,
                      itemBuilder: (context, index) {
                        final notif = owner.notifications[index];
                        return Card(
                          color: const Color(0xFF2E2E42),
                          child: ListTile(
                            title: Text("${notif.customerName} - ${notif.deviceName}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("الطريقة: ${notif.paymentMethod} | القيمة: ${notif.amount} ج.م", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                Text("رقم/حساب التحويل: ${notif.customerSenderInfo}", style: const TextStyle(color: Colors.greenAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: notif.isPaid ? Colors.green : Colors.orange,
                                minimumSize: const Size(70, 30),
                              ),
                              onPressed: () {
                                setState(() {
                                  notif.isPaid = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ تم تأكيد الدفع بنجاح")));
                              },
                              child: Text(notif.isPaid ? "تم الدفع" : "تأكيد الدفع", style: const TextStyle(color: Colors.white, fontSize: 11)),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            // إدارة الأجهزة
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
                    subtitle: Text(
                      device.isAvailable ? "متاح للحجز ✅ (${device.type})" : "مشغول الآن بـ (${device.currentCustomer ?? 'زبون'}) [${device.type}]",
                      style: TextStyle(color: device.isAvailable ? Colors.greenAccent : Colors.orangeAccent),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!device.isAvailable)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                device.isAvailable = true;
                                device.currentCustomer = null;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("🔄 تم تفريغ الجهاز وأصبح متاحاً تلقائياً")));
                            },
                            child: const Text("تفريغ", style: TextStyle(color: Colors.greenAccent, fontSize: 11)),
                          ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
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
      builder: (context) => StatefulBuilder(
        builder: (context, setStateModal) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E2F),
          title: const Text("➕ إضافة جهاز جديد", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "اسم الجهاز (مثال: PS5 - 2 أو PC - 2)")),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: type,
                dropdownColor: const Color(0xFF2E2E42),
                style: const TextStyle(color: Colors.white),
                items: const [
                  DropdownMenuItem(value: "بلايستيشن", child: Text("بلايستيشن")),
                  DropdownMenuItem(value: "بي سي", child: Text("بي سي (PC)")),
                ],
                onChanged: (val) => setStateModal(() => type = val!),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("إلغاء", style: TextStyle(color: Colors.grey))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    owner.devices.add(DeviceModel(name: nameController.text.trim(), type: type, isAvailable: true));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("إضافة", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
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
  final ShopAccount shop = AppData.currentOwnerShop!;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController senderInfoController = TextEditingController();
  DeviceModel? selectedDevice;
  String paymentMethod = "نقدي (كاش)";
  double pricePerHour = 40.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("حجز في: ${shop.shopName}", style: const TextStyle(color: Colors.white, fontSize: 16)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("👤 بيانات الزبون", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "اسمك الثلاثي", labelStyle: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 20),
            const Text("🎮 اختر جهازاً متاحاً:", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            shop.devices.isEmpty
                ? const Text("لا توجد أجهزة مضافة حالياً", style: TextStyle(color: Colors.grey))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: shop.devices.length,
                    itemBuilder: (context, index) {
                      final device = shop.devices[index];
                      bool isSelected = selectedDevice == device;
                      return Card(
                        color: isSelected ? Colors.purple.withOpacity(0.3) : const Color(0xFF1E1E2F),
                        child: ListTile(
                          leading: Icon(device.type == "بلايستيشن" ? Icons.sports_esports : Icons.computer, color: device.isAvailable ? Colors.greenAccent : Colors.grey),
                          title: Text(device.name, style: const TextStyle(color: Colors.white)),
                          subtitle: Text(device.isAvailable ? "متاح [${device.type}] (السعر: $pricePerHour ج.م/ساعة)" : "مشغول حالياً [${device.type}]", style: TextStyle(color: device.isAvailable ? Colors.greenAccent : Colors.redAccent)),
                          trailing: device.isAvailable
                              ? Radio<DeviceModel>(
                                  value: device,
                                  groupValue: selectedDevice,
                                  activeColor: Colors.purpleAccent,
                                  onChanged: (val) => setState(() => selectedDevice = val),
                                )
                              : const Text("محجوز", style: TextStyle(color: Colors.grey)),
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 20),
            const Text("💳 طريقة الدفع", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: paymentMethod,
              dropdownColor: const Color(0xFF2E2E42),
              style: const TextStyle(color: Colors.white),
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: "نقدي (كاش)", child: Text("نقدي (كاش في الكاونتر)")),
                DropdownMenuItem(value: "فودافون كاش", child: Text("فودافون كاش")),
                DropdownMenuItem(value: "إنستا باي", child: Text("إنستا باي (Instapay)")),
              ],
              onChanged: (val) => setState(() => paymentMethod = val!),
            ),
            if (paymentMethod == "فودافون كاش") ...[
              Text("رقم التحويل للسايبر: ${shop.vodafoneCash}", style: const TextStyle(color: Colors.purpleAccent, fontSize: 12)),
              const SizedBox(height: 8),
              TextField(
                controller: senderInfoController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: "رقم هاتفك المحول منه (فودافون كاش)", labelStyle: TextStyle(color: Colors.grey)),
              ),
            ],
            if (paymentMethod == "إنستا باي") ...[
              Text("عنوان التحويل للسايبر: ${shop.instapay}", style: const TextStyle(color: Colors.purpleAccent, fontSize: 12)),
              const SizedBox(height: 8),
              TextField(
                controller: senderInfoController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: "اسمك أو حسابك المحول منه (إنستا باي)", labelStyle: TextStyle(color: Colors.grey)),
              ),
            ],
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                if (nameController.text.trim().isEmpty || selectedDevice == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("❌ برجاء إدخال الاسم واختيار جهاز متاح")));
                  return;
                }

                if (paymentMethod != "نقدي (كاش)" && senderInfoController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("❌ برجاء إدخال رقم هاتفك أو حسابك المحول منه")));
                  return;
                }

                String senderInfo = paymentMethod == "نقدي (كاش)" ? "الدفع عند الكاونتر (كاش)" : senderInfoController.text.trim();

                setState(() {
                  selectedDevice!.isAvailable = false;
                  selectedDevice!.currentCustomer = nameController.text.trim();
                  shop.notifications.add(BookingNotification(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    customerName: nameController.text.trim(),
                    customerSenderInfo: senderInfo,
                    deviceName: selectedDevice!.name,
                    paymentMethod: paymentMethod,
                    amount: pricePerHour,
                  ));
                });

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xFF1E1E2F),
                    title: const Text("✅ تم الحجز بنجاح", style: TextStyle(color: Colors.greenAccent)),
                    content: Text("تم حجز ${selectedDevice!.name} بنجاح. ${paymentMethod == 'نقدي (كاش)' ? 'يرجى التوجه للكاونتر للدفع نقداً.' : 'تم إرسال رقم التحويل لصاحب السايبر.'}", style: const TextStyle(color: Colors.white)),
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
              child: const Text("تأكيد وحجز الجهاز", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
