import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sport_partner/data/cities_data.dart';
import 'package:sport_partner/services/city_service.dart';
import 'package:sport_partner/view/pages/sport_categories_page.dart';

class SelectCityPage extends StatefulWidget {
  const SelectCityPage({super.key});

  @override
  State<SelectCityPage> createState() => _SelectCityPageState();
}

class _SelectCityPageState extends State<SelectCityPage> {
  final cityService = CityService();
  final cities = CitiesData().cities;
  String? _selectedCity;
  late Future<void> _setInitialData;

  Future<void> _onContinueClicked(String city) async {
    await cityService.saveSelectedCity(city);
    _navigateToSportCategoriesPage();
  }

  void _navigateToSportCategoriesPage() {
    if (context.mounted) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SportCategoriesPage(),
          ),
        );
      }
    }
  }

  Future<void> setInitialData() async {
    final selectedCity = await cityService.getSelectedCity();
    if (selectedCity != null && selectedCity.isNotEmpty) {
      _selectedCity = selectedCity;
    } else {
      _selectedCity = cities.first;
    }
  }

  @override
  void initState() {
    super.initState();
    _setInitialData = setInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/tennis.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Image.asset('assets/images/logo.png'),
                    const Text(
                      'Wybierz swoje miasto: ',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 15),
                    FutureBuilder(
                        future: _setInitialData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return DropdownButton2<String>(
                              value: _selectedCity,
                              items: cities.map(buildMenuItem).toList(),
                              onChanged: (value) => setState(() => _selectedCity = value),
                              isExpanded: true,
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                  color: Colors.grey[300],
                                ),
                                elevation: 2,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200],
                                ),
                                offset: const Offset(0, -5),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 14),
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async => _onContinueClicked(_selectedCity!),
                      child: const Text('Kontynuuj'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
