import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

Vue.component('app', App)

document.addEventListener('DOMContentLoaded', () => {
	console.log('homepage')
	new Vue({
		el: '[data-behavior=app]'
	})
})
