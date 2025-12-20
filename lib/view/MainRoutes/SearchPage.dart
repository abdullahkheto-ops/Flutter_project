import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_project/components/CustomNavBar.dart';

class SearchPage extends StatefulWidget {
  

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController roomCountController = TextEditingController();
  RangeValues selectedPriceRange = RangeValues(100000, 1000000);
  String selectedGovernorate = 'الكل';

  List<String> governorates = [
    'الكل', 'دمشق', 'ريف دمشق', 'حمص', 'حلب', 'اللاذقية', 'طرطوس',
    'درعا', 'حماة', 'إدلب', 'دير الزور', 'القنيطرة', 'الرقة', 'الحسكة', 'السويداء'
  ];

  List<Map<String, dynamic>> allItems = [
    {
      'name': 'شقة فخمة في دمشق',
      'governorate': 'دمشق',
      'city': 'المزة',
      'price': 500000,
      'rooms': 3,
    },
    {
      'name': 'منزل في ريف دمشق',
      'governorate': 'ريف دمشق',
      'city': 'دوما',
      'price': 300000,
      'rooms': 2,
    },
    {
      'name': 'شقة في حمص',
      'governorate': 'حمص',
      'city': 'الوعر',
      'price': 700000,
      'rooms': 4,
    },
  ];

  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  void openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Icon(Icons.home_work, size: 60, color: Colors.purple)),
                SizedBox(height: 8),
                Center(child: Text("فلترة البحث", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,))),
                SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: selectedGovernorate,
                  decoration: InputDecoration(
                    labelText: 'المحافظة',
                    border: OutlineInputBorder(),
                  ),
                  items: governorates
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (value) => setState(() => selectedGovernorate = value!),
                ),
                SizedBox(height: 12),

                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    labelText: 'المدينة',
                    prefixIcon: Icon(Icons.location_city),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),

                TextField(
                  controller: roomCountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'عدد الغرف',
                    prefixIcon: Icon(Icons.meeting_room),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),

                Text(
                    'السعر: من ${selectedPriceRange.start.toInt()} إلى ${selectedPriceRange.end.toInt()} ل.س',
                    style: TextStyle(fontWeight: FontWeight.bold),


                ),
                RangeSlider(
                  values: selectedPriceRange,
                  min: 0,
                  max: 2000000,
                  divisions: 20,
                  labels: RangeLabels(
                    '${selectedPriceRange.start.toInt()}',
                    '${selectedPriceRange.end.toInt()}',
                  ),
                  onChanged: (values) {
                    setState(() => selectedPriceRange = values);
                  },
                ),
                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.check),
                    label: Text('تطبيق الفلترة',style:TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[200],
                      padding: EdgeInsets.symmetric(vertical: 14),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      applyFilters();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void applyFilters() {
    String query = searchController.text.toLowerCase();
    String city = cityController.text.toLowerCase();
    double minPrice = selectedPriceRange.start;
    double maxPrice = selectedPriceRange.end;
    int? rooms = int.tryParse(roomCountController.text);

    setState(() {
      filteredItems = allItems.where((item) {
        bool matchesText = item['name'].toLowerCase().contains(query);
        bool matchesGov = selectedGovernorate == 'الكل' || item['governorate'] == selectedGovernorate;
        bool matchesCity = city.isEmpty || item['city'].toLowerCase().contains(city);
        bool matchesPrice = item['price'] >= minPrice && item['price'] <= maxPrice;
        bool matchesRooms = rooms == null || item['rooms'] == rooms;

        return matchesText && matchesGov && matchesCity && matchesPrice && matchesRooms;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'انقر للبحث',
            border: InputBorder.none,
          ),
          onChanged: (_) => applyFilters(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: openFilterSheet,
          ),
        ],
      ),
      body: Stack(
        children:[ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text(
              '${item['governorate']} - ${item['city']} - ${item['price']} ل.س - ${item['rooms']} غرف',
            ),
          );
        },
      ) ,
      Positioned(left: 20, right: 20, bottom: 20, child: CustomNavBar()),
        ],
      ),
    );
  }
}