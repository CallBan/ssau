<template>
  <div class="car-price-form">
    <h2>Прогнозирование стоимости автомобиля</h2>

    <form @submit.prevent="calculatePrice">
      <div class="form-group">
        <label>Марка:</label>
        <select v-model="form.brand" @change="updateModels">
          <option v-for="brand in brands" :key="brand" :value="brand">
            {{ brand }}
          </option>
        </select>
      </div>

      <div class="form-group">
        <label>Модель:</label>
        <select v-model="form.model" :disabled="!form.brand">
          <option
            v-for="model in models[form.brand] || []"
            :key="model"
            :value="model"
          >
            {{ model }}
          </option>
        </select>
      </div>

      <div class="form-group">
        <label>Пробег (км):</label>
        <input type="number" v-model.number="form.mileage" required />
      </div>

      <div class="form-group">
        <label>Лет в эксплуатации:</label>
        <input type="number" v-model.number="form.yearsInUse" required />
      </div>

      <div class="form-group checkbox-group">
        <label>Битый:</label>
        <input type="checkbox" v-model="form.damaged" />
      </div>

      <div class="form-group">
        <label>Тип кузова:</label>
        <select v-model="form.bodyType">
          <option v-for="type in bodyTypes" :key="type" :value="type">
            {{ type }}
          </option>
        </select>
      </div>

      <div class="form-group">
        <label>Тип топлива:</label>
        <select v-model="form.fuelType">
          <option v-for="type in fuelTypes" :key="type" :value="type">
            {{ type }}
          </option>
        </select>
      </div>

      <div class="form-group">
        <label>Тип привода:</label>
        <select v-model="form.driveType">
          <option v-for="type in driveTypes" :key="type" :value="type">
            {{ type }}
          </option>
        </select>
      </div>

      <div class="form-group">
        <label>Тип трансмиссии:</label>
        <select v-model="form.transmissionType">
          <option v-for="type in transmissionTypes" :key="type" :value="type">
            {{ type }}
          </option>
        </select>
      </div>

      <div class="form-group">
        <label>Объем двигателя (л):</label>
        <input
          type="number"
          v-model.number="form.engineCapacity"
          step="0.1"
          required
        />
      </div>

      <div class="form-group">
        <label>Мощность (л.с.):</label>
        <input type="number" v-model.number="form.horsePower" required />
      </div>

      <button type="submit">Рассчитать стоимость</button>
    </form>

    <div v-if="predictedPrice !== null" class="result">
      <h3>Предсказанная стоимость:</h3>
      <p class="price">{{ predictedPrice }} ₽</p>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        brand: "",
        model: "",
        mileage: 0,
        yearsInUse: 0,
        damaged: false,
        bodyType: "",
        fuelType: "",
        driveType: "",
        transmissionType: "",
        engineCapacity: 0,
        horsePower: 0,
      },
      predictedPrice: null,
      brands: [
        "Audi",
        "BMW",
        "Changan",
        "Chery",
        "Chevrolet",
        "Ford",
        "Geely",
        "Haval",
        "Honda",
        "Hyundai",
        "Kia",
        "Land Rover",
        "Lexus",
        "Mazda",
        "Mercedes-Benz",
        "Mitsubishi",
        "Nissan",
        "Opel",
        "Peugeot",
        "Renault",
        "Skoda",
        "Suzuki",
        "Tank",
        "Toyota",
        "Volkswagen",
        "ВАЗ (LADA)",
        "ГАЗ",
        "УАЗ",
      ],
      models: {
        Audi: [
          "Q7",
          "Q5",
          "A6",
          "A4",
          "A3",
          "A5",
          "A1",
          "A7",
          "SQ5",
          "Q3",
          "A4 Allroad Quattro",
          "S8",
          "S3",
          "100",
          "A8",
          "A6 Allroad Quattro",
          "SQ7",
          "Q8",
          "RS7",
          "80",
          "TTS",
          "TT",
          "RS6",
          "Q6",
          "e-tron S",
          "200",
        ],
        BMW: [
          "X5",
          "X3",
          "X6",
          "5 серия GT",
          "X1",
          "X7",
          "5 серия",
          "8 серия",
          "3 серия",
          "M5",
          "7 серия",
          "1 серия",
          "X4",
          "4 серия",
          "X6 M",
          "6 серия",
          "2 серия",
          "i3",
          "4 серия Gran Coupe",
          "321",
          "2 серия Active Tourer",
          "3 серия GT",
          "2 серия Gran Tourer",
          "M8 серия Gran Coupe",
          "X2",
          "X5 M",
          "6 серия GT",
        ],
        Changan: [
          "UNI-K",
          "CS35 Plus",
          "CS55 Plus",
          "CS75",
          "UNI-V",
          "CS95 Plus",
          "UNI-T",
          "Alsvin",
          "CS35",
          "CS55",
          "CS75 Plus",
          "Hunter Plus",
          "Eado Plus",
          "Hunter",
          "CS95",
        ],
        Chery: [
          "Tiggo 2 Pro",
          "Tiggo 5",
          "IndiS (S18D)",
          "Kimo (A1)",
          "Tiggo 8 Pro",
          "Tiggo 7 Pro Max",
          "Tiggo 4 Pro",
          "Tiggo 4",
          "Arrizo",
          "Tiggo 8 Pro Max",
          "Tiggo 7 Pro",
          "Tiggo (T11)",
          "Tiggo 3",
          "Amulet (A15)",
          "Tiggo 7 Plus",
          "Tiggo 2",
          "Explore 06",
          "Bonus (A13)",
          "Arrizo 8",
          "Very",
          "Sweet (QQ)",
          "M11 (A3)",
          "Tiggo 7",
          "Tiggo 8",
          "Fora (A21)",
          "QQ6 (S21)",
          "CrossEastar (B14)",
        ],
        Chevrolet: [
          "Niva",
          "Aveo",
          "Equinox",
          "Rezzo",
          "Captiva",
          "Lacetti",
          "Cruze",
          "Express",
          "Spark",
          "Lanos",
          "Tahoe",
          "Monza",
          "Cobalt",
          "Orlando",
          "Viva",
          "Epica",
          "Silverado",
          "Malibu",
          "Trax",
          "TrailBlazer",
          "Volt",
          "Camaro",
          "Lumina",
          "Corvette",
          "Traverse",
          "Nexia",
          "Blazer",
          "Evanda",
        ],
        Ford: [
          "Fusion (North America)",
          "Transit",
          "Kuga",
          "Galaxy",
          "Focus",
          "Explorer",
          "Fusion",
          "C-MAX",
          "Ranger",
          "Mondeo",
          "Edge",
          "Fiesta",
          "EcoSport",
          "Escape",
          "S-MAX",
          "Bronco",
          "Mustang",
          "Transit Custom",
          "Sierra",
          "Escort",
          "Crown Victoria",
          "Probe",
          "Freda",
          "Bronco Sport",
          "Econoline",
          "Maverick",
          "Bronco II",
          "Tourneo Connect",
          "Model T",
          "Cougar",
          "F-150",
          "Transit Connect",
        ],
        Geely: [
          "Coolray",
          "Atlas Pro",
          "Monjaro",
          "Emgrand X7",
          "Emgrand EC7",
          "Tugella",
          "Emgrand 7",
          "Atlas",
          "FC (Vision)",
          "MK Cross",
          "MK",
          "GC6",
          "Preface",
          "Okavango",
          "CK (Otaka)",
          "Boyue Cool",
          "Emgrand",
          "Galaxy L7",
        ],
        Haval: [
          "H5",
          "F7",
          "F7x",
          "H9",
          "M6",
          "Jolion",
          "H6",
          "Dargo",
          "H2",
          "Dargo X",
        ],
        Honda: [
          "Insight",
          "Fit Shuttle",
          "Accord",
          "Civic",
          "CR-V",
          "N-BOX",
          "N-WGN",
          "Partner",
          "HR-V",
          "Vezel",
          "Jazz",
          "Stepwgn",
          "Element",
          "Freed",
          "Shuttle",
          "UR-V",
          "Fit",
          "Odyssey",
          "Pilot",
          "Ridgeline",
          "Capa",
          "Inspire",
          "Vigor",
          "Freed+",
          "Integra",
          "Concerto",
          "Logo",
          "Prelude",
          "Domani",
          "ZR-V",
        ],
        Hyundai: [
          "Creta",
          "Solaris",
          "Elantra",
          "Palisade",
          "ix35",
          "i30",
          "Tucson",
          "Santa Fe",
          "Sonata",
          "Getz",
          "Kona",
          "Accent",
          "Staria",
          "Terracan",
          "Matrix",
          "Grand Starex",
          "ix55",
          "Porter",
          "Grandeur",
          "i40",
          "Veloster",
          "H-1",
          "Genesis",
          "Mufasa",
          "Verna",
          "Avante",
          "Bayon",
          "Starex",
          "Coupe",
          "i20",
          "H-100",
          "Lantra",
          "Grand Santa Fe",
        ],
        Kia: [
          "Rio",
          "Sportage",
          "K5",
          "Optima",
          "Ceed",
          "Sorento",
          "Cerato",
          "Quoris",
          "Stonic",
          "Seltos",
          "Soul",
          "Spectra",
          "Rio X",
          "Picanto",
          "Venga",
          "Rio X-Line",
          "Mohave",
          "Ceed GT",
          "Morning",
          "Bongo",
          "Magentis",
          "Stinger",
          "Sorento Prime",
          "Carnival",
          "Carens",
          "Shuma",
          "K9",
          "K8",
          "K3",
          "Sonet",
          "XCeed",
        ],
        "Land Rover": [
          "Discovery Sport",
          "Freelander",
          "Range Rover",
          "Range Rover Sport",
          "Range Rover Evoque",
          "Discovery",
          "Defender",
          "Range Rover Velar",
        ],
        Lexus: [
          "LX",
          "RX",
          "NX",
          "ES",
          "UX",
          "IS",
          "GX",
          "GS F",
          "LS",
          "GS",
          "RC",
          "LM",
        ],
        Mazda: [
          "6",
          "CX-5",
          "3",
          "CX-9",
          "CX-7",
          "5",
          "Premacy",
          "BT-50",
          "CX-3",
          "323",
          "2",
          "CX-30",
          "CX-60",
          "MPV",
          "Demio",
          "Tribute",
          "3 MPS",
          "MX-3",
          "6 MPS",
          "MX-5",
          "626",
          "Axela",
          "Millenia",
          "Capella",
          "B-Series",
          "CX-8",
        ],
        "Mercedes-Benz": [
          "GLE-класс AMG Coupe",
          "G-класс AMG",
          "E-класс",
          "X-класс",
          "GLE-класс Coupe",
          "GLS-класс AMG",
          "M-класс",
          "GLE-класс",
          "GLC-класс",
          "GLC-класс AMG Coupe",
          "C-класс",
          "S-класс",
          "GLS-класс",
          "V-класс",
          "G-класс",
          "W124",
          "GLK-класс",
          "CLA-класс",
          "CLS-класс",
          "A-класс AMG",
          "B-класс",
          "Sprinter",
          "GLA-класс",
          "GLA-класс AMG",
          "Vito",
          "CLC-класс",
          "GLC-класс Coupe",
          "GL-класс",
          "A-класс",
          "SLK-класс",
          "Maybach GLS-класс",
          "R-класс",
          "C-класс AMG",
          "190 (W201)",
          "SL-класс",
          "W123",
          "T1",
          "CLK-класс",
          "EQE",
          "CL-класс",
          "GLB-класс",
          "Vario",
          "M-класс AMG",
          "AMG GT",
          "GL-класс AMG",
          "Maybach S-класс",
          "GLE-класс AMG",
          "E-класс AMG",
          "Sprinter Classic",
        ],
        Mitsubishi: [
          "Outlander",
          "Lancer",
          "Pajero",
          "ASX",
          "Pajero Sport",
          "Galant",
          "L200",
          "Lancer Ralliart",
          "Montero Sport",
          "Space Star",
          "Eclipse Cross",
          "Lancer Evolution",
          "Pajero Pinin",
          "Colt",
          "Carisma",
          "i",
          "Pajero iO",
          "Airtrek",
          "Lancer Cedia",
          "Pajero Junior",
          "Legnum",
          "Space Wagon",
          "Xpander",
          "EK Custom",
          "L300",
          "Eclipse",
          "Pajero Mini",
          "Chariot",
          "Xpander Cross",
          "Delica",
          "Fuso Canter",
          "Lancer Cargo",
        ],
        Nissan: [
          "Qashqai",
          "Juke",
          "X-Trail",
          "Almera Classic",
          "Terrano",
          "Tiida",
          "Almera",
          "Note",
          "Murano",
          "Cube",
          "March",
          "200SX",
          "Teana",
          "Micra",
          "Patrol",
          "Qashqai+2",
          "Pathfinder",
          "Navara",
          "Serena",
          "Sentra",
          "Primera",
          "Skyline",
          "Rogue Sport",
          "Rogue",
          "Maxima",
          "Cefiro",
          "300ZX",
          "Liberty",
          "Bluebird",
          "AD",
          "Presage",
          "NP300",
          "Bluebird Sylphy",
          "NV200",
          "Altima",
          "Dayz Roox",
          "Dayz",
          "Sunny",
          "Versa",
          "Quest",
          "Pulsar",
          "Wingroad",
          "Elgrand",
        ],
        Opel: [
          "Astra",
          "Mokka",
          "Astra GTC",
          "Meriva",
          "Corsa",
          "Antara",
          "Insignia",
          "Zafira",
          "Vectra",
          "Grandland X",
          "Frontera",
          "Vivaro",
          "Combo",
          "Agila",
          "Kapitan",
          "Zafira Life",
          "Kadett",
          "Ascona",
        ],
        Peugeot: [
          "206",
          "308",
          "107",
          "408",
          "2008",
          "Traveller",
          "Boxer",
          "4008",
          "3008",
          "208",
          "4007",
          "607",
          "307",
          "Partner",
          "508",
          "406",
          "207",
          "407",
          "207i",
          "301",
        ],
        Renault: [
          "Duster",
          "Logan",
          "Arkana",
          "Logan Stepway",
          "Sandero",
          "Megane",
          "Kaptur",
          "Symbol",
          "Talisman",
          "Sandero Stepway",
          "Fluence",
          "Espace",
          "Clio",
          "Dokker",
          "Master",
          "Koleos",
          "Latitude",
          "Kangoo",
          "Laguna",
          "Grand Scenic",
          "Scenic",
          "Kadjar",
          "Trafic",
          "Captur",
          "19",
          "11",
        ],
        Skoda: [
          "Yeti",
          "Rapid",
          "Octavia",
          "Superb",
          "Kodiaq",
          "Fabia",
          "Kamiq",
          "Roomster",
          "Karoq",
          "Kodiaq GT",
          "Octavia RS",
        ],
        Suzuki: [
          "SX4",
          "Baleno",
          "Grand Vitara",
          "Ertiga",
          "Jimny",
          "Alto",
          "Vitara",
          "Liana",
          "Ignis",
          "Wagon R",
          "Aerio",
          "Swift",
          "Alto Lapin",
          "Escudo",
          "Cultus Wagon",
          "Hustler",
          "Solio",
          "Cultus",
          "Spacia",
          "Fronx",
        ],
        Tank: ["500", "300", "400", "Toyota"],
        Toyota: [
          "Land Cruiser",
          "Corolla",
          "Hilux",
          "Camry",
          "C-HR",
          "RAV4",
          "Grand Highlander",
          "Land Cruiser Prado",
          "Prius",
          "Highlander",
          "Vanguard",
          "Tank",
          "Auris",
          "Venza",
          "Avensis",
          "Corolla Ceres",
          "Estima",
          "Carina",
          "Chaser",
          "Verso",
          "Vista Ardeo",
          "Fortuner",
          "Aqua",
          "Vitz",
          "Town Ace",
          "Corolla Levin",
          "Corolla Fielder",
          "Carina E",
          "Cresta",
          "iQ",
          "Sprinter Trueno",
          "Passo",
          "Rush",
          "Veloz",
          "Crown",
          "Altezza",
          "4Runner",
          "Hiace",
          "bB",
          "Hilux Surf",
          "Celica",
          "Alphard",
          "Vista",
          "Mark II",
          "Funcargo",
          "Crown Majesta",
          "Town Ace Noah",
          "GT86",
          "Matrix",
          "Tundra",
          "MasterAce",
          "Starlet",
          "Porte",
          "Roomy",
          "Vellfire",
          "FJ Cruiser",
          "Yaris",
          "Sprinter Marino",
          "Sprinter Carib",
          "Sprinter",
          "Noah",
          "Sienta",
          "Carina ED",
          "Granvia",
          "Voxy",
          "Mark X",
          "Premio",
          "Estima Lucida",
          "Corolla Rumion",
          "Corolla Axio",
          "ToyoAce",
          "Lite Ace Noah",
          "Opa",
          "Echo",
          "Raize",
          "Ractis",
        ],
        Volkswagen: [
          "Tiguan",
          "Polo",
          "Jetta",
          "Multivan",
          "Transporter",
          "Amarok",
          "Golf",
          "Touareg",
          "Golf GTI",
          "Passat",
          "Teramont",
          "Golf Plus",
          "Tiguan Allspace",
          "Touran",
          "Taos",
          "Teramont X",
          "California",
          "Tayron",
          "Passat CC",
          "Caddy",
          "Caravelle",
          "Pointer",
          "Scirocco",
          "Bora",
          "New Beetle",
          "ID.6",
          "Lupo",
          "LT",
          "Crafter",
          "Talagon",
          "T-Cross",
          "Atlas Cross Sport",
          "Tayron X",
        ],
        "ВАЗ (LADA)": [
          "Granta",
          "Vesta Cross",
          "Priora",
          "Kalina",
          "XRAY Cross",
          "Kalina Cross",
          "Vesta",
          "2115 Samara",
          "Largus",
          "2114 Samara",
          "Niva Legend",
          "Largus Cross",
          "1111 Ока",
          "2113 Samara",
          "2104",
          "2110",
          "Niva Travel",
          "2121 (4x4) Urban",
          "21099",
          "2112",
          "2107",
          "XRAY",
          "2329",
          "2111",
          "4x4 (Нива)",
          "2106",
          "2105",
          "2108",
          "Granta Cross",
          "2109",
          "Niva Legend Bronto",
          "Niva",
          "2131 (4x4) Urban",
        ],
        ГАЗ: [
          "ГАЗель 3302",
          "ГАЗель Next",
          "Соболь 2217",
          "ГАЗель 2705",
          "Соболь 2752",
          "ГАЗель 2747",
          "ГАЗель 3221",
          "ГАЗель 33023",
          "21 Волга",
          "3102 Волга",
          "3110 Волга",
          "Соболь NN",
          "67",
          "69",
          "24 Волга",
          "31105 Волга",
          "Volga Siber",
          "Соболь 2310",
          "13 Чайка",
          "31029 Волга",
          "А",
          "М-20 Победа",
          "310221 Волга",
          "ГАЗель NN",
        ],
        УАЗ: [
          "39094",
          "3909",
          "Patriot",
          "3962",
          "3303",
          "2206",
          "31514",
          "Hunter",
          "Pickup",
          "31512",
          "469",
          "29891",
          "3741",
          "Профи",
          "452 Буханка",
          "3160",
          "39095",
          "Карго",
          "31519",
          "Симбир",
        ],
      },
      bodyTypes: [
        "внедорожник",
        "седан",
        "хетчбэк",
        "купе",
        "лифтбек",
        "универсал",
        "кабриолет",
        "минивэн",
        "пикап",
        "фургон",
        "микроавтобус",
      ],
      fuelTypes: ["бензин", "дизель", "электро", "гибрид", "газ"],
      driveTypes: ["полный", "передний", "задний"],
      transmissionTypes: ["AT", "AMT", "CVT", "MT"],
    };
  },
  methods: {
    updateModels() {
      this.form.model = "";
    },
    async calculatePrice() {
      try {
        const response = await fetch("http://127.0.0.1:5000/api/predict", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(this.form),
        });
        const data = await response.json();
        this.predictedPrice = data.price;
      } catch (error) {
        console.error("Ошибка при расчете стоимости:", error);
      }
    },
  },
};
</script>

<style scoped>
.car-price-form {
  max-width: 500px;
  margin: 30px auto;
  padding: 20px;
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  font-family: Arial, sans-serif;
}

h2 {
  text-align: center;
  color: #333;
  margin-bottom: 20px;
}

.form-group {
  display: flex;
  flex-direction: column;
  margin-bottom: 15px;
}

.form-group label {
  font-weight: bold;
  color: #555;
  margin-bottom: 5px;
}

select,
input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 5px;
  font-size: 14px;
}

.checkbox-group {
  flex-direction: row;
  align-items: center;
}

.checkbox-group input {
  width: auto;
  margin-left: 10px;
}

button {
  background: #007bff;
  color: white;
  padding: 12px;
  border: none;
  border-radius: 5px;
  font-size: 16px;
  cursor: pointer;
  transition: background 0.3s;
  width: 100%;
}

button:hover {
  background: #0056b3;
}

.result {
  text-align: center;
  margin-top: 20px;
  padding: 15px;
  background: #f8f9fa;
  border-radius: 5px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.price {
  font-size: 22px;
  font-weight: bold;
  color: #28a745;
}

@media (max-width: 600px) {
  .car-price-form {
    width: 90%;
    padding: 15px;
  }

  select,
  input,
  button {
    font-size: 14px;
  }
}
</style>
