// @ts-check
import { defineConfig } from 'astro/config';

import tailwindcss from '@tailwindcss/vite';

import sitemap from '@astrojs/sitemap';

// https://astro.build/config
export default defineConfig({
  site: 'https://mimhoff.com',

  vite: {
    plugins: [tailwindcss()]
  },

  // The games are separate Vite builds deployed next to this site, so list them by hand.
  // Test builds (mystery-machine, chang-and-me) stay out until they're public.
  integrations: [
    sitemap({
      customPages: [
        'https://mimhoff.com/wordlock/',
        'https://mimhoff.com/duck-tictactoe/',
        'https://mimhoff.com/chain-4/',
      ],
    }),
  ]
});
