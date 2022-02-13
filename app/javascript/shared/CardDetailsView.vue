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
		</div>
	</div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
	props: {
		card: { type: Object, required: true },
		columns: { type: Array, required: true }
	},
	data() {
		return {
			cardInfo: {},
			loading: true,
			selectedStatus: ''
		}
	},
	async mounted() {
		this.cardInfo = await this.loadTicket(this.card.id)
		this.selectedStatus = this.cardInfo.status
		this.loading = false
	},
	methods: {
		...mapActions(['loadTicket']),
		formattedDateTime(dateString) {
			return new Date(dateString).toLocaleString('sv-SE') // e.g. 2022-02-13 13:17:43
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

<style lang="scss">
.v-select__slot {
	display: flex;
	flex-direction: row;
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
