import 'dart:io';

import 'package:provider/provider.dart';
import 'package:silesra/Dataprovider/BaseServiceProvider.dart';
import 'package:silesra/Dataprovider/ImageUploadutility.dart';
import 'package:silesra/Dataprovider/Models.dart';
import 'package:silesra/Dataprovider/listing_provider.dart';
import 'package:silesra/theme/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
// import 'package:newone/UI/theme.dart';
import 'package:silesra/config/settings.dart';

class AddingHousePages extends StatefulWidget {
  const AddingHousePages({super.key});

  @override
  State<AddingHousePages> createState() => _AddingHousePagesState();
}

class _AddingHousePagesState extends State<AddingHousePages> {
  final houseService = ListingProvider().houseService;
  bool isUploading = false;
  final _formKey = GlobalKey<FormState>();
  String? saleOrRent;
  String? propertyType;
  int? bedrooms;
  int? bathrooms;
  double? price;
  double? squareMeters;
  String? description;
  String? selectedCity;
  String? selectedBank;
  File? paymentScreenshot;
  int currentStep = 0;
  List<String> uploadedImages = [];
  String uploadedImagePath = "";

  Future<void> handleImageUpload() async {
    File? selectedImage = await ImageUploadService.pickImage();
    if (selectedImage != null) {
      setState(() {
        paymentScreenshot = selectedImage;
        isUploading = true;
      });

      String filename = await ImageUploadService.uploadImage(
        selectedImage,
        '/uploadrecipts/',
      );

      setState(() {
        isUploading = false;
      });
      print("!!!!!!!!!!The problem is$filename");
      uploadedImagePath = filename; // Store the filename
      print("!!!!!!!!!!The problem is$uploadedImagePath");
      if (filename != null) {
        uploadedImagePath = filename;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'yes !!!Upload Successful! Filename: $uploadedImagePath')),
        );
        // Save filename to a variable for future use
        // You can pass this to houseCreate() later
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload Failed. Try Again!')),
        );
      }
    }
  }

  Future<void> houseCreate() async {
    print("!!! Here is is $uploadedImagePath");
    final formData = {
      "city": selectedCity,
      "feeReciptRefnumber": "12121212",
      "latitude": 45.877000,
      "longitude": 98.560000,
      "phonenumber": "546546",
      "sell_or_rent": saleOrRent,
      "houseType": propertyType,
      "numberofBedrooms": bedrooms,
      "numberofBathrooms": bathrooms,
      "feeReciptImgpath": uploadedImagePath,
      // "feeReciptImage": uploadedImagePath, // Use the uploaded image path here
      //"feeReciptImage":"http://188.245.105.29:8888/media/Servicefee_images/assosa_logo.jpeg",
      "price": 23232.00,
      "description": description,
      "category": 2,
      "servicefeeBank": 1,
    };

    try {
      print("!!!!!!1 Form Data: $formData");
      await houseService.create(formData, House.fromJson);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Property Submitted Successfully!')),
      );
    } catch (error) {
      print("Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  Widget _buildPropertyDetailsForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Is the property for Sale or Rent?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: ['Sale', 'Rent'].map((option) {
                return Expanded(
                  child: RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: saleOrRent,
                    onChanged: (value) {
                      setState(() {
                        saleOrRent = value;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Property Type',
                border: OutlineInputBorder(),
              ),
              value: propertyType,
              items: houseTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  propertyType = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a property type' : null,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '# Bedrooms',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: bedrooms?.toString(),
                    onChanged: (value) {
                      setState(() {
                        bedrooms = int.tryParse(value);
                      });
                    },
                    validator: (value) => value!.isEmpty
                        ? 'Please enter the number of bedrooms'
                        : null,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '# Bathrooms',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: bathrooms?.toString(),
                    onChanged: (value) {
                      setState(() {
                        bathrooms = int.tryParse(value);
                      });
                    },
                    validator: (value) => value!.isEmpty
                        ? 'Please enter the number of bathrooms'
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: saleOrRent == 'Sale'
                    ? 'Price (Selling Price)'
                    : 'Price (Monthly Rent)',
                border: const OutlineInputBorder(),
              ),
              initialValue: price?.toString(),
              onChanged: (value) {
                setState(() {
                  price = double.tryParse(value);
                });
              },
              validator: (value) =>
                  value!.isEmpty ? 'Please enter the price' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Square Meters',
                border: OutlineInputBorder(),
              ),
              initialValue: squareMeters?.toString(),
              onChanged: (value) {
                setState(() {
                  squareMeters = double.tryParse(value);
                });
              },
              validator: (value) =>
                  value!.isEmpty ? 'Please enter the square meters' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              initialValue: description,
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a description' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCitySelection() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Select City',
        border: OutlineInputBorder(),
      ),
      value: selectedCity,
      items: cities.map((city) {
        return DropdownMenuItem(value: city, child: Text(city));
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCity = value;
        });
      },
      validator: (value) => value == null ? 'Please select a city' : null,
    );
  }

  Widget _buildImageUploadSection() {
    final ImagePicker picker = ImagePicker();

    Future<void> pickImages() async {
      final images = await picker.pickMultiImage(imageQuality: 80);
      setState(() {
        uploadedImages.addAll(images.map((e) => e.path));
        if (uploadedImages.length > 5) {
          uploadedImages = uploadedImages.take(5).toList();
        }
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: pickImages,
          child: const Text("Upload"),
        ),
        const SizedBox(height: 10),
        if (uploadedImages.isNotEmpty)
          Wrap(
            spacing: 10,
            children: uploadedImages.map((path) {
              return Image.file(
                File(path),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildPaymentDetailsForm() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Select Bank',
          border: OutlineInputBorder(),
        ),
        value: selectedBank,
        items: banks.map((bank) {
          return DropdownMenuItem(value: bank, child: Text(bank));
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedBank = value;
          });
        },
        validator: (value) => value == null ? 'Please select a bank' : null,
      ),
      const SizedBox(height: 10),
      // ElevatedButton(
      //   onPressed: () async {
      //     final picker = ImagePicker();
      //     final pickedImage =
      //         await picker.pickImage(source: ImageSource.gallery);
      //     if (pickedImage != null) {
      //       setState(() {
      //         paymentScreenshot = File(pickedImage.path);
      //       });
      //     }
      //   },
      //   child: const Text('Upload Payment Screenshot'),
      // ),
      ElevatedButton(
        onPressed: handleImageUpload,
        child: Text('Upload Payment Screenshot'),
      ),
      if (paymentScreenshot != null)
        Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(children: [
              Image.file(
                paymentScreenshot!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              if (isUploading)
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: CircularProgressIndicator(),
                ),
            ])),
    ]);
  }

  Widget _buildStepper() {
    final steps = [
      Step(
        title: const Text('Property Details'),
        content: _buildPropertyDetailsForm(),
        isActive: currentStep == 0,
        state: currentStep == 0 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: const Text('City Selection'),
        content: _buildCitySelection(),
        isActive: currentStep == 1,
        state: currentStep == 1 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: const Text('Image Upload'),
        content: _buildImageUploadSection(),
        isActive: currentStep == 2,
        state: currentStep == 2 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: const Text('Payment Details'),
        content: _buildPaymentDetailsForm(),
        isActive: currentStep == 3,
        state: currentStep == 3 ? StepState.editing : StepState.complete,
      ),
    ];

    return Stepper(
      currentStep: currentStep,
      steps: steps,
      onStepContinue: () {
        if (currentStep < steps.length - 1) {
          setState(() {
            currentStep++;
          });
        } else {
          if (_formKey.currentState!.validate()) {
            houseCreate();
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(content: Text('Property Submitted!')),
            // );
          }
        }
      },
      onStepCancel: () {
        if (currentStep > 0) {
          setState(() {
            currentStep--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Property'),
        backgroundColor: AppTheme.customColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildStepper(),
      ),
    );
  }
}
