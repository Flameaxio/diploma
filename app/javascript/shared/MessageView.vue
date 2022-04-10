<template>
	<div class="wrapper">
		<div class="left">
			<div class="by">
				By <strong style="color: red">{{ cardLog.performedBy }}</strong>
			</div>
			<div v-html="cardLog.message" class="text" />
		</div>
		<div class="right">{{ new Date(cardLog.createdAt).toLocaleString('sv-SE') }}</div>
	</div>
</template>

<script>
export default {
	props: {
		cardLog: { type: Object, required: true }
	}
}
</script>

<style lang="scss" scoped>
.wrapper {
	border-left: 3px solid gray;
	padding-left: 15px;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}
</style>
