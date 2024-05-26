import 'package:bicycle_renting/models/bicycle.dart';
import 'package:bicycle_renting/pages/bicycleDetail/bicyclePageDetail.dart';
import 'package:bicycle_renting/providers/bicycleListProvider.dart';
import 'package:bicycle_renting/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class bicyclesListPage extends StatefulWidget {
  const bicyclesListPage({super.key});

  @override
  State<bicyclesListPage> createState() => _bicyclesListPageState();
}

class _bicyclesListPageState extends State<bicyclesListPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextStyle _titleStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  final TextStyle _valueStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );

  List<Bicycle> _bicyclesFilter(List<Bicycle> bicycles, String searchOption, String searchTxt,
      String sortOption, List<bool> availability0) {
    if (searchOption != '') {
      bicycles = bicycles
          .where((e) => e
          .toJson()[searchOption]
          .toString()
          .toLowerCase()
          .contains(searchTxt))
          .toList();
    }

    if (sortOption == azOder) {
      bicycles.sort((a, b) => a
          .toJson()[searchOption]
          .toString()
          .toLowerCase()
          .compareTo(b.toJson()[searchOption].toString().toLowerCase()));
    } else if (sortOption == zaOder) {
      bicycles.sort((a, b) => a
          .toJson()[searchOption]
          .toString()
          .toLowerCase()
          .compareTo(b.toJson()[searchOption].toString().toLowerCase()));
      bicycles = bicycles.reversed.toList();
    } else if (sortOption == priceHigh) {
      bicycles.sort((a, b) => a.price!.compareTo(b.price!));
      bicycles = bicycles.reversed.toList();
    } else if (sortOption == priceLow) {
      bicycles.sort((a, b) => a.price!.compareTo(b.price!));
    }
    int index = availability0.indexWhere((element) => element == true);
    if (index >= 0) {
      bicycles =
          bicycles.where((bicycle) => bicycle.availability == availability[index]).toList();
    }
    return bicycles;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bicycleListProvider provider =
      Provider.of<bicycleListProvider>(context, listen: false);
      provider.getbicycles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Consumer<bicycleListProvider>(
            builder: (context, bicycleListProvider, child) {
              return Scaffold(
                body: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 0, 126, 230),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(52),
                              bottomRight: Radius.circular(52),
                            ),
                          ),
                          height: 65,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  PopupMenuButton(
                                    onSelected: (c) {
                                      bicycleListProvider.onSearchOptionChange(c);
                                      _searchController.clear();
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          bicycleListProvider.searchOption,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                    itemBuilder: (context) => bicycleSearchOption
                                        .map((c) =>
                                        PopupMenuItem(value: c, child: Text(c)))
                                        .toList(),
                                  ),
                                  Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.only(right: 20),
                                          child: TextField(
                                            controller: _searchController,
                                            onChanged: (value) => {
                                              bicycleListProvider.onSearchChange(value)
                                            },
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                EdgeInsets.fromLTRB(8, 2, 8, 2),
                                                filled: true,
                                                fillColor: Colors.white,
                                                focusColor: Colors.white,
                                                labelStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(12),
                                                  ),
                                                ),
                                                hintText: 'Search',
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(12)),
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                )),
                                          )))
                                ],
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ToggleButtons(
                              onPressed: (int index) {
                                bicycleListProvider.onAvailabilityClick(index);
                              },
                              borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                              selectedBorderColor:
                              const Color.fromARGB(255, 0, 126, 230),
                              selectedColor: Colors.white,
                              fillColor: const Color.fromARGB(255, 0, 126, 230),
                              color: Colors.blue[400],
                              constraints: const BoxConstraints(
                                minHeight: 40.0,
                                minWidth: 80.0,
                              ),
                              isSelected: bicycleListProvider.selectedAvailability,
                              children: [
                                Text(
                                  availability[0],
                                  style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(availability[1],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                            PopupMenuButton(
                              onSelected: (c) {
                                bicycleListProvider.onSortOptionChange(c);
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    bicycleListProvider.orderOption,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                              itemBuilder: (context) => bicycleSortOption
                                  .map((c) =>
                                  PopupMenuItem(value: c, child: Text(c)))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: StreamBuilder(
                              stream: bicycleListProvider.bicycles,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator()),
                                  );
                                }
                                List<Bicycle>? bicycleSnapshot = snapshot.data;

                                if (bicycleSnapshot != null) {
                                  bicycleSnapshot = _bicyclesFilter(
                                      bicycleSnapshot,
                                      bicycleListProvider.searchOption.toLowerCase(),
                                      bicycleListProvider.searchTxt.toLowerCase(),
                                      bicycleListProvider.orderOption,
                                      bicycleListProvider.selectedAvailability);
                                } else {
                                  return const Text("No data");
                                }

                                return ListView.builder(
                                    itemCount: bicycleSnapshot.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => bicycleDetailsPage(
                                                bicycleId: bicycleSnapshot![index].id,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          margin: const EdgeInsets.all(10),
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            child: Row(
                                              children: [
                                                // Image on the left side
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(8), // Rounded corners for the image
                                                  child: Image.asset(
                                                    'assets/images/Design_sans_titre__5_-removebg-preview.png',
                                                    height: 80, // Adjust height as needed
                                                    width: 120, // Adjust width as needed
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(width: 12), // Space between image and text
                                                // Column for text next to the image
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            "\$${bicycleSnapshot![index].price} / Day",
                                                            style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 18,
                                                              color: Color.fromARGB(255, 0, 126, 230),
                                                            ),
                                                          ),
                                                          Text(
                                                            bicycleSnapshot[index].availability!,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16,
                                                              color: bicycleSnapshot[index].availability == availability[0]
                                                                  ? Colors.green
                                                                  : Colors.red,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Model", style: _titleStyle),
                                                          const SizedBox(width: 8),
                                                          Expanded(
                                                            child: Text(bicycleSnapshot[index].model!, style: _valueStyle),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Price", style: _titleStyle),
                                                          const SizedBox(width: 8),
                                                          Expanded(
                                                            child: Text(
                                                              "\$${bicycleSnapshot[index].price} / Day",
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16,
                                                                color: Color.fromARGB(255, 0, 126, 230),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }))
                    ],
                  ),
                ),
              );
            }));
  }
}
