<script>
	import Navbar from './components/Navbar.svelte';
	import ModelCard from './components/ModelCard.svelte';
	import ModelDetail from './components/ModelDetail.svelte';
	import UploadModel from './components/UploadModel.svelte';
	import { user } from './stores/userStore';
	import { theme } from './stores/themeStore';
	
	let currentModel = null; // This would be set when a user selects a model
  </script>
  
  <div class={theme}>
	<Navbar />
	
	{#if $user.loggedIn}
	  <UploadModel />
	  {#if currentModel}
		<ModelDetail {currentModel} />
	  {:else}
		<!-- List the models -->
		{#each $user.models as model}
		  <ModelCard {model} on:click={() => currentModel = model} />
		{/each}
	  {/if}
	{:else}
	  <!-- Show something else for not logged-in users -->
	  <p>Please log in to view models.</p>
	{/if}
  </div>
  
  <style>
	:root {
	  /* Light theme colors */
	  --background-color: #ffffff;
	  --text-color: #000000;
	  --primary-color: #007bff;
	  --secondary-color: #6c757d;
	}
  
	.dark {
	  /* Dark theme colors */
	  --background-color: #121212;
	  --text-color: #ffffff;
	  --primary-color: #1b95e0;
	  --secondary-color: #343a40;
	}

  
	.btn-secondary {
	  background-color: var(--secondary-color);
	}
  
	/* Additional styling for other elements can go here, utilizing the CSS variables */
  </style>
  