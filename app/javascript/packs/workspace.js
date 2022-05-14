import Vue from 'vue'
import WorkspaceView from '../workspace/WorkspaceView.vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import store from '../workspace/store'
import '@mdi/font/css/materialdesignicons.css'
import 'material-design-icons-iconfont/dist/material-design-icons.css'
import VueScrollTo from 'vue-scrollto'

Vue.use(VueScrollTo, {
	container: '.history'
})
Vue.use(Vuetify)
Vue.use(VueTrix)
Vue.component('workspaceView', WorkspaceView)

document.addEventListener('DOMContentLoaded', () => {
	new Vue({
		el: '[data-behavior=workspace]',
		vuetify: new Vuetify({ icons: { iconfont: 'mdi' } }),
		store
	})
})
