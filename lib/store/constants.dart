// ****** Islands
const List<String> islands = [
  "none",
  "HA. Baarah",
  "HA. Dhiddhoo",
  "HA. Filladhoo",
  "HA. Hoarafushi",
  "HA. Ihavandhoo",
  "HA. Kelaa",
  "HA. Maarandhoo",
  "HA. Mulhadhoo",
  "HA. Muraidhoo",
  "HA. Thakandhoo",
  "HA. Thuraakunu",
  "HA. Uligamu",
  "HA. Utheemu",
  "HA. Vashafaru",
  "HDh. Hanimaadhoo",
  "HDh. Finey",
  "HDh. Naivaadhoo",
  "HDh. Nolhivaranfaru",
  "HDh. Nellaidhoo",
  "HDh. Nolhivaram",
  "HDh. Kurinbi",
  "HDh. Kulhudhuffushi",
  "HDh. Kumundhoo",
  "HDh. Neykurendhoo",
  "HDh. Vaikaradhoo",
  "HDh. Makunudhoo",
  "HDh. Hirimaradhoo",
  "Sh. Bileffahi",
  "Sh. Feevah",
  "Sh. Feydhoo",
  "Sh. Foakaidhoo",
  "Sh. Funadhoo",
  "Sh. Goidhoo",
  "Sh. Kanditheemu",
  "Sh. Komandoo",
  "Sh. Lhaimagu",
  "Sh. Maaungoodhoo",
  "Sh. Maroshi",
  "Sh. Milandhoo",
  "Sh. Narudhoo",
  "Sh. Noomaraa",
  "N. Foddhoo",
  "N. Henbandhoo",
  "N. Holhudhoo",
  "N. Kendhikulhudhoo",
  "N. Kudafari",
  "N. Landhoo",
  "N. Lhohi",
  "N. Maafaru",
  "N. Maalhendhoo",
  "N. Magoodhoo",
  "N. Manadhoo",
  "N. Miladhoo",
  "N. Velidhoo",
  "R. Alifushi",
  "R. Angolhitheemu",
  "R. Fainu",
  "R. Hulhudhuffaaru",
  "R. Inguraidhoo",
  "R. Innamaadhoo",
  "R. Dhuvaafaru",
  "R. Kinolhas",
  "R. Maakurathu",
  "R. Maduvvaree",
  "R. Meedhoo",
  "R. Rasgetheemu",
  "R. Rasmaadhoo",
  "R. Ungoofaaru",
  "R. Vaadhoo",
  "B. Dharavandhoo",
  "B. Dhonfanu",
  "B. Eydhafushi",
  "B. Fehendhoo",
  "B. Fulhadhoo",
  "B. Goidhoo",
  "B. Hithaadhoo",
  "B. Kamadhoo",
  "B. Kendhoo",
  "B. Kihaadhoo",
  "B. Kudarikilu",
  "B. Maalhos",
  "B. Thulhaadhoo",
  "Lh. Hinnavaru",
  "Lh. Kurendhoo",
  "Lh. Maafilaafushi",
  "Lh. Naifaru",
  "Lh. Olhuvelifushi",
  "K. Dhiffushi",
  "K. Gaafaru",
  "K. Gulhi",
  "K. Guraidhoo",
  "K. Himmafushi",
  "K. Hulhumalé",
  "K. Huraa",
  "K. Kaashidhoo",
  "K. Malé",
  "K. Maafushi",
  "K. Thulusdhoo",
  "K. Vilimalé",
  "AA. Bodufolhudhoo",
  "AA. Feridhoo",
  "AA. Himandhoo",
  "AA. Maalhos",
  "AA. Mathiveri",
  "AA. Rasdhoo",
  "AA. Thoddoo",
  "AA. Ukulhas",
  "AA. Fesdhoo",
  "ADh. Dhangethi",
  "ADh. Dhiddhoo",
  "ADh. Dhigurah",
  "ADh. Fenfushi",
  "ADh. Haggnaameedhoo",
  "ADh. Kunburudhoo",
  "ADh. Maamingili",
  "ADh. Mahibadhoo",
  "ADh. Mandhoo",
  "ADh. Omadhoo",
  "V. Felidhoo",
  "V. Fulidhoo",
  "V. Keyodhoo",
  "V. Rakeedhoo",
  "V. Thinadhoo",
  "M. Boli Mulah",
  "M. Dhiggaru",
  "M. Kolhufushi",
  "M. Madifushi",
  "M. Maduvvaree",
  "M. Muli",
  "M. Naalaafushi",
  "M. Raimmandhoo",
  "M. Veyvah",
  "F. Bileddhoo",
  "F. Dharanboodhoo",
  "F. Feeali",
  "F. Magoodhoo",
  "F. Nilandhoo",
  "D. Bandidhoo",
  "D. Gemendhoo",
  "D. Hulhudheli",
  "D. Kudahuvadhoo",
  "D. Maaenboodhoo",
  "D. Meedhoo",
  "D. Rinbudhoo",
  "D. Vaanee",
  "Th. Burunee",
  "Th. Vilufushi",
  "Th. Madifushi",
  "Th. Dhiyamingili",
  "Th. Guraidhoo",
  "Th. Gaadhiffushi",
  "Th. Thimarafushi",
  "Th. Veymandoo",
  "Th. Kinbidhoo",
  "Th. Omadhoo",
  "Th. Hirilandhoo",
  "Th. Kandoodhoo",
  "Th. Vandhoo",
  "L. Dhanbidhoo",
  "L. Fonadhoo",
  "L. Gan",
  "L. Hithadhoo",
  "L. Isdhoo",
  "L. Kunahandhoo",
  "L. Maabaidhoo",
  "L. Maamendhoo",
  "L. Maavah",
  "L. Mundoo",
  "GA. Dhaandhoo",
  "GA. Dhevvadhoo",
  "GA. Gemanafushi",
  "GA. Kanduhulhudhoo",
  "GA. Kolamaafushi",
  "GA. Kondey",
  "GA. Maamendhoo",
  "GA. Nilandhoo",
  "GA. Vilingili",
  "GDh. Fares-Maathodaa",
  "GDh. Fiyoaree",
  "GDh. Gaddhoo",
  "GDh. Hoandeddhoo",
  "GDh. Madaveli",
  "GDh. Nadellaa",
  "GDh. Rathafandhoo",
  "GDh. Thinadhoo",
  "GDh. Vaadhoo",
  "Gn. Fuvahmulah",
  "S.Hithadhoo",
  "S.Maradhoo",
  "S.Maradhoo-Feydhoo",
  "S.Feydhoo",
  "S.Hulhudhoo",
  "S.Meedhoo",
];

// ****** Services
const List services = [
  {
    "display": "Wi-Fi",
    "value": "internet",
  },
  {
    "display": "Restaurant",
    "value": "restaurant",
  },
  {
    "display": "Bar",
    "value": "bar",
  },
  {
    "display": "Room service",
    "value": "room_service",
  },
  {
    "display": "Breakfast",
    "value": "breakfast",
  },
  {
    "display": "Breakfast buffet",
    "value": "breakfast_buffet",
  },
  {
    "display": "Front desk",
    "value": "front_desk",
  },
  {
    "display": "Full service laundry",
    "value": "laundry_service",
  },
  {
    "display": "Kid-friendly",
    "value": "kid",
  },
  {
    "display": "Pool",
    "value": "pool",
  },
  {
    "display": "Parking",
    "value": "park",
  },
  {
    "display": "Fitness center",
    "value": "fitness",
  },
  {
    "display": "Air conditioning",
    "value": "air",
  },
  {
    "display": "Beach access",
    "value": "beach",
  },
  {
    "display": "Hot tub",
    "value": "hot",
  },
  {
    "display": "Spa",
    "value": "spa",
  },
  {
    "display": "laundry",
    "value": "laundry",
  },
  {
    "display": "TV",
    "value": "tv",
  },
  {
    "display": "  Smoke free",
    "value": "smoke",
  },
];