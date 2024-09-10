/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./resources/**/*.blade.php",
    "./resources/**/*.js",
    "./resources/**/*.vue",
  ],
  theme: {
    extend: {
      boxShadow: {
        connectyed: '0 0 0 1px #e1e1e1',
      },
      colors: {
        'connectyed-header': {
          light: '#333333',
          DEFAULT: '#333333',
          dark: '#FFFFFF',
        },
        'connectyed-body': {
          light: '#f4f2ee',
          DEFAULT: '#f4f2ee',
          dark: '#f1f7fe',
        },
        'connectyed-button': {
          light: '#e7dccf',
          DEFAULT: '#E0FFFF',
          dark: '#4A4A4A',
        },
        'connectyed-button-hover': {
          light: '#4A4A4A',
          DEFAULT: '#4A4A4A',
          dark: '#e7dccf',
        },
        'connectyed-card': {
          light: '#F5F5F5',
          DEFAULT: '#F5F5F5',
          dark: '#E0E0E0',
        },
        'connectyed-card-border': {
          light: '#E0E0E0',
          DEFAULT: '#E0E0E0',
          dark: '#F5F5F5',
        },
        'connectyed-border': {
          light: '#D3D3D3',
          DEFAULT: '#D3D3D3',
          dark: '#D3D3D3',
        },
        'connectyed-link': {
          light: '#007BFF',
          DEFAULT: '#007BFF',
          dark: '#0056b3',
        },
      }, 
    },
  },
  plugins: [],
}

