import Vue from 'vue/dist/vue.esm'
import WorkspacesView from '../workspaces/WorkspacesView.vue'
import Vuetify from 'vuetify'
import store from '../workspaces/store'

Vue.use(Vuetify)
Vue.component('workspacesView', WorkspacesView)

document.addEventListener('DOMContentLoaded', () => {
	new Vue({
		el: '[data-behavior=workspaces]',
		vuetify: new Vuetify(),
		store
	})
})
