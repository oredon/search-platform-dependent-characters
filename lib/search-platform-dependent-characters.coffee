SearchPlatformDependentCharactersView = require './search-platform-dependent-characters-view'

module.exports =
  searchPlatformDependentCharactersView: null

  activate: (state) ->
    @searchPlatformDependentCharactersView = new SearchPlatformDependentCharactersView(state.searchPlatformDependentCharactersViewState)

  deactivate: ->
    @searchPlatformDependentCharactersView.destroy()

  serialize: ->
    searchPlatformDependentCharactersViewState: @searchPlatformDependentCharactersView.serialize()
