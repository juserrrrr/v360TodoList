/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*',
  ],
  theme: {
    extend: {},
  },
  plugins: [
    function ({ addUtilities }) {
      addUtilities({
        '.scrollbar-hide::-webkit-scrollbar': {
          display: 'none',
        },
        '.scrollbar-hide': {
          '-ms-overflow-style': 'none', // IE and Edge
          'scrollbar-width': 'none', // Firefox
        },
        '.scrollbar-thin::-webkit-scrollbar': {
          width: '8px',
        },
        '.scrollbar-thin::-webkit-scrollbar-thumb': {
          backgroundColor: '#6b46c1', // Cor principal ou qualquer cor desejada
          borderRadius: '6px',
        },
      });
    },
  ],
};