import { defineConfig } from 'vitepress';

export default defineConfig({
  title: 'SilkCircuit',
  description: 'A vibrant cyberpunk color system for Neovim, VS Code, terminals, browsers, and 30 CLI tools',

  base: '/silkcircuit/',

  head: [
    ['link', { rel: 'icon', href: '/silkcircuit/favicon.svg' }],
    ['meta', { name: 'theme-color', content: '#e135ff' }],
    ['meta', { name: 'og:type', content: 'website' }],
    ['meta', { name: 'og:title', content: 'SilkCircuit - Electric Meets Elegant' }],
    ['meta', { name: 'og:description', content: 'A vibrant cyberpunk color system for Neovim, VS Code, terminals, browsers, and 30 CLI tools. WCAG AA compliant with 5 variants.' }],
    ['meta', { name: 'og:image', content: '/silkcircuit/og-image.png' }],
    ['meta', { name: 'twitter:card', content: 'summary_large_image' }],
  ],

  themeConfig: {
    logo: '/logo.png',
    siteTitle: 'SilkCircuit',

    nav: [
      { text: 'Guide', link: '/guide/' },
      { text: 'Variants', link: '/variants/' },
      { text: 'Design', link: '/design/' },
      { text: 'Extras', link: '/extras/' },
      { text: 'Reference', link: '/reference/' }
    ],

    sidebar: {
      '/guide/': [
        {
          text: 'Getting Started',
          items: [
            { text: 'Introduction', link: '/guide/' },
            { text: 'Installation', link: '/guide/installation' },
            { text: 'Configuration', link: '/guide/configuration' },
            { text: 'Theme Variants', link: '/guide/variants' },
            { text: "How It's Built", link: '/guide/architecture' },
          ]
        }
      ],
      '/variants/': [
        {
          text: 'Theme Variants',
          items: [
            { text: 'Overview', link: '/variants/' },
            { text: 'Neon', link: '/variants/neon' },
            { text: 'Vibrant', link: '/variants/vibrant' },
            { text: 'Soft', link: '/variants/soft' },
            { text: 'Glow', link: '/variants/glow' },
            { text: 'Dawn', link: '/variants/dawn' },
          ]
        }
      ],
      '/design/': [
        {
          text: 'Design System',
          items: [
            { text: 'Overview', link: '/design/' },
            { text: 'Color System', link: '/design/colors' },
            { text: 'Typography', link: '/design/typography' },
            { text: 'Semantic Mapping', link: '/design/semantic' },
          ]
        },
        {
          text: 'Guidelines',
          items: [
            { text: 'Accessibility', link: '/design/accessibility' },
            { text: 'Best Practices', link: '/design/best-practices' },
          ]
        }
      ],
      '/extras/': [
        {
          text: 'Extras',
          items: [
            { text: 'Overview', link: '/extras/' },
          ]
        },
        {
          text: 'Editors',
          items: [
            { text: 'VS Code', link: '/extras/vscode' },
            { text: 'Helix', link: '/extras/helix' },
            { text: 'AstroNvim', link: '/extras/astronvim' },
            { text: 'Neovim Plugins', link: '/extras/plugins' },
          ]
        },
        {
          text: 'Terminals',
          items: [
            { text: 'Overview', link: '/extras/terminals' },
            { text: 'Alacritty', link: '/extras/alacritty' },
            { text: 'foot', link: '/extras/foot' },
            { text: 'Ghostty', link: '/extras/ghostty' },
            { text: 'iTerm2', link: '/extras/iterm2' },
            { text: 'Kitty', link: '/extras/kitty' },
            { text: 'Warp', link: '/extras/warp' },
            { text: 'WezTerm', link: '/extras/wezterm' },
            { text: 'Windows Terminal', link: '/extras/windows-terminal' },
          ]
        },
        {
          text: 'Multiplexers',
          items: [
            { text: 'tmux', link: '/extras/tmux' },
            { text: 'Zellij', link: '/extras/zellij' },
          ]
        },
        {
          text: 'Shell & CLI',
          items: [
            { text: 'Starship', link: '/extras/starship' },
            { text: 'fzf', link: '/extras/fzf' },
            { text: 'bat', link: '/extras/bat' },
            { text: 'lsd', link: '/extras/lsd' },
            { text: 'procs', link: '/extras/procs' },
            { text: 'fastfetch', link: '/extras/fastfetch' },
            { text: 'Atuin', link: '/extras/atuin' },
          ]
        },
        {
          text: 'Git',
          items: [
            { text: 'Git', link: '/extras/git' },
            { text: 'lazygit', link: '/extras/lazygit' },
          ]
        },
        {
          text: 'System & Desktop',
          items: [
            { text: 'btop', link: '/extras/btop' },
            { text: 'k9s', link: '/extras/k9s' },
            { text: 'dmesg', link: '/extras/dmesg' },
            { text: 'COSMIC Desktop', link: '/extras/cosmic' },
          ]
        },
        {
          text: 'Apps',
          items: [
            { text: 'Chrome', link: '/extras/chrome' },
            { text: 'Slack', link: '/extras/slack' },
          ]
        }
      ],
      '/reference/': [
        {
          text: 'Reference',
          items: [
            { text: 'Overview', link: '/reference/' },
            { text: 'Commands', link: '/reference/commands' },
            { text: 'Colors', link: '/reference/colors' },
            { text: 'Highlight Groups', link: '/reference/highlights' },
            { text: 'Health Check', link: '/reference/health' },
          ]
        }
      ]
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/hyperb1iss/silkcircuit' }
    ],

    editLink: {
      pattern: 'https://github.com/hyperb1iss/silkcircuit/edit/main/docs/:path',
      text: 'Edit this page on GitHub'
    },

    search: {
      provider: 'local'
    },

    footer: {
      message: 'Released under the MIT License.',
      copyright: '✦ Built with obsession by <a href="https://hyperbliss.tech" target="_blank" rel="noopener"><strong>Hyperbliss Technologies</strong></a> ✦'
    }
  },

  markdown: {
    theme: {
      light: 'github-light',
      dark: 'one-dark-pro'
    },
    lineNumbers: true
  }
});
