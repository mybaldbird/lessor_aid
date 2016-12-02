<style>
  .error {
    color: #f00;
  }
  .warning {
    color: #f80;
  }
  .message {
    color: #000;
  }
</style>

<template>
  <div>
    <div v-for="flash in flashes" :class="flash.type">
      {{ flash.message }}
    </div>
  </div>
</template>

<script lang="coffee">
  module.exports =
    data: ->
      flashes: []
    created: ->
      window.bus.$on 'flash', @flash
      window.bus.$on 'flashPush', @flashPush
    methods:
      clearFlash: -> @flashes = []
      flash: (message, type) ->
        @clearFlash()
        @flashPush message, type
      flashPush: (message, type) ->
        type = 'message' unless type in ['error', 'warning']
        @flashes.push
          message: message
          type: type
    watch:
      '$route': -> @clearFlash()
</script>
