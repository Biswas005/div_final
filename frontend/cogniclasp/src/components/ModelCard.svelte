<script>
  export let model;
  import { createEventDispatcher } from 'svelte';

  const dispatch = createEventDispatcher();

  function handleSelect() {
    dispatch('select', model);
  }
  
  // Accessibility: Add tabindex to make the div focusable
  // and role to indicate it's an interactive element.
  let tabIndex = 0; // 0 will order the element according to the document's source order
</script>

<!-- 
  Accessibility improvements:
  - role="button" indicates the div acts as a button
  - tabindex="0" makes the div focusable
  - aria-label provides an accessible name for the element
-->
<div class="model-card" 
     role="button" 
     tabindex={tabIndex} 
     on:click={handleSelect} 
     on:keydown={(event) => event.key === 'Enter' && handleSelect()}
     aria-label={`Model: ${model.name}`}>
  <h3 class="model-name">{model.name}</h3>
  <p class="model-description">{model.description}</p>
  <!-- You can add more details here if needed -->
</div>

<style>
  .model-card {
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 1rem;
    margin-bottom: 1rem;
    transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
    cursor: pointer;
  }

  .model-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }

  .model-name {
    font-size: 1.25rem;
    color: var(--primary-color);
    margin-bottom: 0.5rem;
  }

  .model-description {
    font-size: 1rem;
    color: var(--text-color);
    line-height: 1.4;
  }
</style>
