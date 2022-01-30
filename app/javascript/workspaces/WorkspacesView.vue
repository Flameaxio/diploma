<template>
	<v-app>
		<v-container>
			<div class="workspaces-wrapper">
				<workspace-view
					v-for="workspace in workspaces"
					:key="workspace.id"
					:workspace="workspace"
				/>
			</div>
		</v-container>
	</v-app>
</template>

<script>
import WorkspaceView from './WorkspaceView.vue'
import { mapActions, mapState } from 'vuex'

export default {
	name: 'WorkspacesView',
	components: { WorkspaceView },
	data() {
		return {
		}
	},
	computed: {
		...mapState(['workspaces'])
	},
	methods: {
		...mapActions(['loadWorkspaces']),
		async loadData() {
			await this.loadWorkspaces()
		}
	},
	mounted() {
		this.loadData()
	}
}
</script>

<style lang="scss" scoped>
.workspaces-wrapper {
	display: flex;
	flex-wrap: wrap;
}
</style>
