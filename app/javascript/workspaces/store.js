import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
Vue.use(Vuex)

export default new Vuex.Store({
	state: {
		workspaces: []
	},
	actions: {
		async loadWorkspaces({ commit }) {
			const url = '/workspaces.json'
			const resp = await axios.get(url)
			commit('setWorkspaces', resp.data)
		}
	},
	mutations: {
		setWorkspaces(state, workspaces) {
			state.workspaces = workspaces
		}
	}
})
