<script>
  import { createEventDispatcher } from 'svelte';
  export let model;

  const dispatch = createEventDispatcher();

  // Example function to handle deploying the model
  async function deployModel() {
    // This function would actually call the backend service to deploy the model
    console.log(`Deploying model: ${model.name}`);
    
    // Dispatch an event indicating that the model is being deployed
    dispatch('deploy', model);
  }

  // Example function to edit the model, only available to the owner
  function editModel() {
    // This would open up a form or modal allowing the owner to edit the model details
    dispatch('edit', model);
  }
</script>

<div class="model-detail">
  <h2>{model.name}</h2>
  <p>{model.description}</p>
  
  <button on:click={deployModel}>Deploy</button>
  {#if model.isOwner}
    <button on:click={editModel}>Edit</button>
  {/if}
</div>

<style>
  .model-detail {
    background-color: var(--background-color);
    color: var(--text-color);
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin: 20px 0;
    display: flex;
    flex-direction: column;
    max-width: 600px;
  }

  .model-detail h2 {
    font-size: 1.5em;
    margin-bottom: 0.5em;
  }

  .model-detail p {
    line-height: 1.6;
    margin-bottom: 1em;
  }

  .model-detail button {
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-top: 10px;
    font-weight: bold;
    background-color: var(--primary-color);
    color: white;
    transition: background-color 0.3s ease;
  }

  .model-detail button:hover {
    background-color: var(--link-hover-color);
  }

  .model-detail button:disabled {
    background-color: var(--secondary-color);
    cursor: not-allowed;
  }

  /* If you have any additional elements inside your detail view, add styles for them here */
</style>

