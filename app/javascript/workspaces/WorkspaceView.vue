<template>
	<a class="workspace-card" :href="`/workspaces/${workspace.id}`">
		{{ workspace.name }}
	</a>
</template>

<script>
export default {
	name: 'WorkspaceView',
	props: {
		workspace: { type: Object, required: true }
	}
}
</script>

<style lang="scss" scoped>
.workspace-card {
	width: 150px;
	height: 100px;
	display: flex;
	justify-content: center;
	align-items: center;
	border: 1px solid black;
	border-radius: 10px;
	text-decoration: none;
	color: black;
	margin-left: 10px;
}
</style>
