<template>
  <div>
    <span>LessorAid</span>
    <template v-if="signedIn">
      <ul>
        <li>nav1</li>
        <li>nav2</li>
        <li>nav3</li>
      </ul>
      <ul>
        <li>Welcome {{ currentUser.name }}</li>
        <li><a href="javascript:void(0);" @click="signOut">sign out</a></li>
      </ul>
    </template>
    <ul v-else>
      <li><router-link to="/signin">sign in</router-link></li>
      <li>sign up</li>
    </ul>
  </div>
</template>

<script lang="coffee">
  module.exports =
    props: ['currentUser']
    computed:
      signedIn: -> @currentUser.name?
    methods:
      signOut: ->
        @$http.delete('/api/v1/session/destroy').then (response) ->
          window.bus.$emit 'signOut'
          @$router.push '/'
          window.bus.$emit 'flash', 'You have been signed out.'
        , (response) ->
          # TODO: figure out the various error cases
          window.bus.$emit 'flash', 'Sign out failed, please try again.', 'error'
</script>
