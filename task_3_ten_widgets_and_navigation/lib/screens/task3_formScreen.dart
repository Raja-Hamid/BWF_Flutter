import 'package:flutter/material.dart';
import 'package:task_3_ten_widgets_and_navigation/screens/task3_summaryScreen.dart';

class Task3Screen extends StatefulWidget {
  const Task3Screen({super.key});

  @override
  State<Task3Screen> createState() => _Task3ScreenState();
}

class _Task3ScreenState extends State<Task3Screen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  bool termsAccepted = false;
  String? selectedCountry = 'Pakistan';
  String? gender;
  double age = 1.0;
  bool notificationsEnabled = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if(picked!= null){
      setState(() {
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

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
      body: Stack(
        children: [
          Image.asset(
            'assets/images/White.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Name';
                          }
                          return null;
                        },
                        controller: nameController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your Email';
                          }
                          return null;
                        },
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: addressController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Gender'),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: const Text('Male'),
                              leading: Radio<String>(
                                value: 'Male',
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text('Female'),
                              leading: Radio<String>(
                                value: 'Female',
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Country'),
                      DropdownButtonFormField<String>(
                        value: selectedCountry,
                        items: ['Pakistan', 'USA', 'Australia', 'Other']
                            .map((country) => DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCountry = value;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Select your country';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: dateController,
                        decoration: const InputDecoration(
                          labelText: 'Date of Birth',
                          border: OutlineInputBorder(),
                        ),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          await _selectDate(context);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Age'),
                      Slider(
                        value: age,
                        min: 1,
                        max: 100,
                        divisions: 99,
                        label: age.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            age = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SwitchListTile(
                        title: const Text('Enable Notifications'),
                        value: notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            notificationsEnabled = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CheckboxListTile(
                        title: const Text('I accept the terms and conditions'),
                        value: termsAccepted,
                        onChanged: (value) {
                          setState(() {
                            termsAccepted = value!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SummaryScreen(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    address: addressController.text,
                                    dateOfBirth: dateController.text,
                                    gender: gender,
                                    country: selectedCountry!,
                                    age: age,
                                    notificationsEnabled: notificationsEnabled,
                                    termsAccepted: termsAccepted,
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
