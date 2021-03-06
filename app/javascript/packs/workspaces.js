import Vue from 'vue'
import WorkspacesView from '../workspaces/WorkspacesView.vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import '@mdi/font/css/materialdesignicons.css'
import 'material-design-icons-iconfont/dist/material-design-icons.css'
import store from '../workspaces/store'

Vue.use(Vuetify)
Vue.component('workspacesView', WorkspacesView)

document.addEventListener('DOMContentLoaded', () => {
	new Vue({
		el: '[data-behavior=workspaces]',
		vuetify: new Vuetify({ icons: { iconfont: 'mdi' } }),
		store
	})
})
