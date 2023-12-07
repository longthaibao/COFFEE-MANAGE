/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        'mainBlue':'#0F6CBF', //Ex: For main Butoon, text
        'lightBlue':{
          300:'rgba(128, 221, 238, 1)',  // Ex: Background blue
          200:'rgba(128, 221, 238, 0.5)', // Ex: Hover on lightBlue-200
        },
        'darkBlue':'#164399', // Ex: footer
        'textGray':'#374151', // Ex:text
        'lightGray':'#f5f5f5', //Ex: Background Gray
        'mainRed':'#dc2626',  // Ex: X icon
        'lightRed':'#fee2e2', // Ex: Background of cancel button
        'mainOrange':'orange-600' //Ex warnning icon

      },
    },
    
  },
  plugins: [],
}