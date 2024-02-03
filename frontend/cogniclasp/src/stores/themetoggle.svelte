<script>
    import { theme } from '../stores/themeStore';
    
    // Function to toggle the theme
    function toggleTheme() {
      theme.update(current => current === 'light' ? 'dark' : 'light');
    }
  </script>
  
  <!-- 
    The `class:dark-mode` directive applies the "dark-mode" class to the button 
    when the `$theme` store value is 'dark'. 
  -->
  <button 
  class="theme-toggle" 
  on:click={toggleTheme}
  class:dark-mode={$theme === 'dark'}>
  <!-- The circle that slides left/right -->
  <span class="toggle-circle"></span>
</button>
  
  <style>
    .theme-toggle {
      cursor: pointer;
      position: relative;
      display: inline-block;
      width: 60px; /* Width of the toggle */
      height: 30px; /* Height of the toggle */
      background-color: var(--toggle-bg-color, #f6f8fa); /* Light grey background or use CSS var */
      border-radius: 30px; /* Full pill shape to make it oval */
      transition: background-color 0.3s; /* Smooth transition for color */
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2); /* Subtle shadow for depth */
    }
  
    /* Circle inside the toggle to slide left/right */
    .theme-toggle .toggle-circle {
      content: '';
      position: absolute;
      top: 2px; /* Slightly inside the main toggle container */
      left: 2px; /* Slightly inside the main toggle container */
      width: 26px; /* Circle size */
      height: 26px; /* Circle size */
      background-color: white; /* Circle color */
      border-radius: 50%; /* Full circle */
      transition: transform 0.3s; /* Smooth transition for sliding effect */
      z-index: 2;
    }
  
    /* Sun and moon icons within the toggle */
    .theme-toggle:before, .theme-toggle:after {
      position: absolute;
      top: 50%;
      transform: translate(0, -50%);
      transition: opacity 0.3s;
      font-size: 18px; /* Adjust size as needed */
      line-height: 30px; /* Vertically center */
      color: var(--icon-color, #ffcc00); /* Sun/Moon color or use CSS var */
    }
  
    .theme-toggle:before {
      content: '☀'; /* Sun icon */
      left: 10px; /* Position the sun icon inside the toggle */
      opacity: 1;
    }
  
    .theme-toggle:after {
      content: '🌜'; /* Moon icon */
      right: 10px; /* Position the moon icon inside the toggle */
      opacity: 0;
    }
  
    /* Adjust the styles when dark mode is active */
    .theme-toggle.dark-mode .toggle-circle {
      transform: translateX(30px); /* Slide the circle to the right */
    }
  
    .theme-toggle.dark-mode:before {
      opacity: 0;
    }
  
    .theme-toggle.dark-mode:after {
      opacity: 1;
    }
  </style>
  