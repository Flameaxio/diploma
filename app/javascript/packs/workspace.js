import Vue from 'vue/dist/vue.esm'
import WorkspaceView from '../workspace/WorkspaceView.vue'
import Vuetify from 'vuetify'
import store from '../workspace/store'
import '@mdi/font/css/materialdesignicons.css'
import 'material-design-icons-iconfont/dist/material-design-icons.css'

Vue.use(Vuetify)
Vue.component('workspaceView', WorkspaceView)

document.addEventListener('DOMContentLoaded', () => {
	new Vue({
		el: '[data-behavior=workspace]',
		vuetify: new Vuetify({ icons: { iconfont: 'mdi' } }),
		store
	})
})
