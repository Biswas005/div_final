<script>
  import ThemeToggle from './ThemeToggle.svelte';
  import { user } from '../stores/userStore';

  // This function would be replaced with a real login function
  function login() {
    user.update(u => {
      u.loggedIn = true;
      u.name = 'User_name'; // Placeholder, would be retrieved from the login process
      return u;
    });
  }
</script>

<nav class="navbar">
  <div class="search-container">
    <input type="text" placeholder="Search..." />
  </div>
  <div class="toggle-container">
    <ThemeToggle />
  </div>
  <div class="nav-links">
    <a href="/models" class="nav-link">Models</a>
    <a href="/dataset" class="nav-link">Dataset</a>
    <a href="/login" class="nav-link">Login</a>
  </div>
</nav>

<style>
  .navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem;
    background-color: #333; /* Adjust the color to match your theme */
  }

  .search-container input {
    padding: 0.5rem;
    border-radius: 4px;
    border: none;
    background-color: #555; /* Slightly lighter than navbar for contrast */
    color: white;
  }

  .toggle-container {
    display: flex;
    align-items: center; /* Center vertically in the nav bar */
    justify-content: center; /* Center horizontally if it's the only element within */
    padding: 0.5rem;
    border-radius: 4px;
    background-color: #444; /* Slightly different background to stand out */
  }

  /* Assuming .theme-toggle styling is defined in ThemeToggle.svelte, 
     so no need to repeat it here, it should be encapsulated within the component. */

  .nav-links {
    /* Align the links to the right */
    display: flex;
    gap: 1rem; /* Spacing between links */
  }

  .nav-link {
    color: white;
    text-decoration: none;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    transition: background-color 0.3s;
  }

  .nav-link:hover {
    background-color: #555; /* Highlight on hover */
  }
</style>
