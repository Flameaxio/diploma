<template>
	<div>
		<div class="ticket-wrapper" @click="$emit('open', ticket)">
			<span class="title">{{ ticket.title }}</span>
			<div class="footer">
				<span class="scoped-id">#{{ ticket.scopedId }}</span>
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
	margin-top: 5px;
}
</style>
