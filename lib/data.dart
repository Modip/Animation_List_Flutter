class Picture {
  final String title;
  final String image;
  final String subtitle;

  const Picture({
    required this.title,
    required this.image,
    required this.subtitle,
  });
}

const pictures = [
  Picture(
      title: "Senegal",
      subtitle: "Les lions de la teranga",
      image: "assets/images/senegal.jpg"),
  Picture(
      title: "Guinee",
      subtitle: "Les lions de la teranga",
      image: "assets/images/guinee.jpg"),
  Picture(
      title: "Mauritanie",
      subtitle: "Les mouhabitouns",
      image: "assets/images/mauritanie.jpg"),
  Picture(
      title: "Nigeria",
      subtitle: "Les aigles du Nigeria",
      image: "assets/images/nigeria.jpg"),
  Picture(
      title: "Ghana",
      subtitle: "Les blacks stars ",
      image: "assets/images/ghana.jpg"),
  Picture(
      title: "Gambie",
      subtitle: "Les scorpions de la Gambie",
      image: "assets/images/gambie.jpg"),
  Picture(
      title: "Congo",
      subtitle: "Les diables rouges",
      image: "assets/images/congo.jpg"),
  Picture(
      title: "Mali",
      subtitle: "Les aigles du Mali",
      image: "assets/images/mali.jpg"),
  Picture(
      title: "Cameroun",
      subtitle: "Les lions de indomptables",
      image: "assets/images/cameroun.jpg"),
];
