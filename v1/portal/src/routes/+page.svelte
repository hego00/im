<script>
	let irish_evidence_types = [
		{ id: 1, text: `Irish Birth Cert` },
		{ id: 2, text: `Irish Passport` }
	];

	let french_evidence_types = [
		{ id: 1, text: `French Birth Cert` },
		{ id: 2, text: `French Passport` }
	];

	let dsd_repos = [
		{ id: 1, country: `IE`, evidence_types: irish_evidence_types, text: `DSD Repo IE` },
		{ id: 2, country: `FR`, evidence_types: french_evidence_types, text: `DSD Repo FR` }
	];

	let requirements = [
		{ id: `R1`, text: `Requirement 1` },
		{ id: `R2`, text: `Requirement 2` },
		{ id: `R3`, text: `Requirement 3` }
	];

	let procedures = [
		{ id: `P1`, text: `Procedure 1`, requirements: `R1,R2,R3` },
		{ id: `P2`, text: `Procedure 2`, requirements: `R1,R2` },
		{ id: `P3`, text: `Procedure 3`, requirements: `R1` }
	];

	/**
	 * @type {{ id: any; text: any; }}
	 */
	let selected;

	let answer = '';

	function handleSubmit() {
		alert(`answered question ${selected.id} (${selected.text}) with "${answer}"`);
	}
</script>

<h2>Insecurity questions</h2>
<p>Procedure</p>
<form on:submit|preventDefault={handleSubmit}>
	<select bind:value={selected} on:change={() => (answer = '')}>
		{#each procedures as procedure}
			<option value={procedure}>
				{procedure.text}
			</option>
		{/each}
	</select>

	<input bind:value={answer} />

	<button disabled={!answer} type="submit"> Submit </button>
</form>

<p>selected question {selected ? selected.id : '[waiting...]'}</p>

<style>
	input {
		display: block;
		width: 500px;
		max-width: 100%;
	}
</style>
