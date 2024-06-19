import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  final String name;
  final String email;
  final String password;
  final String address;
  final String dateOfBirth;
  final String? gender;
  final String country;
  final double age;
  final bool notificationsEnabled;
  final bool termsAccepted;

  const SummaryScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.dateOfBirth,
    required this.gender,
    required this.country,
    required this.age,
    required this.notificationsEnabled,
    required this.termsAccepted,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'T A S K - 3',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Card( // Add a Card for visual separation
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: $name',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text('Email: $email', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 15),
                Text('Password: $password', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 15),
                Text('Address: $address', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 15),
                Text('Date of Birth: $dateOfBirth', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 15),
                Text('Gender: $gender', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 15),
                Text('Country: $country', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 15),
                Text('Age: ${age.round()}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 15),
                Text(
                  'Notifications Enabled: ${notificationsEnabled ? 'Yes' : 'No'}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 15),
                Text(
                  'Terms Accepted: ${termsAccepted ? 'Yes' : 'No'}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}