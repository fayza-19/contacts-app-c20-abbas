import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../core/colors_manger.dart';
import 'contacts.dart';

class AddContactSheet extends StatefulWidget {
  final Function(Contact) onAddContact;

  const AddContactSheet({
    super.key,
    required this.onAddContact,
  });

  @override
  State<AddContactSheet> createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<AddContactSheet> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  File? pickedImage;

  Future<void> pickImage() async {
    final XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (file != null) {
      setState(() {
        pickedImage = File(file.path);
      });
    }
  }

  void addContact() {
    if (nameCtrl.text.trim().isEmpty ||
        emailCtrl.text.trim().isEmpty ||
        phoneCtrl.text.trim().isEmpty) {
      return;
    }

    final contact = Contact(
      name: nameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      phone: phoneCtrl.text.trim(),
      image: pickedImage?.path ?? "",
    );

    widget.onAddContact(contact);
    Navigator.pop(context);
  }

  Widget buildTextField({
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: ColorsManager.white,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: ColorsManager.white,
            fontSize: 15,
          ),
          filled: true,
          fillColor: ColorsManager.bg,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 15,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: ColorsManager.white,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: ColorsManager.baige,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 18,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: 135,
                      height: 135,
                      decoration: BoxDecoration(
                        color: ColorsManager.bg,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: ColorsManager.white,
                          width: 1.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: pickedImage == null
                            ? Lottie.asset(
                          'assets/animation/image_picker.json',
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        )
                            : Image.file(
                          pickedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: nameCtrl,
                          builder: (context, value, child) {
                            return Text(
                              value.text.isEmpty
                                  ? "User Name"
                                  : value.text,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: ColorsManager.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.email_outlined,
                              color: ColorsManager.white,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: ValueListenableBuilder(
                                valueListenable: emailCtrl,
                                builder: (context, value, child) {
                                  return Text(
                                    value.text.isEmpty
                                        ? "example@email.com"
                                        : value.text,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: ColorsManager.white,
                                      fontSize: 12,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone_outlined,
                              color: ColorsManager.white,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: ValueListenableBuilder(
                                valueListenable: phoneCtrl,
                                builder: (context, value, child) {
                                  return Text(
                                    value.text.isEmpty
                                        ? "+200000000000"
                                        : value.text,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: ColorsManager.white,
                                      fontSize: 12,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              buildTextField(
                hint: "Enter User Name",
                controller: nameCtrl,
              ),
              buildTextField(
                hint: "Enter User Email",
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
              ),
              buildTextField(
                hint: "Enter User Phone",
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: addContact,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.baige,
                    foregroundColor: ColorsManager.bg,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Enter user",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}