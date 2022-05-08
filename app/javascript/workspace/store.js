import Vue from 'vue'
import Vuex from 'vuex'
import { ax as axios } from 'packs/axios'
Vue.use(Vuex)

export default new Vuex.Store({
	state: {
		workspace: {},
		availableUsers: []
	},
	actions: {
		async loadWorkspace({ commit }) {
			const url = `${window.location.pathname}.json`
			const { data: resp } = await axios.get(url)
			commit('setWorkspace', resp.data.attributes)
		},
		async loadUsers({ state, commit }) {
			const url = `/workspaces/${state.workspace.id}/users.json`
			const { data: resp } = await axios.get(url)
			commit(
				'setAvailableUsers',
				resp.data.map((u) => u.attributes)
			)
		},
		async moveTicket({ state, commit }, { id, toId }) {
			const url = `/workspaces/${state.workspace.id}/move_card`
			const resp = await axios.post(url, {
				card_id: id,
				to_id: toId
			})
			commit('setWorkspace', resp.data.data.attributes)
		},
		async loadTicket({ state, commit }, id) {
			const url = `/workspaces/${state.workspace.id}/cards/${id}.json`
			const { data: resp } = await axios.get(url)
			return resp.data.attributes
		},
		async postMessage({ state, commit }, { id, message }) {
			const url = `/workspaces/${state.workspace.id}/cards/${id}/post_message`
			const { data: resp } = await axios.post(url, { message })
			return resp.data.attributes
		},
		async changeAssignee({ state, commit }, { id, assigneeId }) {
			const url = `/workspaces/${state.workspace.id}/change_assignee`
			const { data: resp } = await axios.post(url, {
				assignee_id: assigneeId,
				card_id: id
			})
			commit('setWorkspace', resp.data.attributes)
		},
		async updateColumn({ state, commit }, { id, name, url, body }) {
			const requestUrl = `/workspaces/${state.workspace.id}/columns/${id}`
			const { data: resp } = await axios.put(requestUrl, { name, url, body })
			commit('updateColumn', { id, column: resp.data.attributes })
		}
	},
	mutations: {
		setWorkspace(state, workspace) {
			state.workspace = workspace
		},
		setAvailableUsers(state, users) {
			state.availableUsers = users
		},
		updateColumn(state, { id, column }) {
			const newColumns = [...state.workspace.columns]
			newColumns[newColumns.findIndex((c) => c.id === id)] = column
			state.workspace.columns = newColumns
		}
	}
})
