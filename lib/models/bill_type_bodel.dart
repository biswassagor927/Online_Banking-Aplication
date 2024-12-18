class BillTypeModel {
  String icon;
  String title;


  BillTypeModel({required this.icon, required this.title,});
}

List<BillTypeModel> billtype = [
  BillTypeModel(
      title: 'Electricity',
      icon: 'assets/svg/electricity.svg',
  ),
  BillTypeModel(
      title: 'Internet',
      icon: 'assets/svg/internet.svg',
  ),
  BillTypeModel(
      title: 'Education',
      icon: 'assets/svg/education.svg',
  ),
  BillTypeModel(
      title: 'Bank & FI',
      icon: 'assets/svg/bank.svg',
  ),
  BillTypeModel(
      title: 'Gas',
      icon: 'assets/svg/gas.svg',
  ),
  BillTypeModel(
      title: 'Water',
      icon: 'assets/svg/water.svg',
  ),
  BillTypeModel(
      title: 'Insurance',
      icon: 'assets/svg/insurance.svg',
  ),
  BillTypeModel(
      title: 'Other',
      icon: 'assets/svg/other.svg',
  ),

  
];