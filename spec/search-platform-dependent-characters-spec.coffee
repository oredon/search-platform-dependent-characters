{WorkspaceView} = require 'atom'
SearchPlatformDependentCharacters = require '../lib/search-platform-dependent-characters'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "SearchPlatformDependentCharacters", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('search-platform-dependent-characters')

  describe "when the search-platform-dependent-characters:checkSelection event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.search-platform-dependent-characters')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch atom.workspaceView.element, 'search-platform-dependent-characters:checkSelection'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.search-platform-dependent-characters')).toExist()
        atom.commands.dispatch atom.workspaceView.element, 'search-platform-dependent-characters:checkSelection'
        expect(atom.workspaceView.find('.search-platform-dependent-characters')).not.toExist()
