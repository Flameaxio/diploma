<template>
	<v-app>
		<v-container>
			<div class="columns">
				<column-view
					v-bind:key="column.id"
					v-for="column in workspace.columns"
					:column="column"
					@open="open"
				/>
			</div>
			<template v-if="isOpen">
				<div class="backdrop" @click="close"></div>
				<div class="card-view">
					<div class="top"><v-icon class="icon" @click="close"> mdi-close </v-icon></div>
					<card-details-view :card="selectedTicket" :columns="workspace.columns" />
				</div>
			</template>
		</v-container>
	</v-app>
</template>

<script>
import { mapActions, mapState } from 'vuex'
import ColumnView from './ColumnView'
import CardDetailsView from '../shared/CardDetailsView'

export default {
	name: 'WorkspacesView',
	components: { ColumnView, CardDetailsView },
	data() {
		return {
			isOpen: false,
			selectedTicket: null
		}
	},
	computed: {
		...mapState(['workspace'])
	},
	methods: {
		...mapActions(['loadWorkspace']),
		async loadData() {
			await this.loadWorkspace()
		},
		open(target) {
			this.selectedTicket = target
			this.isOpen = true
		},
		close() {
			this.isOpen = false
			this.selectedTicket = null
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

.backdrop {
	position: absolute;
	top: 0;
	left: 0;
	width: 100vw;
	height: 100vh;
	background: #666666;
	cursor: pointer;
}

.card-view {
	position: absolute;
	top: 1vh;
	left: 1vw;
	width: 98vw;
	height: 98vh;
	background: white;
	border: 1px solid black;
	border-radius: 5px;
}

.top {
	width: 100%;
	height: 32px;
	display: flex;
	flex-direction: row-reverse;
	border-bottom: 1px solid #333333;
	.icon {
		height: 32px;
		width: 32px;
		font-size: 20px;
		display: flex;
		justify-content: center;
		align-items: center;
		background: transparent;
		border: none;
		cursor: pointer;
	}
}
</style>
