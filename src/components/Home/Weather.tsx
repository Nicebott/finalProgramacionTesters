import { Cloud, CloudRain, Sun, Wind } from 'lucide-react';

const provinces = [
  {
    id: 1,
    name: 'Santo Domingo',
    temp: '28°C',
    condition: 'Parcialmente nublado',
    humidity: '75%',
    wind: '12 km/h',
    icon: Cloud,
  },
  {
    id: 2,
    name: 'Santiago',
    temp: '26°C',
    condition: 'Lluvia ligera',
    humidity: '85%',
    wind: '15 km/h',
    icon: CloudRain,
  },
  {
    id: 3,
    name: 'Punta Cana',
    temp: '30°C',
    condition: 'Soleado',
    humidity: '65%',
    wind: '10 km/h',
    icon: Sun,
  },
  {
    id: 4,
    name: 'La Romana',
    temp: '29°C',
    condition: 'Parcialmente nublado',
    humidity: '72%',
    wind: '13 km/h',
    icon: Cloud,
  },
];

export function Weather() {
  return (
    <section id="weather" className="py-16 bg-gradient-to-b from-white to-gray-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-12">
          <h2 className="text-4xl md:text-5xl font-bold text-gray-900 mb-4">
            Clima por Provincia
          </h2>
          <p className="text-xl text-gray-600">
            Mantente informado sobre el clima en las principales regiones
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {provinces.map((province) => {
            const Icon = province.icon;
            return (
              <div
                key={province.id}
                className="bg-white rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 p-6 border border-gray-100"
              >
                <div className="flex items-center justify-between mb-4">
                  <h3 className="text-lg font-bold text-gray-900">
                    {province.name}
                  </h3>
                  <Icon className="w-8 h-8 text-teal-600" />
                </div>

                <div className="mb-6">
                  <p className="text-4xl font-bold text-gray-900 mb-2">
                    {province.temp}
                  </p>
                  <p className="text-gray-600 text-sm">{province.condition}</p>
                </div>

                <div className="space-y-3 border-t border-gray-200 pt-4">
                  <div className="flex items-center justify-between text-sm">
                    <span className="text-gray-600">Humedad</span>
                    <span className="font-semibold text-gray-900">
                      {province.humidity}
                    </span>
                  </div>
                  <div className="flex items-center justify-between text-sm">
                    <div className="flex items-center space-x-2">
                      <Wind className="w-4 h-4 text-gray-600" />
                      <span className="text-gray-600">Viento</span>
                    </div>
                    <span className="font-semibold text-gray-900">
                      {province.wind}
                    </span>
                  </div>
                </div>
              </div>
            );
          })}
        </div>

        <div className="mt-12 bg-teal-50 border-2 border-teal-200 rounded-2xl p-8 text-center">
          <p className="text-gray-700">
            Los datos de clima se actualizan cada 30 minutos. Para información
            detallada, consulta el{' '}
            <a
              href="#"
              className="text-teal-600 font-semibold hover:text-teal-800 transition-colors"
            >
              Servicio Meteorológico Nacional
            </a>
          </p>
        </div>
      </div>
    </section>
  );
}
