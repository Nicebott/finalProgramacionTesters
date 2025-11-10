import { TrendingUp, TrendingDown } from 'lucide-react';

const rates = [
  {
    id: 1,
    pair: 'USD/DOP',
    rate: '58.50',
    change: '+0.25',
    direction: 'up',
    flag: '🇺🇸',
  },
  {
    id: 2,
    pair: 'EUR/DOP',
    rate: '63.80',
    change: '-0.15',
    direction: 'down',
    flag: '🇪🇺',
  },
  {
    id: 3,
    pair: 'GBP/DOP',
    rate: '74.20',
    change: '+0.10',
    direction: 'up',
    flag: '🇬🇧',
  },
  {
    id: 4,
    pair: 'CAD/DOP',
    rate: '42.30',
    change: '+0.05',
    direction: 'up',
    flag: '🇨🇦',
  },
];

export function ExchangeRates() {
  return (
    <section id="exchange-rates" className="py-16 bg-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-12">
          <h2 className="text-4xl md:text-5xl font-bold text-gray-900 mb-4">
            Tasas de Cambio en Vivo
          </h2>
          <p className="text-xl text-gray-600">
            Consulta las tasas de cambio actualizadas en tiempo real
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          {rates.map((rate) => (
            <div
              key={rate.id}
              className="bg-gradient-to-br from-gray-50 to-gray-100 rounded-2xl p-6 border border-gray-200 hover:border-teal-400 transition-all duration-300"
            >
              <div className="flex items-center justify-between mb-4">
                <div className="text-3xl">{rate.flag}</div>
                <div
                  className={`flex items-center space-x-1 px-3 py-1 rounded-full ${
                    rate.direction === 'up'
                      ? 'bg-green-100 text-green-700'
                      : 'bg-red-100 text-red-700'
                  }`}
                >
                  {rate.direction === 'up' ? (
                    <TrendingUp className="w-4 h-4" />
                  ) : (
                    <TrendingDown className="w-4 h-4" />
                  )}
                  <span className="text-sm font-semibold">{rate.change}</span>
                </div>
              </div>

              <p className="text-gray-700 font-semibold mb-2">{rate.pair}</p>
              <p className="text-3xl font-bold text-gray-900">{rate.rate}</p>
              <p className="text-gray-600 text-sm mt-2">Actualizado hace 2 min</p>
            </div>
          ))}
        </div>

        <div className="bg-gradient-to-r from-teal-600 to-teal-800 text-white rounded-2xl p-8">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 text-center">
            <div>
              <p className="text-teal-100 mb-2">Tasa oficial</p>
              <p className="text-3xl font-bold">58.50 DOP</p>
            </div>
            <div>
              <p className="text-teal-100 mb-2">Variación del día</p>
              <p className="text-3xl font-bold">+0.35%</p>
            </div>
            <div>
              <p className="text-teal-100 mb-2">Última actualización</p>
              <p className="text-3xl font-bold">14:32 hrs</p>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
