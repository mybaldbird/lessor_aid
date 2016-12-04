<style lang="sass">
  .navbar {
    background: rgb(39, 40, 34);
    color: rgb(230, 219, 116);
    height: 3em;
    span {
      font-size: 1.5em;
      float: left;
    }
    ul {
      display: inline-block;
      margin: 0;
      padding: 0;
      list-style: none;
      li {
        height: 2em;
        line-height: 1.75em;
        float: left;
      }
    }
    ul.left {
      float: left;
      li {
        margin-left: 1em;
      }
    }
    ul.right {
      float: right;
      li {
        margin-right: 1em;
      }
    }
    a:link, a:visited {
      color: rgb(102, 217, 239);
    }
    a:hover {
      color: rgb(249, 88, 164);
    }
    a:active {
      color: rgb(249, 38, 114);
    }
    div.clear {
      clear: both;
    }
  }
</style>

<template>
  <div class="navbar">
    <span>LessorAid</span>
    <template v-if="signedIn">
      <ul class="left">
        <li>nav1</li>
        <li>nav2</li>
        <li>nav3</li>
      </ul>
      <ul class="right">
        <li>Welcome {{ currentUser.name }}</li>
        <li><a href="javascript:void(0);" @click="signOut">sign out</a></li>
      </ul>
    </template>
    <ul class="right" v-else>
      <li><router-link to="/signin">sign in</router-link></li>
      <li><router-link to="/join">sign up</router-link></li>
    </ul>
    <div class="clear"></div>
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
