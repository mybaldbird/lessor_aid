<template>
  <div>
    <div>name: <input v-model="name" /></div>
    <div>email: <input v-model="email" /></div>
    <div>password: <input type="password" v-model="password" /></div>
    <button @click="createAccount">Create an account</button>
  </div>
</template>

<script lang="coffee">
  module.exports =
    props: ['currentUser']
    data: ->
      name: ''
      email: ''
      password: ''
    beforeMount: -> @$router.replace '/' if @currentUser.name?
    methods:
      createAccount: ->
        @$http.post('/api/v1/users', {
          name: @name
          email: @email
          password: @password
        }).then (response) ->
          # success
          window.bus.$emit 'signIn', response.body
          @$router.replace '/'
        , (response) ->
          # error
          window.bus.$emit 'flash', 'Failed to create an account.', 'error'
          window.bus.$emit 'flashPush', response.body, 'error'
</script>
