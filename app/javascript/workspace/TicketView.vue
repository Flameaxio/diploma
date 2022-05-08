<template>
	<div>
		<div class="ticket-wrapper" @click="$emit('open', ticket)">
			<span class="title">{{ ticket.title }}</span>
			<div class="footer">
				<span class="scoped-id">#{{ ticket.scopedId }}</span>
				<span class="assignee">{{ ticket.assignee }}</span>
			</div>
		</div>
	</div>
</template>

<script>
export default {
	props: {
		ticket: { type: Object, required: true }
	}
}
</script>

<style scoped lang="scss">
.ticket-wrapper {
	box-sizing: border-box;
	padding: 5px;
	margin-top: 10px;
	width: 100%;
	background-color: #ffffdd;
	display: flex;
	flex-direction: column;
	border-radius: 5px;
	border-bottom: 1px solid #c5c5c5;
	cursor: pointer;
}
.footer {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	margin-top: 5px;
}
.scoped-id {
	width: 100%;
}

.assignee {
	display: flex;
	align-items: center;
	width: 70%;
	font-size: 12px;
	text-overflow: ellipsis;
}
</style>
