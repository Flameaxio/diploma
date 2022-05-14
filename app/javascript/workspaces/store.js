import Vue from 'vue'
import Vuex from 'vuex'
import { ax as axios } from 'packs/axios'
Vue.use(Vuex)

export default new Vuex.Store({
	state: {
		workspaces: []
	},
	actions: {
		async loadWorkspaces({ commit }) {
			const url = '/workspaces.json'
			const { data: resp } = await axios.get(url)
			commit('setWorkspaces', resp)
		},
		async createWorkspace({ commit }, { name }) {
			const url = '/workspaces'
			const { data: resp } = await axios.post(url, {
				name: name
			})
			commit('addWorkspace', resp)
		}
	},
	mutations: {
		setWorkspaces(state, workspaces) {
			state.workspaces = workspaces
		},
		addWorkspace(state, workspace) {
			state.workspaces = [...state.workspaces, workspace]
		}
	}
})
