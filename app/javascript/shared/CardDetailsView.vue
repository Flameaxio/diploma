<template>
	<div class="main" v-if="!loading">
		<div class="card-info">
			<div class="scoped-number">#{{ card.scopedId }}</div>
			<div class="list-item">
				<div class="list-title">Created on</div>
				<div class="list-body">{{ formattedDateTime(cardInfo.createdAt) }}</div>
			</div>
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
						v-model="selectedAssignee"
						dense
						:items="userItems"
						height="30"
						class="autocomplete"
					></v-autocomplete>
				</div>
			</div>
		</div>
		<div class="details-group">
			<div class="title">{{ cardInfo.title }}</div>
			<div class="body">{{ cardInfo.body }}</div>
			<div class="history" ref="container">
				<div class="messages" :key="cardLog.id" v-for="cardLog in cardInfo.cardLogs">
					<MessageView :card-log="cardLog" />
				</div>
				<div class="editor">
					<VueTrix v-model="messageContent" placeholder="Enter content" />
					<div class="actions">
						<v-btn color="error" rounded @click="messageContent = ''">Clear</v-btn
						><v-btn color="primary" rounded @click="submitMessage">Send</v-btn>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import { mapActions, mapState } from 'vuex'
import MessageView from './MessageView'
import VueTrix from 'vue-trix'

export default {
	components: { MessageView, VueTrix },
	props: {
		card: { type: Object, required: true },
		columns: { type: Array, required: true }
	},
	data() {
		return {
			cardInfo: {},
			loading: true,
			selectedStatus: '',
			selectedAssignee: '',
			messageContent: ''
		}
	},
	async created() {
		await this.loadData()
		this.selectedStatus = this.cardInfo.status.id
		this.selectedAssignee = this.cardInfo.assignee?.id || ''
		this.loading = false
	},
	mounted() {
		setTimeout(this.scrollToElement, 50)
	},
	methods: {
		...mapActions(['loadTicket', 'postMessage', 'moveTicket', 'changeAssignee']),
		formattedDateTime(dateString) {
			return new Date(dateString).toLocaleString('sv-SE') // e.g. 2022-02-13 13:17:43
		},
		async submitMessage() {
			this.cardInfo.cardLogs.push(
				await this.postMessage({ id: this.card.id, message: this.messageContent })
			)
			this.messageContent = ''
		},
		scrollToElement() {
			const container = this.$refs.container
			if (!container) return

			container.scrollTop = container.scrollHeight
		},
		async loadData() {
			this.cardInfo = await this.loadTicket(this.card.id)
			setTimeout(this.scrollToElement, 50)
		}
	},
	computed: {
		...mapState(['availableUsers']),
		statusItems() {
			return this.columns.map((c) => ({
				value: c.id,
				text: c.name
			}))
		},
		userItems() {
			return this.availableUsers.map((u) => ({ value: u.id, text: u.fullName }))
		}
	},
	watch: {
		async selectedStatus(newStatus, oldStatus) {
			if (newStatus !== oldStatus && oldStatus > 0) {
				await this.moveTicket({ id: this.card.id, toId: newStatus })
				await this.loadData()
			}
		},
		async selectedAssignee(newAssignee, oldAssignee) {
			if (newAssignee !== oldAssignee && oldAssignee > 0) {
				await this.changeAssignee({ id: this.card.id, assigneeId: newAssignee })
				await this.loadData()
			}
		}
	}
}
</script>

<style lang="scss"></style>

<style lang="scss" scoped>
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
</style>
