import Vue from 'vue'
import Vuex from 'vuex'
import { ax as axios } from 'packs/axios'
Vue.use(Vuex)

export default new Vuex.Store({
	state: {
		workspace: {},
		availableUsers: [],
		cards: {},
		cardsPagy: { page: 1, items: 30 },
		moreToLoad: true
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
		async moveTicket({ state, commit }, { id, fromId, toId }) {
			const url = `/workspaces/${state.workspace.id}/move_card`
			await axios.post(url, {
				card_id: id,
				to_id: toId
			})
			commit('moveTicket', { id, fromColumnId: fromId, toColumnId: toId })
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
		},
		async createColumn({ state, commit }, { name, url, body }) {
			const requestUrl = `/workspaces/${state.workspace.id}/columns`
			const { data: resp } = await axios.post(requestUrl, { name, url, body })
			commit('addColumn', resp.data.attributes)
		},
		async deleteColumn({ state, commit }, { id }) {
			const requestUrl = `/workspaces/${state.workspace.id}/columns/${id}`
			await axios.delete(requestUrl)
			commit('deleteColumn', id)
		},
		async loadCards({ state, commit }, { page }) {
			if (!state.workspace.id) return false

			const url = `/workspaces/${state.workspace.id}/cards.json`
			const { data: resp } = await axios.get(url, {
				params: { per_page: state.cardsPagy.items, page: page }
			})
			const transformedCards = Object.keys(resp.cards).reduce(
				(previousValue, currentValue) => {
					return Object.assign(previousValue, {
						[currentValue]: resp.cards[currentValue]
					})
				},
				{}
			)
			commit('setCards', transformedCards)
			commit('setCardsPagy', resp.pagy)
			commit('setMoreToLoad', transformedCards)
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
		},
		addColumn(state, column) {
			state.workspace.columns = [...state.workspace.columns, column]
		},
		deleteColumn(state, columnId) {
			state.workspace.columns = state.workspace.columns.filter(
				({ id }) => columnId !== id
			)
		},
		setCards(state, newCards) {
			state.cards = Object.keys(newCards).reduce((obj, columnId) => {
				return {
					...obj,
					[columnId]: {
						items: (state.cards[columnId]?.items ?? [])
							.concat(newCards[columnId].items)
							.filter(Boolean),
						pagy: newCards[columnId].pagy
					}
				}
			}, {})
		},
		setCardsPagy(state, cardsPagy) {
			state.cardsPagy = cardsPagy
		},
		moveTicket({ cards }, { id, fromColumnId, toColumnId }) {
			const card = cards[fromColumnId]?.items.find((i) => i.id === id)
			if (!card) return

			cards[fromColumnId].items = cards[fromColumnId].items.filter((i) => i.id !== id)
			cards[toColumnId]?.items.push({ ...card, columnId: toColumnId })
			cards[toColumnId].pagy = {
				...cards[toColumnId].pagy,
				count: cards[toColumnId].pagy.count + 1
			}
		},
		setMoreToLoad(state, transformedCards) {
			state.moreToLoad = !!Object.values(transformedCards).filter((c) => c.items.length)
				.length
		}
	}
})
