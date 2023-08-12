import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:BackEyes/shared/components/component.dart';

import '../../services/users.dart';

File? imageFile;

class AddMembersPage extends StatefulWidget {
  const AddMembersPage({Key? key}) : super(key: key);

  @override
  _AddMembersPageState createState() => _AddMembersPageState();
}

class _AddMembersPageState extends State<AddMembersPage> {
  final _memberNameController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void _onPickGallery() {
    _pickImage(ImageSource.gallery);
  }

  void _onTakePicture() {
    _pickImage(ImageSource.camera);
  }

  @override
  void dispose() {
    _memberNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImageContainer(),
              const SizedBox(height: 30),
              TextFormField(
                controller: _memberNameController,
                decoration: InputDecoration(
                  labelText: 'Member name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the member name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveMember,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  backgroundColor: const Color(0xFF00101D),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer() {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageFile != null
              ? FileImage(imageFile!) as ImageProvider<Object>
              : const AssetImage('assets/p.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD9D9D9),
              ),
              child: IconButton(
                onPressed: _onPickGallery,
                icon: const Icon(Icons.photo_library),
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD9D9D9),
              ),
              child: IconButton(
                onPressed: _onTakePicture,
                icon: const Icon(Icons.camera_alt),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveMember() async {
    final url = '$localhost/BackEyes_v2/public/api/members'; // Replace with your API endpoint URL

    String? token = User.loggedInUser!.apiToken ;
    // Get the member name
    final memberName = _memberNameController.text;

    if (memberName.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please enter the member name'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    if (imageFile == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please select an image'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      // Create a new multipart request
      final request = http.MultipartRequest('POST', Uri.parse(url));

      // Set headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add fields to the request
      request.fields['member_name'] = memberName;

      // Add image file to the request
      request.files.add(await http.MultipartFile.fromPath('member_image', imageFile!.path));

      // Send the request and get the response
      final response = await request.send();

      // Check the response status code
      if (response.statusCode == 200) {
        // Success
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Member added successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    imageFile = null;
                    _memberNameController.clear();
                  });
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Handle error cases
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to add member'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle network errors or exceptions
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to add member. Error: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
