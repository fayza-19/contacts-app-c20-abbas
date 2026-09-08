import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../core/colors_manger.dart';
import 'contacts/contacts.dart';
import 'contacts/contactscard.dart';
import 'contacts/contactssheet.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final List<Contact> contacts = [];

  void addContact(Contact contact) {
    if (contacts.length < 6) {
      setState(() {
        contacts.add(contact);
      });
    }
  }

  void removeContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  void removeLastContact() {
    if (contacts.isNotEmpty) {
      setState(() {
        contacts.removeLast();
      });
    }
  }

  void openAddSheet() {
    if (contacts.length >= 6) {
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorsManager.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return AddContactSheet(
          onAddContact: addContact,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/logoo.png",
                height: 70,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: contacts.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/animation/empty_list.json',
                        width: 220,
                        repeat: true,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "There is No Contacts Added Here",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.baige,
                        ),
                      ),
                    ],
                  ),
                )
                    : GridView.builder(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                  ),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.55,
                  ),
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return ContactCard(
                      contact: contacts[index],
                      onDelete: () {
                        removeContact(index);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: contacts.length == 6
          ? FloatingActionButton(
        onPressed: removeLastContact,
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      )
          : FloatingActionButton(
        onPressed: openAddSheet,
        backgroundColor: ColorsManager.baige,
        child: const Icon(
          Icons.add,
          color: ColorsManager.bg,
        ),
      ),
    );
  }
}