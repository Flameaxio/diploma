<template>
	<div class="column-container">
		<div class="header">
			<span class="name"> {{ column.name }} </span><br />
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
import { mapActions } from 'vuex'
import CardDetailsView from '../shared/CardDetailsView.vue'

export default {
	components: { TicketView, Drag, Drop },
	props: {
		column: { type: Object, required: true }
	},
	computed: {
		ticketCount() {
			return this.column.cards.length
		}
	},
	methods: {
		...mapActions(['moveTicket']),
		insert(el) {
			const id = el.data.id
			const toId = el.top.$el.classList[el.top.$el.classList.length - 1].slice(-1)
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

.name {
	padding-left: 10px;
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
