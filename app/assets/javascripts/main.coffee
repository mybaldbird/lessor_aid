Vue = require 'vue/dist/vue.js'
VueRouter = require 'vue-router'
VueResource = require 'vue-resource'
Vue.use VueRouter
Vue.use VueResource

router = new VueRouter
  mode: 'history',
  routes: [{
    path: '/signin'
    name: 'Sign In'
    component: require './components/sign_in.vue'
  }, {
    path: '/join'
    name: 'Sign Up'
    component: require './components/join.vue'
  }, {
    path: '/'
    name: 'Home'
    component: require './components/landing.vue'
  }, {
    path: '*'
    name: 'Page Not Found'
    component: require './components/page_not_found.vue'
  }]

# used for event handling
window.bus = new Vue
# before building anything, fetch the session user
currentUser = {}
Vue.http.get('/api/v1/session/show').then((response) ->
  currentUser = response.body
, -> # don't need to catch anything
).then ->
  new Vue
    router: router
    el: '#app'
    data: 
      currentUser: currentUser
      show: false
    components:
      appNav: require './components/app_nav.vue'
      appFlash: require './components/app_flash.vue'
    created: ->
      @setTitle()
      window.bus.$on 'signIn', (user) => @currentUser = user
      window.bus.$on 'signOut', => @currentUser = {}
    methods:
      setTitle: -> document.title = "LessorAid - " + @$route.name
    watch:
      '$route': -> @setTitle()
