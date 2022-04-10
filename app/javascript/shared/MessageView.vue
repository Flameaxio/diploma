<template>
	<div class="wrapper">
		<div class="left">
			<div class="by">By User</div>
			<div class="text">{{ cardLog.message }}</div>
		</div>
		<div class="right">{{ cardLog.createdAt }}</div>
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
