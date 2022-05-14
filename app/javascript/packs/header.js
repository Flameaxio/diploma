import Vue from 'vue'
import HeaderView from '../header/HeaderView.vue'
import Vuetify from 'vuetify'
import store from '../header/store'
import 'vuetify/dist/vuetify.min.css'
import '@mdi/font/css/materialdesignicons.css'
import 'material-design-icons-iconfont/dist/material-design-icons.css'
import VueTrix from 'vue-trix'

window.VueTrix = VueTrix

Vue.use(Vuetify)
Vue.use(VueTrix)
Vue.component('headerView', HeaderView)

document.addEventListener('DOMContentLoaded', () => {
	new Vue({
		el: '[data-behavior=header]',
		vuetify: new Vuetify({ icons: { iconfont: 'mdi' } }),
		store
	})
})
