import 'package:flutter/material.dart';

class BuildDropdownButton extends StatefulWidget {
  final String selectedAccountType;
  final List<String> accountTypes;
  final String label;
  const BuildDropdownButton(
      {super.key,
      required this.selectedAccountType,
      required this.accountTypes,
      required this.label});

  @override
  State<BuildDropdownButton> createState() => _BuildDropdownButtonState();
}

class _BuildDropdownButtonState extends State<BuildDropdownButton> {
  late String selectedAccountType;

  @override
  void initState() {
    super.initState();
    selectedAccountType = widget.selectedAccountType;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          value: selectedAccountType,
          items: widget.accountTypes.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Text(type),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedAccountType = value!;
            });
          },
        ),
      ],
    );
  }
}
