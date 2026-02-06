import 'package:flutter/material.dart';

class ClientProfilePage extends StatelessWidget {
  const ClientProfilePage({super.key});


  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF5F6FF);
    const primary = Color(0xFF5B6CFF);

    return Scaffold(
      backgroundColor: bg,

      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.black),
          ),
        ],
      ),

      // ✅ المحتوى بيتحرك لوحده والبار ثابت تحت
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 90),
        child: Column(
          children: [
            // Profile Picture
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Profile Picture",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),

                  // ✅ دائرة وجواها لوجو شخص
                  Container(
                    width: 86,
                    height: 86,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primary.withOpacity(.12),
                      border: Border.all(
                        color: primary.withOpacity(.30),
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person_rounded,
                        color: primary,
                        size: 44,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primary,
                      side: const BorderSide(color: primary, width: 1.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Change Profile Photo",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            const _SectionCard(
              title: "Personal Details",
              fields: [
                _Field(label: "Name", value: "Jane Doe"),
                _Field(label: "Date of Birth", value: "1990-05-15"),
              ],
            ),

            const SizedBox(height: 14),

            _SectionCard(
              title: "Contact Information",
              trailingButton: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: primary,
                  side: const BorderSide(color: primary, width: 1.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Change Email",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              fields: const [
                _Field(label: "Email", value: "jane.doe@example.com"),
                _Field(label: "Phone Number", value: "+1 555-123-4567"),
              ],
            ),

            const SizedBox(height: 14),

            const _SectionCard(
              title: "Address",
              fields: [
                _Field(label: "Street Address", value: "123 Care Street"),
                _Field(label: "City", value: "Gentle City"),
              ],
              gridFields: [
                _Field(label: "State", value: "GA"),
                _Field(label: "ZIP Code", value: "12345"),
              ],
            ),
          ],
        ),
      ),

      // ✅ ثابت تحت الشاشة
      bottomNavigationBar: const _BottomBar(),
    );
  }
}

// ===================== Components =====================

class _SectionCard extends StatelessWidget {
  final String title;
  final List<_Field> fields;
  final List<_Field>? gridFields;
  final Widget? trailingButton;

  const _SectionCard({
    required this.title,
    required this.fields,
    this.gridFields,
    this.trailingButton,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF5B6CFF);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: primary),
              ),
            ],
          ),
          const SizedBox(height: 6),

          ...fields
              .map(
                (f) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: f,
                ),
              )
              .toList(),

          if (trailingButton != null) ...[
            const SizedBox(height: 4),
            Align(alignment: Alignment.centerRight, child: trailingButton!),
          ],

          if (gridFields != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: gridFields![0]),
                const SizedBox(width: 10),
                Expanded(child: gridFields![1]),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String value;

  const _Field({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6E7280),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class _BottomBar extends StatefulWidget {
  const _BottomBar();

  @override
  State<_BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<_BottomBar> {
  int index = 2; // Profile selected

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF5B6CFF);

    return Container(
      height: 74,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 18,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: primary,
        unselectedItemColor: const Color(0xFF9AA0AF),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_outlined),
            label: "Cards",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: "Requests",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
