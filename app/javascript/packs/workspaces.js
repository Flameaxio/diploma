import Vue from 'vue'
import WorkspacesView from '../workspaces/WorkspacesView.vue'
import Vuetify from 'vuetify'
import store from '../workspaces/store'

Vue.use(Vuetify)
Vue.component('workspacesView', WorkspacesView)

document.addEventListener('DOMContentLoaded', () => {
	console.log('workspaces')
	new Vue({
		el: '[data-behavior=workspaces]',
		vuetify: new Vuetify(),
		store
	})
})
