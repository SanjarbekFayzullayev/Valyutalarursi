class OnBoarding {
  String image;
  String name;
  String description;

  OnBoarding({
    required this.image,
    required this.name,
    required this.description,
  });
}

List<OnBoarding> model = [
  OnBoarding(
      image: "assets/images/card.png",
      name: "Endi valyuta kursini oson va aniq blib oling!\n",
      description:
          "Endi valyuta kursi haqida ma'lumot olish uchun, qandaydir saytlardan izlash shart emas.Endi hammasi sizning smartfoningizda faqatgina bir bosish bilan!\n"),
  OnBoarding(
      image: "assets/images/card2.png",
      name: "75 ta valyuta va 24/7 shakilda siz bilan birga!\n",
      description:
          "Dasturda umumiy 75 ta mashxur valyutalar narxlari va qiymatali joylab botiladi!\n"),
  OnBoarding(
      image: "assets/images/card3.png",
      name: "Foydalanuvchi uchun eslatma!\n",
      description: "Ilovadan to'liq foydalanish uchun internet sifati yaxshi bo'lishi shart !\n"),
];
