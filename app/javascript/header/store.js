import Vue from 'vue'
import Vuex from 'vuex'
import { ax as axios } from 'packs/axios'
Vue.use(Vuex)

export default new Vuex.Store({
	actions: {
		async createTicket({}, { workspaceId, ticket }) {
			const url = `/workspaces/${workspaceId}/cards/`
			await axios.post(url, {
				ticket
			})
			window.location.reload()
		}
	}
})
