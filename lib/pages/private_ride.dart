import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:ulimo/pages/thank_you_page.dart';
import 'package:connectivity/connectivity.dart';

class PrivateRidePage extends StatefulWidget {
  const PrivateRidePage({super.key});

  @override
  _PrivateRidePageState createState() => _PrivateRidePageState();
}

class _PrivateRidePageState extends State<PrivateRidePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _pickupAddressController = TextEditingController();
  final _destinationController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passengersController = TextEditingController();
  final _referralCodeController = TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _pickupTime = TimeOfDay.now();
  TimeOfDay _returnTime = TimeOfDay.now();
  bool _isLoading = false;

  Future<bool> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!await checkConnectivity()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No network connection'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Send data to Firebase
    final rideDetails = {
      'first_name': _firstNameController.text.trim(),
      'last_name': _lastNameController.text.trim(),
      'date': DateFormat('yyyy-MM-dd').format(_date),
      'pickup_time': _pickupTime.format(context),
      'return_time': _returnTime.format(context),
      'pickup_address': _pickupAddressController.text.trim(),
      'destination': _destinationController.text.trim(),
      'phone_number': _phoneNumberController.text.trim(),
      'email': _emailController.text.trim(),
      'passenger': _passengersController.text.trim(),
      'referral_code': _referralCodeController.text.trim(),
    };

    final databaseRef = FirebaseDatabase.instance.ref('privateRide');
    await databaseRef.push().set(rideDetails);

    setState(() {
      _isLoading = false;
    });

    // Show success message and reset form
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Private ride details submitted successfully'),
        backgroundColor: Colors.green,
      ),
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _formKey.currentState!.reset();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ThankYouPage(),
        ),
      );
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<void> _selectPickupTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _pickupTime,
    );
    if (picked != null && picked != _pickupTime) {
      setState(() {
        _pickupTime = picked;
      });
    }
  }

  Future<void> _selectReturnTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _returnTime,
    );
    if (picked != null && picked != _returnTime) {
      setState(() {
        _returnTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Private Ride'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'First Name'),
            controller: _firstNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Last Name'),
            controller: _lastNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Date'),
                keyboardType: TextInputType.datetime,
                controller: TextEditingController(
                    text: DateFormat('dd-MM-yyyy').format(_date)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () => _selectPickupTime(context),
            child: AbsorbPointer(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Pickup Time'),
                keyboardType: TextInputType.datetime,
                controller:
                    TextEditingController(text: _pickupTime.format(context)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the pickup time';
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () => _selectReturnTime(context),
            child: AbsorbPointer(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Return Time'),
                keyboardType: TextInputType.datetime,
                controller:
                    TextEditingController(text: _returnTime.format(context)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the return time';
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Pickup Address'),
            controller: _pickupAddressController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the pickup address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Destination'),
            controller: _destinationController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the destination';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Phone Number'),
            keyboardType: TextInputType.phone,
            controller: _phoneNumberController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Passengers'),
            keyboardType: TextInputType.number,
            controller: _passengersController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the number of passengers';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Referral Code'),
            controller: _referralCodeController,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _isLoading ? null : _submitForm,
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
