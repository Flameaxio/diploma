import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
Vue.use(Vuex)

export default new Vuex.Store({
	state: {
		workspace: {}
	},
	actions: {
		async loadWorkspace({ commit }) {
			const url = `${window.location.pathname}.json`
			const resp = await axios.get(url)
			commit('setWorkspace', resp.data.data.attributes)
		},
		async moveTicket({ commit }, { id, toId }) {
			const csrf = document
				.querySelector("meta[name='csrf-token']")
				.getAttribute('content')
			const url = `${window.location.pathname}/move_card`
			const resp = await axios.post(
				url,
				{
					card_id: id,
					to_id: toId
				},
				{
					headers: {
						'X-CSRF-Token': csrf
					}
				}
			)
			commit('setWorkspace', resp.data.data.attributes)
		},
		async loadTicket({ commit }, id) {
			const url = `${window.location.pathname}/cards/${id}.json`
			const resp = await axios.get(url)
			return resp.data.data.attributes
		}
	},
	mutations: {
		setWorkspace(state, workspace) {
			state.workspace = workspace
		}
	}
})
