<template>
  <div>
    <div v-if="loading">Signing in...</div>
    <template v-else>
      <div>name: <input v-model="name" /></div>
      <div>password: <input type="password" v-model="password" /></div>
      <button @click="signIn">Sign in</button>
    </template>
  </div>
</template>

<script lang="coffee">
  module.exports =
    props: ['currentUser']
    data: ->
      name: ''
      password: ''
      loading: false
    beforeMount: -> @$router.replace '/' if @currentUser.name?
    methods:
      signIn: ->
        @loading = true
        @$http.post('/api/v1/session/create', {
          name: @name
          password: @password
        }).then (response) ->
          # success
          @loading = false
          window.bus.$emit 'signIn', response.body
          @$router.replace '/'
        , (response) ->
          # error
          @loading = false
          window.bus.$emit 'flash', 'Sign in failed, please try again.', 'error'
</script>
