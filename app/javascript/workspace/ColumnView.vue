<template>
	<div class="column-container">
		<div class="header">
			<div class="top">
				<span class="name"> {{ column.name }} </span><br />
				<edit-column :column="column" @manipulate-column="updateColumn" />
			</div>
			<span class="ticket-number">
				<v-icon> mdi-note-alert-outline </v-icon>
				{{ ticketCount }}
			</span>
		</div>
		<div class="ticket-list">
			<drop @drop="insert" :class="`column-${column.id}`">
				<drag v-for="ticket in column.cards" :data="ticket" :key="ticket.id">
					<ticket-view :ticket="ticket" @open="$emit('open', $event)" />
				</drag>
			</drop>
		</div>
	</div>
</template>

<script>
import { Drag, Drop } from 'vue-easy-dnd'
import TicketView from './TicketView'
import EditColumn from './EditColumn'
import { mapActions } from 'vuex'

export default {
	components: { TicketView, Drag, Drop, EditColumn },
	props: {
		column: { type: Object, required: true }
	},
	computed: {
		ticketCount() {
			return this.column.cards.length
		}
	},
	methods: {
		...mapActions(['moveTicket', 'updateColumn']),
		insert(el) {
			const id = el.data.id
			const toId = el.top.$el.classList[el.top.$el.classList.length - 1].match(/\d+/g)[0]
			this.moveTicket({ id: id, toId: toId })
		}
	}
}
</script>

<style lang="scss" scoped>
.ticket-list {
	height: calc(100% - 50px);
}

.column-container {
	width: 180px;
	padding: 5px 5px;
	margin-left: 10px;
	background-color: #efefef;
}

.header {
	width: calc(100% + 10px);
	margin-left: -5px;
	border-bottom: 1px solid #b4b9b9;
}

.top {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	padding-left: 10px;
	padding-right: 10px;
}

.name {
	font-weight: 600;
	font-size: 14px;
}

.ticket-number {
	margin-left: 10px;
	color: gray;
	font-size: 14px;
}
.dnd-drop {
	height: 100%;
}
</style>
