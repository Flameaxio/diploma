<template>
	<v-app-bar dense elevation="24" class="bar" elevate-on-scroll
		><div class="header-container">
			<div class="logged-in">
				<span>Logged in as {{ currentUser.fullName }}</span>
				<a href="/users/sign_out">Logout</a>
			</div>
			<create-ticket
				v-if="currentWorkspace"
				:available-users="availableUsers"
				:available-columns="currentWorkspace.columns"
				:current-workspace="currentWorkspace"
			/></div
	></v-app-bar>
</template>
<script>
import CreateTicket from './CreateTicket'

export default {
	components: { CreateTicket },
	props: {
		currentUser: { type: Object, required: true },
		currentWorkspace: { type: Object, required: false },
		availableUsers: { type: Array, required: false }
	},
	computed: {},
	methods: {}
}
</script>

<style lang="scss" scoped>
.bar {
	background-color: #344955 !important;
}
.header-container {
	width: 100vw;
	max-width: 100vw;
	height: 20px;
	display: flex;
	flex-direction: row-reverse;
	box-sizing: border-box;
	padding-left: 50px;
	padding-right: 50px;
	align-items: center;
}

.logged-in {
	color: white;
	a {
		color: #f9aa33;
	}
}
</style>
