part of 'views.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // data area
  List<ProvinceModel> provinceData = [];
  List<CityModel> originCities = [];
  List<CityModel> destinationCities = [];
  List<Cost> costsData = [];

  // loading area
  bool originCityLoading = false;
  bool destinationCityLoading = false;

  // selected area
  String originProvince = "";
  String destinationProvince = "";
  String originCitySelected = "";
  String destinationCitySelected = "";
  String selectedCourier = "jne";
  int weight = 0;

  getProvince() async {
    await MasterDataService.getProvince().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          provinceData = value;
        });
      }
    });
  }

  getCitiesByProvinceId(String provinceId, bool isOrigin) async {
    await MasterDataService.getCitiesByProvinceId(provinceId).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          if (isOrigin) {
            originCities = value;

            originCityLoading = false;
          } else {
            destinationCities = value;

            destinationCityLoading = false;
          }
        });
      }
    });
  }

  getCostsData() async {
    await MasterDataService.getAllOfTheCosts(originCitySelected,
            destinationCitySelected, weight, selectedCourier)
        .then((value) {
      if (value.costs!.isNotEmpty) {
        setState(() {
          costsData = value.costs!;
         
        });
        stopLoading(context);
      }
    });
  }

  void onCourierSelected(String? text) {
    setState(() {
      selectedCourier = text!;
    });
  }

  void onClickCalculate() {
    
    startLoading(context);
    getCostsData();
  }

  void onProvinceOriginSelected(String? text) {
    setState(() {
      originCitySelected = "";
      originProvince = text!;
      originCityLoading = true;
    });
    getCitiesByProvinceId(text!, true);
  }

  void onProvinceDestinationSelected(String? text) {
    setState(() {
      destinationCitySelected = "";
      destinationProvince = text!;
      destinationCityLoading = true;
    });
    getCitiesByProvinceId(text!, false);
  }

  void onCityOriginSelected(String? text) {
    setState(() {
      originCitySelected = text!;
    });
  }

  void onCityDestinationSelected(String? text) {
    setState(() {
      destinationCitySelected = text!;
    });
  }

  @override
  void initState() {
    super.initState();
    getProvince();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double dropDownWidth = screenWidth / 2.5;
    return Scaffold(
      resizeToAvoidBottomInset : false,
        appBar: AppBar(
          title: const Text("Calculate Cost"),
        ),
        body: provinceData.isNotEmpty
            ? Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Column(children: [
                            DropdownMenuCustom(
                                width: dropDownWidth,
                                isActive: true,
                                initialSelection: selectedCourier,
                                list: const [
                                  "jne",
                                  "tiki",
                                  "pos"
                                ].map<DropdownMenuEntry<String>>((String value) {
                                  return DropdownMenuEntry<String>(
                                      value: value, label: value);
                                }).toList(),
                                onDropDownMenuClick: onCourierSelected),
                          ])),
                          Expanded(
                              child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                setState(() {
                                  weight = int.parse(text);
                                });
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Input weight (gram)',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    /////////////////////////////////////// dynamic area ///////////////////////////////////

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DropDownMenuWrapper(
                            width: dropDownWidth,
                            isActive: true,
                            title: "Origin Province",
                            currentSelected: originProvince,
                            list: provinceData.map<DropdownMenuEntry<String>>(
                                (ProvinceModel value) {
                              return DropdownMenuEntry<String>(
                                  value: value.provinceId!,
                                  label: value.province!);
                            }).toList(),
                            onSelected: onProvinceOriginSelected),
                        !originCityLoading
                            ? DropDownMenuWrapper(
                                width: dropDownWidth,
                                isActive: originProvince != "",
                                title: "Origin City",
                                currentSelected: originCitySelected,
                                list: originCities
                                    .map<DropdownMenuEntry<String>>(
                                        (CityModel value) {
                                  return DropdownMenuEntry<String>(
                                      value: value.cityId!,
                                      label: value.cityName!);
                                }).toList(),
                                onSelected: onCityOriginSelected)
                            : const Expanded(child: Center(child: Padding(padding: EdgeInsets.only(top: 40) ,child: CircularProgressIndicator())))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DropDownMenuWrapper(
                            width: dropDownWidth,
                            isActive: true,
                            title: "Destination Province",
                            currentSelected: destinationProvince,
                            list: provinceData.map<DropdownMenuEntry<String>>(
                                (ProvinceModel value) {
                              return DropdownMenuEntry<String>(
                                  value: value.provinceId!,
                                  label: value.province!);
                            }).toList(),
                            onSelected: onProvinceDestinationSelected),
                        !destinationCityLoading
                            ? DropDownMenuWrapper(
                                width: dropDownWidth,
                                isActive: destinationProvince != "",
                                title: "Destination City",
                                currentSelected: destinationCitySelected,
                                list: destinationCities
                                    .map<DropdownMenuEntry<String>>(
                                        (CityModel value) {
                                  return DropdownMenuEntry<String>(
                                      value: value.cityId!,
                                      label: value.cityName!);
                                }).toList(),
                                onSelected: onCityDestinationSelected)
                            : const Expanded(child: Center(child: Padding(padding: EdgeInsets.only(top: 40) ,child: CircularProgressIndicator())))
                      ],
                    ),

                    //////////////////////////////// after dynamic area ////////////////////////////
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20)),
                      onPressed: onClickCalculate,
                      child: const Text('Calculate'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: costsData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: CircleAvatar(
                              child: Text('${costsData[index].service}')),
                          title: Text(
                              "${costsData[index].description} (${costsData[index].service})"),
                          subtitle: RichText(
                            text: TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        'Biaya : Rp ${costsData[index].cost![0].value}\n'),
                                TextSpan(
                                    text:
                                        'Estimasi sampai ${costsData[index].cost![0].etd} hari',
                                    style: const TextStyle(color: Colors.blue)),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
