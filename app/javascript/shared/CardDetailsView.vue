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
						rounded
						:items="columnSelectItems"
						dense
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
import { mapActions } from 'vuex'
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
			messageContent: ''
		}
	},
	async created() {
		this.cardInfo = await this.loadTicket(this.card.id)
		this.selectedStatus = this.cardInfo.status
		this.loading = false
	},
	mounted() {
		setTimeout(this.scrollToElement, 50)
	},
	methods: {
		...mapActions(['loadTicket', 'postMessage']),
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

			container.scrollTop = container.scrollHeight
		}
	},
	computed: {
		columnSelectItems() {
			return this.columns.map((c) => ({
				value: c.name,
				text: c.name
			}))
		}
	}
}
</script>

<style lang="scss">
.v-select__slot {
	display: flex;
	flex-direction: row;
	height: 20px;
}
.v-autocomplete__content {
	position: absolute;
}

.v-select-list {
	background: white;
	border: 1px solid black;
	border-radius: 3px;
}

.v-list-item__title {
	cursor: pointer;
}
</style>

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
</style>
