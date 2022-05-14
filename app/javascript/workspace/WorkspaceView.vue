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
				<div class="create-column">
					<edit-column
						:column="{ id: null, name: '' }"
						icon="mdi-plus-circle"
						:icon-size="96"
						@manipulate-column="createColumn"
					></edit-column>
				</div>
			</div>
			<template v-if="isOpen">
				<div class="card-view">
					<v-dialog v-model="isOpen">
						<v-card>
							<v-card-title>
								<div class="top">
									<v-icon class="icon" @click="close"> mdi-close </v-icon>
								</div>
								<v-divider></v-divider>
							</v-card-title>

							<v-card-text>
								<card-details-view :card="selectedTicket" :columns="workspace.columns" />
							</v-card-text>
						</v-card>
					</v-dialog>
				</div>
			</template>
		</v-container>
	</v-app>
</template>

<script>
import { mapActions, mapState } from 'vuex'
import ColumnView from './ColumnView'
import CardDetailsView from '../shared/CardDetailsView'
import EditColumn from './EditColumn'

export default {
	name: 'WorkspacesView',
	components: { ColumnView, CardDetailsView, EditColumn },
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
		...mapActions(['loadWorkspace', 'loadUsers', 'createColumn']),
		async loadData() {
			await this.loadWorkspace()
			await this.loadUsers()
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

<style lang="scss">
.v-application--wrap {
	min-height: calc(100vh - 48px) !important;
	max-width: 100vw;
}
.container {
	max-height: calc(100vh - 48px) !important;
}
</style>

<style lang="scss" scoped>
.columns {
	width: 100%;
	height: calc(100vh - 60px);
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
	height: calc(100vh - 48px);
	background: #666666;
	cursor: pointer;
}

.top {
	width: 100%;
	height: 32px;
	display: flex;
	flex-direction: row-reverse;
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

.create-column {
	width: 180px;
	padding: 5px 5px;
	margin-left: 10px;
	background-color: #efefef;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>
