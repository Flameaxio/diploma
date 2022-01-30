<template>
	<v-app>
		<v-container>
			<div class="columns">
				<column-view
					v-bind:key="column.id"
					v-for="column in workspace.columns"
					:column="column"
				/>
			</div>
		</v-container>
	</v-app>
</template>

<script>
import { mapActions, mapState } from 'vuex'
import ColumnView from './ColumnView'

export default {
	name: 'WorkspacesView',
	components: { ColumnView },
	data() {
		return {}
	},
	computed: {
		...mapState(['workspace'])
	},
	methods: {
		...mapActions(['loadWorkspace']),
		async loadData() {
			await this.loadWorkspace()
		}
	},
	mounted() {
		this.loadData()
	}
}
</script>

<style lang="scss" scoped>
.columns {
	width: 100%;
	height: 100vh;
	display: flex;
	flex-direction: row;
	flex-wrap: nowrap;
	overflow-x: scroll;
}
</style>
