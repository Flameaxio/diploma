import Vue from 'vue'
import WorkspaceView from '../workspace/WorkspaceView.vue'
import Vuetify from 'vuetify'
import store from '../workspace/store'
import '@mdi/font/css/materialdesignicons.css'
import 'material-design-icons-iconfont/dist/material-design-icons.css'

Vue.use(Vuetify)
Vue.component('workspaceView', WorkspaceView)

document.addEventListener('DOMContentLoaded', () => {
	console.log('workspace')
	new Vue({
		el: '[data-behavior=workspace]',
		vuetify: new Vuetify({ icons: { iconfont: 'mdi' } }),
		store
	})
})
