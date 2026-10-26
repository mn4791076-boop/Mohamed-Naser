import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Cyber System',
    home: RoleSelectionScreen(),
  ));
}

const String ownerSecretKey = "mohamed202601281371307";

// 1. شاشة اختيار البداية (صاحب السيرفر أو الزبون)
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
              const Text(
                "🎮 Cyber System 🎮",
                style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "اختر طريقة الدخول للنظام",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 40),
              
              // زر دخول صاحب السيرفر (يطلب كود سري)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  _showOwnerLoginDialog(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.admin_panel_settings, color: Colors.white),
                    SizedBox(width: 10),
                    Text("دخول صاحب السيرفر (بكود)", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // زر دخول الزبون (يدخل مباشرة بدون كود)
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  side: const BorderSide(color: Colors.purple, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                    Icon(Icons.person, color: Colors.purpleAccent),
                    SizedBox(width: 10),
                    Text("دخول الزبون (حجز الأجهزة)", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // نافذة إدخال الكود السري لصاحب السيرفر
  void _showOwnerLoginDialog(BuildContext context) {
    final TextEditingController codeController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2F),
        title: const Text("كود صاحب السيرفر", style: TextStyle(color: Colors.white)),
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
                  const SnackBar(content: Text("الكود السري غير صحيح!")),
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

// 2. لوحة تحكم صاحب السيرفر
class OwnerDashboardScreen extends StatelessWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("لوحة تحكم صاحب السيرفر", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("مرحباً بك يا صاحب السيرفر 👑", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Card(
              color: Color(0xFF1E1E2F),
              child: ListTile(
                leading: Icon(Icons.analytics, color: Colors.purpleAccent),
                title: Text("إدارة الحجوزات والأجهزة", style: TextStyle(color: Colors.white)),
                subtitle: Text("جميع أجهزة البلايستيشن والبي سي جاهزة للعمل.", style: TextStyle(color: Colors.grey)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. شاشة حجز الزبون (بلايستيشن / بي سي / ساعات / دفع)
class CustomerBookingScreen extends StatefulWidget {
  const CustomerBookingScreen({super.key});

  @override
  State<CustomerBookingScreen> createState() => _CustomerBookingScreenState();
}

class _CustomerBookingScreenState extends State<CustomerBookingScreen> {
  String selectedDevice = "بلايستيشن (PlayStation)";
  double selectedHours = 1;
  String selectedPayment = "نقدي (كاش)";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("حجز الأجهزة - Cyber System", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("اختر الجهاز المطلـوب:", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text("بلايستيشن 🎮"),
                    selected: selectedDevice == "بلايستيشن (PlayStation)",
                    selectedColor: Colors.purple,
                    backgroundColor: const Color(0xFF1E1E2F),
                    labelStyle: TextStyle(color: selectedDevice == "بلايستيشن (PlayStation)" ? Colors.white : Colors.grey),
                    onSelected: (bool selected) {
                      setState(() {
                        selectedDevice = "بلايستيشن (PlayStation)";
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ChoiceChip(
                    label: const Text("كمبيوتر بي سي 💻"),
                    selected: selectedDevice == "كمبيوتر (PC)",
                    selectedColor: Colors.purple,
                    backgroundColor: const Color(0xFF1E1E2F),
                    labelStyle: TextStyle(color: selectedDevice == "كمبيوتر (PC)" ? Colors.white : Colors.grey),
                    onSelected: (bool selected) {
                      setState(() {
                        selectedDevice = "كمبيوتر (PC)";
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            
            const Text("حدد عدد الساعات:", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
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
                "${selectedHours.toInt()} ساعات",
                style: const TextStyle(color: Colors.purpleAccent, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 25),

            const Text("طريقة الدفع:", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
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
              items: ["نقدي (كاش)", "فودافون كاش", "بطاقة ائتمان"].map((String value) {
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
            const SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xFF1E1E2F),
                    title: const Text("تم الحجز بنجاح! 🚀", style: TextStyle(color: Colors.white)),
                    content: Text(
                      "الجهاز: $selectedDevice\nالساعات: ${selectedHours.toInt()} ساعات\nطريقة الدفع: $selectedPayment",
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("حسناً", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("تأكيد الحجز", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
