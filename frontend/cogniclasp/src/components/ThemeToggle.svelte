<script>
    import { theme } from '../stores/themeStore';
  
    function toggleTheme() {
      theme.update(t => t === 'light' ? 'dark' : 'light');
    }
  </script>
  
  <button on:click={toggleTheme}>
    Toggle Theme
  </button>
  