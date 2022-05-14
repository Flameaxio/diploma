<template>
	<div class="text-center">
		<v-dialog v-model="dialog" class="dialog">
			<template v-slot:activator="{ on, attrs }">
				<v-btn v-bind="attrs" v-on="on" small class="create-ticket">Create Ticket</v-btn>
			</template>

			<v-card class="card">
				<div>
					<v-card-title class="text-h5 grey lighten-2 flex-row justify-space-between">
						<span>Create Ticket</span><v-icon @click="close">mdi-close</v-icon>
					</v-card-title>

					<v-card-text>
						<div class="main">
							<div class="card-info">
								<div class="list-item">
									<div class="list-title">Status</div>
									<div class="list-body">
										<v-autocomplete
											v-model="selectedStatus"
											dense
											:items="statusItems"
											height="30"
											class="autocomplete"
										></v-autocomplete>
									</div>
								</div>
								<div class="list-item">
									<div class="list-title">Assignee</div>
									<div class="list-body">
										<v-autocomplete
											v-model="selectedUser"
											dense
											:items="userItems"
											height="30"
											class="autocomplete"
										></v-autocomplete>
									</div>
								</div>
							</div>
							<div class="details-group">
								<div class="title">
									<v-text-field label="Title" v-model="title" dense />
								</div>
								<div class="body">
									<VueTrix v-model="body" placeholder="Enter body" />
								</div>
							</div>
						</div>
					</v-card-text>
				</div>
				<div>
					<v-divider></v-divider>

					<v-card-actions class="actions">
						<v-spacer></v-spacer>
						<v-btn color="primary" @click="saveAndClose"> Save </v-btn>
					</v-card-actions>
				</div>
			</v-card>
		</v-dialog>
	</div>
</template>

<script>
import VueTrix from 'vue-trix'
import { mapActions } from 'vuex'

export default {
	components: { VueTrix },
	props: {
		availableUsers: { type: Array, required: true },
		availableColumns: { type: Array, required: true },
		currentWorkspace: { type: Object, reqiored: true }
	},
	data() {
		return { dialog: false, selectedStatus: 0, selectedUser: 0, title: '', body: '' }
	},
	computed: {
		statusItems() {
			return this.availableColumns.map((c) => ({
				value: c.id,
				text: c.name
			}))
		},
		userItems() {
			return this.availableUsers.map((u) => ({ value: u.id, text: u.fullName }))
		}
	},
	methods: {
		...mapActions(['createTicket']),
		close() {
			this.dialog = false
		},
		async saveAndClose() {
			const params = {
				title: this.title,
				body: this.body,
				assignee_id: this.selectedUser,
				column_id: this.selectedStatus
			}
			await this.createTicket({ workspaceId: this.currentWorkspace.id, ticket: params })
		}
	}
}
</script>

<style lang="scss" scoped>
.create-ticket {
	background-color: #f9aa33 !important;
	color: black !important;
	margin-right: 20px;
}
.card {
	height: 50vh;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.main {
	padding: 30px;
	display: flex;
	width: calc(100% - 60px);
	height: calc(100% - 90px);
	justify-content: space-between;
}
.card-info {
	height: 100%;
	width: 25%;
	display: flex;
	flex-direction: column;
	background: inherit;
	.scoped-number {
		display: flex;
		flex-direction: row-reverse;
		font-size: 24px;
		font-weight: bold;
	}
}
.details-group {
	height: 100%;
	width: 74%;
	display: flex;
	flex-direction: column;
	.title {
		font-size: 32px;
		font-weight: bold;
	}
	.body {
		margin-top: 16px;
		font-size: 16px;
	}
	.history {
		margin-top: 20px;
		border-top: 1px solid black;
		padding-top: 20px;
		overflow-y: scroll;
		max-height: 800px;
		& > * {
			margin-top: 15px;
		}
	}
	.editor {
		.actions {
			margin-top: 15px;
			display: flex;
			width: 100%;
			flex-direction: row-reverse;

			button {
				color: white;
				margin-left: 10px;
				border-radius: 5px;
			}
		}
	}
}

.list-item {
	width: 100%;
	height: 30px;
	border-bottom: 1px solid #333333;
	display: flex;
	flex-direction: row;
	align-items: center;
	.list-title {
		width: 20%;
	}
	.list-body {
		display: flex;
		flex-direction: row;
	}
}

.v-input {
	margin-top: 16px !important;
}

.trix-content {
	min-height: 800px !important;
	overflow-y: auto;
}
</style>
