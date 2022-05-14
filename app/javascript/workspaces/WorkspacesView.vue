<template>
	<v-app>
		<v-container>
			<div class="workspaces-wrapper">
				<workspace-view
					v-for="workspace in workspaces"
					:key="workspace.id"
					:workspace="workspace"
				/>
				<div class="workspace-card" @click="isCreating = true">
					<v-icon x-large v-if="!isCreating">mdi-plus-circle</v-icon>
					<div v-else class="creation">
						<v-text-field dense v-model="name" />
						<v-btn color="primary" x-small @click="save">Save</v-btn>
					</div>
				</div>
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
			isCreating: false,
			name: ''
		}
	},
	computed: {
		...mapState(['workspaces'])
	},
	methods: {
		...mapActions(['loadWorkspaces', 'createWorkspace']),
		async loadData() {
			await this.loadWorkspaces()
		},
		async save() {
			if (!this.name) return

			await this.createWorkspace({ name: this.name })
			this.isCreating = false
			this.name = ''
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

.workspace-card {
	width: 200px;
	height: 100px;
	display: flex;
	justify-content: center;
	align-items: center;
	border: 1px solid black;
	border-radius: 10px;
	text-decoration: none;
	color: black;
	margin-left: 10px;
	cursor: pointer;
	box-sizing: border-box;
	padding-left: 30px;
	padding-right: 30px;
}

.creation {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}
</style>
