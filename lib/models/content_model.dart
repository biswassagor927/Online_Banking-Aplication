class UnbordingContent {
  String image;
  String title;
  String discription;


  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Get Bank ID',
      image: 'assets/img/onbording1.png',
      discription: "Our new service makes it easy for you to\n work anywhere, there are new features\n will ready help you."
  ),
  UnbordingContent(
      title: 'Integrate With Bank',
      image: 'assets/img/onbording2.png',
      discription: "Safety of your funds is guaranteed. We’ve\n got you covered 24/7."
  ),
  UnbordingContent(
      title: 'Manage Finance',
      image: 'assets/img/onbording3.png',
      discription: "Send money to other sutraq users free of\n charge, with no additional fee."
  ),
];