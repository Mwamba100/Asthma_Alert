import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController medicalLicenseController = TextEditingController();
  final TextEditingController practiceNameController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String selectedRole = 'Patient'; // Default role selection
  String gender = 'Male'; // Default gender selection

  Future<void> signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Firebase authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .createUser WithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());

        // Get FCM token
        String? token = await FirebaseMessaging.instance.getToken();

        // Prepare user data
        Map<String, dynamic> userData = {
          'email': emailController.text.trim(),
          'fullName': fullNameController.text.trim(),
          'phone': phoneController.text.trim(),
          'dob': dobController.text.trim(),
          'gender': gender,
          'role': selectedRole,
          'fcmToken': token,
        };

        if (selectedRole == 'Health Provider') {
          userData.addAll({
            'medicalLicense': medicalLicenseController.text,
            'practiceName': practiceNameController.text,
            'specialization': specializationController.text,
          });
        }

        // Save user data to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userData);

        // Optionally, you can trigger the AuthProvider signup method if needed
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.signup(userData);

        // Navigate to home screen
        Navigator.pushReplacementNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        String message = 'An error occurred. Please try again.';
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'An account already exists for that email.';
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An unexpected error occurred.')));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: fullNameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+ ').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                if (selectedRole == 'Patient')
                  Column(
                    children: [
                      TextFormField(
                        controller: dobController,
                        decoration: const InputDecoration(labelText: 'Date of Birth'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your date of birth';
                          }
                          return null;
                        },
                      ),
                      DropdownButton<String>(
                        value: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                        items: ['Male', 'Female', 'Other'].map((gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                if (selectedRole == 'Health Provider')
                  Column(
                    children: [
                      TextFormField(
                        controller: medicalLicenseController,
                        decoration: const InputDecoration(labelText: 'Medical License Number'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your medical license number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: practiceNameController,
                        decoration: const InputDecoration(labelText: 'Practice Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your practice name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: specializationController,
                        decoration: const InputDecoration(labelText: 'Specialization'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your specialization';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                DropdownButton<String>(
                  value: selectedRole,
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                  items: ['Patient', 'Health Provider'].map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: signup,
                  child: const Text('Sign Up'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Already have an account? Login'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'By signing up, you agree to our Terms of Service and Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}